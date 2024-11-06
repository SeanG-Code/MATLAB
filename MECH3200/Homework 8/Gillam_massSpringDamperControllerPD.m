classdef Gillam_massSpringDamperControllerPD < handle
    properties
        m
        k
        b
        F_e
        
        % Saturation Limits
        F_min
        F_max
        % Gains
        k_p
        k_d
    end
    methods
        function self = Gillam_massSpringDamperControllerPD(Param)
            self.m = Param.m;
            self.k = Param.k;
            self.b = Param.b;
            self.F_e = Param.F_e;
            % Saturation Limits
            self.F_min = Param.F_min;
            self.F_max = Param.F_max;
            % Control gains
            self.calculate_gains(Param.t_r, Param.zeta, Param.tf)
        end
        function F_sat = update(self, states, reference)
            % HW8 SECTION START ------------------------------------------
            % Impliment PD control. 
            % - States is the state vector. 
            % - Reference is the reference signal (scalar). 
            % The outputs are
            % - F_sat the saturate input (scalar). This is what is actually
            % input into the system. 
            % - u_sat is the saturated input measured from the equilibrium 
            % input (i.e. F_sat_tilde)

            % Unpack
            z = states(1);
            z_dot = states(2);
            r = reference;

            % Error
            e = r - z;

            % PD
            u = self.k_p*e - self.k_d*z_dot;

            % error feedback
            F = u + self.F_e;

            % Saturation
            F_sat = Gillam_massSpringDamperSaturate(F, self.F_min, self.F_max);
            
            % HW8 SECTION END --------------------------------------------
        end
        function calculate_gains(self,t_r,zeta,tf)
            % HW8 SECTION START ------------------------------------------
            % Calculate the control gains k_p and k_d. Save them in the
            % appropriate class properties. To exactly match my solution
            % note that I used the full equation 8.5 from the textbook.
            % Not the approximation.

            % Omega
            omega_n = pi/(2*t_r*sqrt(1-zeta^2));
            
            % Gain Equations
            self.k_p = self.m*omega_n^2-self.k;
            self.k_d = self.m*2*zeta*omega_n-self.b;
            
            % HW8 SECTION END --------------------------------------------
        end
    end
end 