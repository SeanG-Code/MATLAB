classdef massSpringDamperControllerFSF < handle
    properties
        
        % Saturation Limits
        F_min
        F_max

        % Gains
        K_x
        k_r
    end
    methods
        function self = massSpringDamperControllerFSF(Param)
            % Saturation Limits
            self.F_min = Param.F_min;
            self.F_max = Param.F_max;

            % Control gains
            self.calculate_gains(Param.t_r, Param.zeta, Param.A, Param.B, Param.C_r);
        end

        function F_sat = update(self, states, reference)

            % HW10 SECTION START ------------------------------------------
            % Impliment full state feedback control. 
            % - States is the state column vector. 
            % - Reference is the reference signal (scalar). 
            % The outputs are
            % - F_sat the saturate input (scalar). This is what is actually
            % input into the system. 
            % Notice how much simpler full state feedback is to impliment
            % compared to PID.

            F_sat = NaN;
            
            % HW10 SECTION END --------------------------------------------
        end

        function calculate_gains(self,t_r,zeta,A,B,C_r)

            % HW10 SECTION START ------------------------------------------
            % Calculate the control gains K_x and k_r. Save them in the
            % appropriate class properties. To exactly match my solution
            % note that I used the full equation 8.5 from the textbook.
            % Not the approximation. Also check for controllability.
            
            assert(NaN, "Error: System Not Controllable.")
            self.K_x = NaN;
            self.k_r = NaN;

            % HW10 SECTION END --------------------------------------------
        end
    end
end