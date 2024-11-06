classdef blockBeamControllerFSFI < handle
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

        % Control States
        e_integral

        % Values form previous time step
        previous_e

        % Time Step
        Ts

        % Gains
        K_x
        k_i
        k_r
    end
    methods
        function self = blockBeamControllerFSFI(Param)

            % Equiblibrium
            self.z_e         = Param.z_e        ;
            self.theta_e     = Param.theta_e    ;
            self.z_dot_e     = Param.z_dot_e    ;
            self.theta_dot_e = Param.theta_dot_e;
            self.F_e         = Param.F_e        ;
         
            % Saturation Limits
            self.F_min = Param.F_min;
            self.F_max = Param.F_max;

            % Time Step
            self.Ts = Param.Ts;

            % Control gains
            self.calculate_gains(Param.t_r_theta, Param.zeta_theta, ...
                Param.t_r_z, Param.zeta_z, Param.t_r_integrator, Param.A, Param.B, Param.C_r);

            % Intilize Values
            % Control States
            self.e_integral   = 0;
    
            % Values form previous time step
            self.previous_e   = 0;
        end

        function F_sat = update(self, states, reference)

            % HW11 SECTION START ------------------------------------------
            % Impliment Full State Feedback with an integrator. 
            % - States is the state vector. 
            % - Reference is the reference signal (scalar). 
            % The outputs are
            % - F_sat the saturate input (scalar). This is what is actually
            % input into the system. 
            % Apply saturation based integrator antiwindup. Unlike the
            % textbook you should leave the k_r term in the control law
            % because it stops the integrator from winding up unnessisarily
            % and improves performance. Do NOT apply feedback lineraization.
            % However, do not forget that we have linearized around z_e and
            % F_e which is not zero. How does that affect your linear
            % control law?

            self.e_integral = NaN;
            self.previous_e = NaN;
            F_sat = NaN;
            
            % HW11 SECTION END -----------------------------------------

        end

        function calculate_gains(self, t_r_theta, zeta_theta, t_r_z, zeta_z, t_r_integrator, A, B, C_r)

            % HW11 SECTION START ------------------------------------------
            % Calculate the control gains K_x, k_i, and k_r. Save them in
            % the appropriate class properties. To exactly match my
            % solution note that I used the full Equation 8.5 from the
            % textbook. Not the approximation. Also check for
            % controllability of the augmented system.

            assert(NaN, "Error: System Not Controllable.")
            self.K_x = NaN;
            self.k_i = NaN;
            self.k_r = NaN;

            % HW11 SECTION END -----------------------------------------
        end
    end
end