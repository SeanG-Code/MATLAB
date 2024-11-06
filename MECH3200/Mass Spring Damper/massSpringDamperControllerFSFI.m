classdef massSpringDamperControllerFSFI < handle
    properties
        
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
        function self = massSpringDamperControllerFSFI(Param)

            % Saturation Limits
            self.F_min = Param.F_min;
            self.F_max = Param.F_max;

            % Time Step
            self.Ts = Param.Ts;

            % Control gains
            self.calculate_gains(Param.t_r, Param.zeta, Param.t_r_integrator, Param.A, Param.B, Param.C_r);

            % Intilize Values
            % Control States
            self.e_integral   = 0;
    
            % Values form previous time step
            self.previous_e   = 0;
        end

        function F_sat = update(self, states, reference)

            % HW11 SECTION START ---------------------------------------
            % Impliment Full State Feedback with an integrator. 
            % - States is the state column vector. 
            % - Reference is the reference signal (scalar). 
            % The outputs are
            % - F_sat the saturate input (scalar). This is what is actually
            % input into the system. 
            % - u_sat is the saturated input measured from the feedback
            % linearization input (i.e. F_sat_tilde). Apply saturation
            % based anti-windup. Unlike the textbook you should leave the
            % k_r term in the control law because it stops the integrator
            % from winding up unnessisarily and improves performance.

            self.e_integral = NaN;
            self.previous_e = NaN;
            F_sat = NaN;
            
            % HW11 SECTION END -----------------------------------------

        end

        function calculate_gains(self, t_r, zeta, t_r_integrator, A, B, C_r)

            % HW11 SECTION START ---------------------------------------
            % Calculate the control gains K_x, k_i, and k_r. Save them in
            % the appropriate class properties. To exactly match my
            % solution note that I used the full equation 8.5 from the
            % textbook. Note the approximation. For a real pole the pole
            % can be found using log(1/9)/t_r. Also check for
            % controllability of the augmented system.

            assert(NaN, "Error: System Not Controllable.")
            
            self.K_x = NaN;
            self.k_i = NaN;
            self.k_r = NaN;

            % HW11 SECTION END -----------------------------------------
        end
    end
end