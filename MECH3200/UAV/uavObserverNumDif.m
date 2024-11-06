classdef uavObserverNumDif < handle
    properties

        % Observer States
        h_hat_dot
        z_hat_dot
        theta_hat_dot

        % Previous States
        previous_h
        previous_z
        previous_theta

        % Time Step
        Ts

    end
    methods
        function self = uavObserverNumDif(Param, measurments)

            % Observer States
            self.h_hat_dot     = 0;
            self.z_hat_dot     = 0;
            self.theta_hat_dot = 0;
    
            % Previous States
            self.previous_h     = measurments(1);
            self.previous_z     = measurments(2);
            self.previous_theta = measurments(3);
    
            % Time Step
            self.Ts = Param.Ts;
        end

        function x_hat = update(self, ~, measurements)
            
            % Unpack
            h     = measurements(1);
            z     = measurements(2);
            theta = measurements(3);

            % Numerical Derivative
            self.h_hat_dot      = (h     - self.previous_h     )/self.Ts;
            self.z_hat_dot      = (z     - self.previous_z     )/self.Ts;
            self.theta_hat_dot  = (theta - self.previous_theta )/self.Ts;
            self.previous_h     = h;
            self.previous_z     = z;
            self.previous_theta = theta;
            
            % Pack
            x_hat = [h; z; theta; self.z_hat_dot; self.z_hat_dot; self.theta_hat_dot];
        end
    end
end