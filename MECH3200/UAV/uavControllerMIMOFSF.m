classdef uavControllerMIMOFSF < handle
    properties

        % System Prameters
        d

        % Equilibrium
        F_e
        
        % Saturation Limits
        f_min
        f_max

        % Gains
        K_x
        k_r
    end
    methods
        function self = uavControllerMIMOFSF(Param)

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
                Param.A, Param.B, Param.C_r);
        end

        function inputs_sat = update(self, states, reference)

            % HW10 SECTION START ------------------------------------------
            % Impliment MIMO full state feedback control. 
            % - States is the state vector. 
            % - Reference is the reference signals (h and z in that order). 
            % The outputs are
            % - inputs_sat the saturate inputs (f_r and f_l in that order).
            % This is what is actually input into the system.
            % Notice how much simpler full state feedback is to impliment
            % compared to PID.
            
            inputs_sat = NaN;
            
            % HW10 SECTION END --------------------------------------------
        end

        function calculate_gains(self, t_r_h, zeta_h, t_r_z, zeta_z, t_r_theta, zeta_theta, A, B, C_r)
            
            % HW10 SECTION START ------------------------------------------
            % Calculate the control gains K_x_lat, K_x_lon, k_r_lat, and
            % k_r_lon. lat refers to the lateral system (theta and z) lon
            % refers to the longitudinal system (h). Save them in the
            % appropriate class properties. To exactly match my solution
            % note that I used the full Equation 8.5 from the textbook. Not
            % the approximation. Also check for controllability.

            assert(NaN, "Error: System Not Controllable.")
            self.K_x = NaN;
            self.k_r = NaN;

            % HW10 SECTION END --------------------------------------------

        end
    end
end