classdef blockBeamControllerPID < handle
    properties
        % Parameters
        m_1
        m_2
        ell
        g

        % Saturation Limits
        F_max
        F_min
        theta_max
        theta_min

        % Control States
        e_z_integral

        % Values form previous time step
        previous_e_z

        % Time Step
        Ts

        % Gains
        k_p_theta
        k_d_theta
        k_p_z
        k_i_z
        k_d_z
    end
    methods
        function self = blockBeamControllerPID(Param)

            % System properties
            self.m_1 = Param.m_1;
            self.m_2 = Param.m_2;
            self.ell = Param.ell;
            self.g   = Param.g  ;

            % Saturation Limits
            self.F_min     = Param.F_min;
            self.F_max     = Param.F_max;
            self.theta_min = Param.theta_min;
            self.theta_max = Param.theta_max;

            % Time Step
            self.Ts = Param.Ts;

            % Control gains
            self.calculate_gains(Param.t_r_theta, Param.zeta_theta, ...
                Param.t_r_z, Param.zeta_z, Param.t_r_integrator, ...
                Param.tf_F2theta, Param.tf_theta2z)
            
            % Intilize Values --------------------------------------------
            % Control States
            self.e_z_integral = 0;
    
            % Values form previous time step
            self.previous_e_z   = 0;
        end
        function [F_sat,theta_r_sat] = update(self, states, reference)

            % HW9 SECTION START ------------------------------------------
            % Impliment PID control. 
            % - States is the state vector. 
            % - Reference is the reference signal (scalar). 
            % The outputs are
            % - F_sat the saturate input (scalar). This is what is actually
            % input into the system. 
            % - u_sat is the saturated input measured from the equilibrium
            % input (i.e. F_sat_tilde)
            % - theta_r_sat is output of the outer loop which is feed to
            % the inner loop as the reference signal. It has been saturated
            % so that theta_r is between self.theta_min and self.theta_max.
            % Apply saturation based integrator antiwindup. For the
            % derivative term use the derivative of the output instead of
            % the derivative of the error. Assume you have access to the
            % whole state. The dirty derivative will be implimented
            % elsewhere. Use feedback lineraization to eleminate the effect
            % of gravity from the differential equation for theta.

            self.e_z_integral = NaN;
            self.previous_e_z = NaN;
            theta_r_sat       = NaN;
            F_sat             = NaN;

            % HW9 SECTION END --------------------------------------------
        end

        function calculate_gains(self, t_r_theta, zeta_theta, t_r_z, zeta_z, t_r_integrator, tf_F2theta, tf_theta2z)
            
            % HW9 SECTION START ------------------------------------------
            % Calculate the control gains k_p_z, k_i_z, k_d_z, k_p_theta,
            % and k_d_theta. Save them in the appropriate class properties.
            % To exactly match my solution note that I used the full
            % Equation 8.5 from the textbook. Not the approximation. This
            % function should be identical to the PD class. For a real pole
            % the pole can be found using log(1/9)/t_r. You will need to
            % rederive the closed loop transfer function and desired
            % charictoristic equation to derive an equation for the
            % integrator gain.
            
            self.k_p_theta = NaN;
            self.k_d_theta = NaN;
            self.k_p_z     = NaN;
            self.k_i_z     = NaN;
            self.k_d_z     = NaN;

            % HW9 SECTION END --------------------------------------------
        end
    end
end