classdef blockBeamObserverNumDif < handle
    properties

        % Observer States
        z_hat_dot
        theta_hat_dot

        % Previous States
        previous_z
        previous_theta

        % Time Step
        Ts

    end
    methods
        function self = blockBeamObserverNumDif(Param, measurments)

            % Observer States
            self.z_hat_dot     = 0;
            self.theta_hat_dot = 0;
    
            % Previous States
            self.previous_z     = measurments(1);
            self.previous_theta = measurments(2);
    
            % Time Step
            self.Ts = Param.Ts;
        end

        function x_hat = update(self, ~, measurements)
            % Unpack
            z     = measurements(1);
            theta = measurements(2);

            % Numerical Derivative
            self.z_hat_dot      = (z     - self.previous_z    )/self.Ts;
            self.theta_hat_dot  = (theta - self.previous_theta)/self.Ts;
            self.previous_z     = z;
            self.previous_theta = theta;
            
            % Pack
            x_hat = [z; theta; self.z_hat_dot; self.theta_hat_dot];
        end
    end
end