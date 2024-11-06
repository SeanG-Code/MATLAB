classdef uavAnimation < handle
    properties
        body_points        % Location of points prior to rotation
        left_motor_points  % Location of points prior to rotation
        right_motor_points % Location of points prior to rotation
        arm_points         % Location of points prior to rotation
        animation_handles  % Handles to redraw shape
        animate            % Flag to keep track of if we should animate
    end
    methods
        function self = uavAnimation(Param)
            % Drawing Flags ----------------------------------------------
            self.animate   = Param.animate;
            
            % Unpack the parameters --------------------------------------
            body_size      = Param.body_size     ;
            motor_diameter = Param.motor_diameter;
            d              = Param.d             ;

            % Create the points ------------------------------------------
            angle = linspace(0,2*pi,10);
            self.left_motor_points  = [ cos(angle); sin(angle)]*motor_diameter/2 + [ d;0]; % horizontal; vertical in the vehicle body frame
            self.right_motor_points = [ cos(angle); sin(angle)]*motor_diameter/2 + [-d;0]; % horizontal; vertical in the vehicle body frame
            self.body_points = [ 
                 body_size/2, -body_size/2;
                 body_size/2,  body_size/2;
                -body_size/2,  body_size/2;
                -body_size/2, -body_size/2;
               ]'; % horizontal; vertical in the vehicle body frame (after transpose)
            self.arm_points = [ -d,  d;
                                 0,  0];

            % Initial State ---------------------------------------------
            state = [Param.h_0; Param.z_0; Param.theta_0; Param.h_dot_0; Param.z_dot_0; Param.theta_dot_0];

            % Draw the vehcile ------------------------------------------
            % If the flag is set to allow animation
            if self.animate
                % Create a figure that is docked to Matlab
                figure('Windowstyle','docked','name',"Animation");
                clf; % Clear the figure
                hold on; % Hold to allow plotting multiple things on one axis.
                [left_motor_points, right_motor_points, body_points, arm_points] = self.get_points(state); % Get the location of the points on the drawing
                self.draw(left_motor_points, right_motor_points, body_points, arm_points) % Draw those points
                plot(Param.hlim, zeros(size(Param.hlim)),"-k","LineWidth",Param.line_width); % Draw Ground
                xlabel("Position Horizontal (m)") % Label for the x axis
                ylabel("Position Vertical  (m)") % Label for the y axis
                axis("equal"); % Make sure 1 meter is the same size in each direction
                xlim(Param.hlim) % Limits for the x axis
                ylim(Param.vlim) % Limits for the y axis
                grid on; % Turn on the grid
            end
        end
        function update(self, state)
            % If the flag is set to allow animation
            if self.animate
                % Get the current location of the corner points
                [left_motor_points, right_motor_points, body_points, arm_points] = self.get_points(state);

                % Draw the shapes
                self.draw(left_motor_points, right_motor_points, body_points, arm_points)
            end
        end
        function [left_motor_points, right_motor_points, body_points, arm_points] = get_points(self, state)
            % Unpack
            h     = state(1);
            z     = state(2);
            theta = state(3);

            % Get rotation matrices
            R = [cos(theta),-sin(theta);
                 sin(theta), cos(theta)]; % negative becasue positive rotation defined into screen

            % Rotate into the body frame
            left_motor_points  = R*self.left_motor_points  + [z;h];
            right_motor_points = R*self.right_motor_points + [z;h];
            body_points        = R*self.body_points        + [z;h];
            arm_points         = R*self.arm_points         + [z;h];
        end
        function draw(self, left_motor_points, right_motor_points, body_points, arm_points)
            
            % Draw Shapes (initilize if first time)
            if isempty(self.animation_handles)
                self.animation_handles(1)  = fill( left_motor_points(1,:),  left_motor_points(2,:),  'r');
                self.animation_handles(2)  = fill(right_motor_points(1,:), right_motor_points(2,:),  'g');
                self.animation_handles(3)  = fill(       body_points(1,:),        body_points(2,:),  'b');
                self.animation_handles(4)  = plot(        arm_points(1,:),         arm_points(2,:),  'k', "LineWidth", 2);
            else
                set( self.animation_handles(1), "XData",  left_motor_points(1,:), "YData",  left_motor_points(2,:));
                set( self.animation_handles(2), "XData", right_motor_points(1,:), "YData", right_motor_points(2,:));
                set( self.animation_handles(3), "XData",        body_points(1,:), "YData",        body_points(2,:));
                set( self.animation_handles(4), "XData",         arm_points(1,:), "YData",         arm_points(2,:));
            end
        end
    end
end