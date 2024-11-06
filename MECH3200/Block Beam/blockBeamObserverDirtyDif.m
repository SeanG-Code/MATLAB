classdef blockBeamObserverDirtyDif < handle
    properties

        % Observer States
        z_hat_dot
        theta_hat_dot

        % Previous States
        previous_z
        previous_theta

        % Time Step
        Ts

        % Observer gains
        cutoff_frequency_z
        cutoff_frequency_theta
        
    end
    methods
        function self = blockBeamObserverDirtyDif(Param, measurments)

            % Observer States
            self.z_hat_dot     = 0;
            self.theta_hat_dot = 0;
    
            % Previous States
            self.previous_z     = measurments(1);
            self.previous_theta = measurments(2);
    
            % Time Step
            self.Ts = Param.Ts;
    
            % Observer gains
            self.cutoff_frequency_theta = Param.cutoff_frequency_theta;
            self.cutoff_frequency_z     = Param.cutoff_frequency_z;

        end

        function x_hat = update(self, ~, measurements)
            % HW9 SECTION START ------------------------------------------
            % Impliment the dirty derivative to find z_hat_dot and
            % theta_hat_dot. Then use the measurements and outputs of the
            % dirty derivative to construct an estimate of the state vector
            % The input measurments is a column vector with a measurment of
            % z and theta in that order. x_hat is a column vector
            % containing an estimate of the system states in the standard
            % order.

            self.z_hat_dot      = NaN;
            self.theta_hat_dot  = NaN;
            self.previous_z     = NaN;
            self.previous_theta = NaN;
            x_hat = NaN;
            
            % HW9 SECTION END --------------------------------------------
        end
    end
end