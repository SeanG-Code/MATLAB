classdef massSpringDamperControllerPID < handle
    properties

        % Saturation Limits
        F_max
        F_min

        % Control States
        e_integral

        % Values form previous time step
        previous_e

        % Time Step
        Ts

        % Gains
        k_p
        k_i
        k_d
    end
    methods
        function self = massSpringDamperControllerPID(Param)

            % Saturation Limits
            self.F_min = Param.F_min;
            self.F_max = Param.F_max;

            % Time Step
            self.Ts = Param.Ts;

            % Control gains
            self.calculate_gains(Param.t_r, Param.zeta, Param.t_r_integrator, Param.tf)
            
            % Intilize Values --------------------------------------------
            % Control States
            self.e_integral   = 0;
    
            % Values form previous time step
            self.previous_e   = 0;
        end

        function F_sat = update(self, states, reference)

            % HW9 SECTION START ---------------------------------------
            % Impliment PID control. 
            % - States is the state vector. 
            % - Reference is the reference signal (scalar). 
            % The outputs are
            % - F_sat the saturate input (scalar). This is what is actually
            % input into the system. 
            % - u_sat is the saturated input measured from the feedback
            % linearization input (i.e. F_sat_tilde)
            % Apply saturation based anti-windup. For the derivative term
            % use the derivative of the output instead of the derivative of
            % the error. Assume you have access to the whole state. The
            % dirty derivative will be implimented elsewhere.

            self.e_integral = NaN;
            self.previous_e = NaN;
            F_sat = NaN;

            % HW9 SECTION END -----------------------------------------
        end

        function calculate_gains(self,t_r,zeta,t_r_integrator,tf)

            % HW9 SECTION START ---------------------------------------
            % Calculate the control gains k_p, k_i, and k_d. Save them in
            % the appropriate class properties. To exactly match my
            % solution note that I used the full equation 8.5 from the
            % textbook. Not the approximation. For a real pole the pole
            % can be found using log(1/9)/t_r. You will need to rederive
            % the closed loop transfer function and desired charictoristic
            % equation to derive an equation for the integrator gain.
            
            
            self.k_p = NaN;
            self.k_i = NaN;
            self.k_d = NaN;

            % HW9 SECTION END -----------------------------------------
        end
    end
end