classdef blockBeamControllerFSF < handle
    properties

        % Equiblibrium
        z_e        
        theta_e    
        z_dot_e    
        theta_dot_e
        F_e
        
        % Saturation Limits
        F_min
        F_max

        % Gains
        K_x
        k_r
    end
    methods
        function self = blockBeamControllerFSF(Param)

            % Equiblibrium
            self.z_e         = Param.z_e        ;
            self.theta_e     = Param.theta_e    ;
            self.z_dot_e     = Param.z_dot_e    ;
            self.theta_dot_e = Param.theta_dot_e;
            self.F_e         = Param.F_e        ;

            % Saturation Limits
            self.F_min = Param.F_min;
            self.F_max = Param.F_max;

            % Control gains
            self.calculate_gains(Param.t_r_theta, Param.zeta_theta, ...
                Param.t_r_z, Param.zeta_z, Param.A, Param.B, Param.C_r);
        end

        function F_sat = update(self, states, reference)

            % HW10 SECTION START ------------------------------------------
            % Impliment full state feedback control. 
            % - States is the state vector. 
            % - Reference is the reference signal (scalar). 
            % The outputs are
            % - F_sat the saturate input (scalar). This is what is actually
            % input into the system. 
            % Notice how much simpler full state feedback is to impliment
            % compared to PID. Do NOT apply feedback lineraization.
            % However, do not forget that we have linearized around z_e and
            % F_e which is not zero. How does that affect your linear
            % control law?

            F_sat = NaN;

            % HW10 SECTION END --------------------------------------------
        end

        function calculate_gains(self, t_r_theta, zeta_theta, t_r_z, zeta_z, A, B, C_r)
            
            % HW10 SECTION START ------------------------------------------
            % Calculate the control gains K_x and k_r. Save them in the
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