classdef cartPoleAnimation < handle
    properties
        pole_points       % Location of points prior to rotation
        cart_points       % Location of points prior to rotation
        animation_handles % Handles to redraw shape
        animate           % Flag to keep track of if we should animate
    end
    methods
        function self = cartPoleAnimation(Param)
            % Drawing Flags ----------------------------------------------
            self.animate   = Param.animate;
            
            % Unpack the parameters --------------------------------------
            pole_width  = Param.pole_width ;
            pole_length = Param.ell;
            cart_size   = Param.cart_size  ;

            % Create the points ------------------------------------------
            self.pole_points = [ 
                 pole_width/2,            0;
                 pole_width/2,  pole_length;
                -pole_width/2,  pole_length;
                -pole_width/2,            0;
               ]'; % horizontal; vertical in the vehicle body frame (after transpose)
            self.cart_points = [ 
                 cart_size/2,          0;
                 cart_size/2,  cart_size;
                -cart_size/2,  cart_size;
                -cart_size/2,          0;
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
                [pole_points, cart_points] = self.get_points(state); % Get the location of the points on the drawing
                self.draw(pole_points, cart_points) % Draw those points
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
                [pole_points, cart_points] = self.get_points(state);

                % Draw the shapes
                self.draw(pole_points, cart_points)
            end
        end
        function [pole_points, cart_points] = get_points(self, state)
            % Unpack
            z     = state(1);
            theta = state(2);

            % Get rotation matrices
            R  = [cos(-theta),-sin(-theta);
                  sin(-theta), cos(-theta)]; % negative becasue positive rotation defined into screen

            % Rotate into the body frame
            pole_points  = R*self.pole_points + [z;self.cart_points(2,2)];
            cart_points =    self.cart_points + [z;                    0];
        end
        function draw(self, pole_points, cart_points)
            
            % Draw Shapes (initilize if first time)
            if isempty(self.animation_handles)
                self.animation_handles(1)  = fill(pole_points(1,:), pole_points(2,:),  'k');
                self.animation_handles(2)  = fill(cart_points(1,:), cart_points(2,:),  'b');
            else
                set( self.animation_handles(1), "XData", pole_points(1,:), "YData", pole_points(2,:));
                set( self.animation_handles(2), "XData", cart_points(1,:), "YData", cart_points(2,:));
            end
        end
    end
end