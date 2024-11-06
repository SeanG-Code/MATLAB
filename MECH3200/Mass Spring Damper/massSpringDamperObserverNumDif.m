classdef massSpringDamperObserverNumDif < handle
    properties

        % Observer States
        z_hat_dot

        % Previous States
        previous_z

        % Time Step
        Ts

    end
    methods
        function self = massSpringDamperObserverNumDif(Param, measurments)

            % Observer States
            self.z_hat_dot = 0;
    
            % Previous States
            self.previous_z = measurments(1);
    
            % Time Step
            self.Ts = Param.Ts;
        end

        function x_hat = update(self, ~, measurements)
            % Unpack
            z = measurements(1);

            % Numerical Derivative
            self.z_hat_dot = (z - self.previous_z)/self.Ts;
            self.previous_z = z;
            
            % Pack
            x_hat = [z;self.z_hat_dot];
        end
    end
end