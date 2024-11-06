classdef blockBeamAnimation < handle
    properties
        box_points        % Location of points prior to rotation
        beam_points       % Location of points prior to rotation
        animation_handles % Handles to redraw shape
        animate           % Flag to keep track of if we should animate
    end
    methods
        function self = blockBeamAnimation(Param)
            % Drawing Flags ----------------------------------------------
            self.animate   = Param.animate;
            
            % Unpack the parameters --------------------------------------
            box_size   = Param.box_size ;
            arm_width  = Param.arm_width;
            ell        = Param.ell      ;

            % Create the points ------------------------------------------
            self.box_points = [ 
                 box_size/2, 0;
                 box_size/2, box_size;
                -box_size/2, box_size;
                -box_size/2, 0;
               ]'; % horizontal; vertical in the vehicle body frame (after transpose)
            self.beam_points = [ 
                   0,          0;
                 ell,          0;
                 ell, -arm_width;
                   0, -arm_width;
               ]'; % horizontal; vertical in the vehicle body frame (after transpose)

            % Initial State ---------------------------------------------
            state = [Param.z_0; Param.theta_0; Param.z_dot_0; Param.theta_dot_0];

            % Draw the vehcile ------------------------------------------
            % If the flag is set to allow animation
            if self.animate
                % Create a figure that is docked to Matlab
                figure('Windowstyle','docked','name',"Animation");
                clf; % Clear the figure
                hold on; % Hold to allow plotting multiple things on one axis.
                [box_points, beam_points] = self.get_points(state); % Get the location of the points on the drawing
                self.draw(box_points, beam_points) % Draw those points
                plot(zeros(size(Param.vlim)), Param.vlim, "-k","LineWidth",Param.line_width); % Draw Ground
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
                [box_points, beam_points] = self.get_points(state);

                % Draw the shapes
                self.draw(box_points, beam_points)
            end
        end
        function [box_points, beam_points] = get_points(self, state)
            % Unpack
            z     = state(1);
            theta = state(2);

            % Get rotation matrices
            R = [cos(theta),-sin(theta);
                 sin(theta), cos(theta)];

            % Rotate into the body frame
            box_points  = R*(self.box_points + [z;0]) ;
            beam_points = R* self.beam_points;
        end
        function draw(self, box_points, beam_points)
            
            % Draw Shapes (initilize if first time)
            if isempty(self.animation_handles)
                self.animation_handles(1)  = fill( box_points(1,:),  box_points(2,:),  'b');
                self.animation_handles(2)  = fill(beam_points(1,:), beam_points(2,:),  'k');
            else
                set( self.animation_handles(1), "XData",  box_points(1,:), "YData",  box_points(2,:));
                set( self.animation_handles(2), "XData", beam_points(1,:), "YData", beam_points(2,:));
            end
        end
    end
end