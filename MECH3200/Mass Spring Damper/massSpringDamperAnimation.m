classdef massSpringDamperAnimation < handle
    properties
        body_frame_points % Location of points prior to rotation
        animation_handles % Handles to redraw shape
        animate           % Flag to keep track of if we should animate
    end
    methods
        function self = massSpringDamperAnimation(Param)
            % Drawing Flags ----------------------------------------------
            self.animate   = Param.animate;
            
            % Unpack the parameters --------------------------------------
            box_size = Param.box_size;

            % Create the points ------------------------------------------
            self.body_frame_points = [ 
                 box_size/2,        0;
                 box_size/2, box_size;
                -box_size/2, box_size;
                -box_size/2,         0;
               ]'; % horizontal; vertical in the vehicle body frame (after transpose)

            % Initial State ---------------------------------------------
            state = [Param.z_0; Param.z_dot_0];

            % Draw the vehcile ------------------------------------------
            % If the flag is set to allow animation
            if self.animate
                % Create a figure that is docked to Matlab
                figure('Windowstyle','docked','name',"Animation");
                clf; % Clear the figure
                hold on; % Hold to allow plotting multiple things on one axis.
                box_points = self.get_points(state); % Get the location of the points on the drawing
                self.draw(box_points) % Draw those points
                plot(Param.hlim, zeros(size(Param.hlim)), "-k","LineWidth",Param.line_width); % Draw wall
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
                points = self.get_points(state);

                % Draw the shapes
                self.draw(points);
            end
        end
        function arm_points = get_points(self, state)
            % Unpack
            z = state(1);

            % Rotate into the body frame
            arm_points = self.body_frame_points + [z;0];
        end
        function draw(self,box_points)
            
            % Draw Shapes (initilize if first time)
            if isempty(self.animation_handles)
                self.animation_handles  = fill(box_points(1,:), box_points(2,:),  'b');
            else
                set( self.animation_handles, "XData", box_points(1,:), "YData", box_points(2,:));
            end
        end
    end
end