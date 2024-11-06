classdef massSpringDamperObserverDirtyDif < handle
    properties

        % Observer States
        z_hat_dot

        % Previous States
        previous_z

        % Time Step
        Ts

        % Observer gains
        cutoff_frequency
    end
    methods
        function self = massSpringDamperObserverDirtyDif(Param, measurments)

            % Observer States
            self.z_hat_dot = 0;
    
            % Previous States
            self.previous_z = measurments(1);
    
            % Time Step
            self.Ts = Param.Ts;
    
            % Observer gains
            self.cutoff_frequency = Param.cutoff_frequency;

        end

        function x_hat = update(self, ~, measurements)
            % HW9 SECTION START ------------------------------------------
            % Impliment the dirty derivative to find z_hat_dot. Then
            % use the measurements and outputs of the dirty derivative to
            % construct an estimate of the state vector The input
            % measurments is a scalar measurment of z. x_hat is a
            % column vector containing an estimate of the system states in
            % the standard order.
            
            self.z_hat_dot = NaN;
            self.previous_z = NaN;
            x_hat = NaN;

            % HW9 SECTION END --------------------------------------------
        end
    end
end