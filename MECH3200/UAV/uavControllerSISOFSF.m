classdef uavControllerSISOFSF < handle
    properties

        % System Prameters
        d

        % Equilibrium
        F_e
        
        % Saturation Limits
        f_min
        f_max

        % Gains
        K_x_lat
        K_x_lon
        k_r_lat
        k_r_lon
    end
    methods
        function self = uavControllerSISOFSF(Param)

            % System Prameters
            self.d = Param.d;

            % Equilibrium
            self.F_e = Param.F_e;

            % Saturation Limits
            self.f_min = Param.f_min;
            self.f_max = Param.f_max;

            % Control gains
            self.calculate_gains(Param.t_r_h, Param.zeta_h, ...
                Param.t_r_z, Param.zeta_z, ...
                Param.t_r_theta, Param.zeta_theta, ...
                Param.A_lat, Param.B_lat, Param.C_r_lat, ...
                Param.A_lon, Param.B_lon, Param.C_r_lon);
        end

        function inputs_sat = update(self, states, reference)

            % HW10 SECTION START ------------------------------------------
            % Impliment SISO full state feedback control. 
            % - States is the state vector. 
            % - Reference is the reference signals (h and z in that order). 
            % The outputs are
            % - inputs_sat the saturate inputs (f_r and f_l in that order).
            % This is what is actually input into the system.
            % Notice how much simpler full state feedback is to impliment
            % compared to PID. Don't forget to convert your final
            % torque and thrust into individual motor thrusts (one for the
            % left and one for the right).  Remember that we linearized
            % around the equilibrium input F_e.

            inputs_sat = NaN;
            
            % HW10 SECTION END --------------------------------------------
        end

        function calculate_gains(self, t_r_h, zeta_h, t_r_z, zeta_z, t_r_theta, zeta_theta, ...
                A_lat, B_lat, C_r_lat, A_lon, B_lon, C_r_lon)
            
            % HW10 SECTION START ------------------------------------------
            % Calculate the control gains K_x_lat, K_x_lon, k_r_lat, and
            % k_r_lon. lat refers to the lateral system (theta and z) lon
            % refers to the longitudinal system (h). Save them in the
            % appropriate class properties. To exactly match my solution
            % note that I used the full Equation 8.5 from the textbook. Not
            % the approximation. Also check for controllability.

            assert(NaN, "Error: Lateral System Not Controllable.")
            assert(NaN, "Error: Longitudinal System Not Controllable.")

            self.K_x_lat = NaN;
            self.K_x_lon = NaN;
            self.k_r_lat = NaN;
            self.k_r_lon = NaN;

            % HW10 SECTION END --------------------------------------------

        end
    end
end