classdef uavControllerPID < handle
    properties

        % System Parameters
        d
        
        % Saturation Limits
        f_min
        f_max
        theta_max
        theta_min

        % Equilibrium
        F_e

        % Control States
        e_z_integral
        e_h_integral

        % Values form previous time step
        previous_e_z
        previous_e_h

        % Time Step
        Ts

        % Gains
        k_p_h
        k_i_h
        k_d_h
        k_p_z
        k_i_z
        k_d_z
        k_p_theta
        k_d_theta
    end
    methods
        function self = uavControllerPID(Param)

            % System Parameters
            self.d = Param.d;

            % Saturation Limits
            self.f_min     = Param.f_min;
            self.f_max     = Param.f_max;
            self.theta_min = Param.theta_min;
            self.theta_max = Param.theta_max;

            % Equilibrium
            self.F_e = Param.F_e;

            % Time Step
            self.Ts = Param.Ts;

            % Control gains
            self.calculate_gains( Param.t_r_h, Param.zeta_h, Param.t_r_h_integrator, ...
                Param.t_r_z, Param.zeta_z, Param.t_r_z_integrator, ...
                Param.t_r_theta, Param.zeta_theta, ...
                Param.tf_F2h, Param.tf_tau2theta, Param.tf_theta2z)
            
            % Intilize Values --------------------------------------------
            % Control States
            self.e_z_integral = 0;
            self.e_h_integral = 0;
    
            % Values form previous time step
            self.previous_e_z   = 0;
            self.previous_e_h   = 0;
        end
        function [inputs_sat,theta_r_sat] = update(self, states, reference)

            % HW9 SECTION START ------------------------------------------
            % Impliment PID control. 
            % - States is the state vector. 
            % - Reference is the reference signals (h and z in that order). 
            % The outputs are
            % - inputs_sat the saturate inputs (f_r and f_l in that order).
            % This is what is actually input into the system.
            % - theta_r_sat is output of the outer loop which is feed to
            % the inner loop as the reference signal. It has been saturated
            % so that theta is between self.theta_min and self.theta_max.
            % Apply saturation based integrator antiwindup. When applying
            % anti-windup to the longitudinal system (h and F) use 2*f_min
            % and 2*f_max to saturate the input. After the mixing you
            % should also saturate each individual motor to be between
            % f_min and f_max. For the derivative term use the derivative
            % of the output instead of the derivative of the error. Assume
            % you have access to the whole state. The dirty derivative will
            % be implimented elsewhere. Don't forget to convert your final
            % torque and thrust into individual motor thrusts (one for the
            % left and one for the right).  Remember that we linearized
            % around the equilibrium input F_e.

            self.e_z_integral = NaN;
            self.previous_e_z = NaN;
            theta_r_sat       = NaN;
            self.e_h_integral = NaN;
            self.previous_e_h = NaN;
            inputs_sat        = NaN;
            
            % HW9 SECTION END --------------------------------------------
        end

        function calculate_gains(self, t_r_h, zeta_h, t_r_h_integrator, ...
                t_r_z, zeta_z, t_r_z_integrator, t_r_theta, zeta_theta, ...
                tf_F2h, tf_tau2theta, tf_theta2z)
            
            % HW9 SECTION START ------------------------------------------
            % Calculate the control gains k_p_h, k_i_h, k_d_h, k_p_z,
            % k_i_z, k_d_z, k_p_theta, and k_d_theta. Save them in the
            % appropriate class properties. To exactly match my solution
            % note that I used the full Equation 8.5 from the textbook. Not
            % the approximation. Use log(1/9)/t_r_integrator for the real
            % pole.

            self.k_p_theta = NaN;
            self.k_d_theta = NaN;
            self.k_p_z     = NaN;
            self.k_i_z     = NaN;
            self.k_d_z     = NaN;
            self.k_p_h     = NaN;
            self.k_i_h     = NaN;
            self.k_d_h     = NaN;

            % HW9 SECTION END --------------------------------------------
        end
    end
end