classdef Gillam_uavControllerPD < handle
    properties

        % System Parameters
        d
        m_c
        J_c
        m_r
        m_l
        mu
        g
        
        % Saturation Limits
        f_min
        f_max
        theta_max
        theta_min

        % Equilibrium
        F_e

        % Time step
        Ts

        % Gains
        k_p_h
        k_d_h
        k_p_z
        k_d_z
        k_p_theta
        k_d_theta
    end
    methods
        function self = Gillam_uavControllerPD(Param)

            % System Parameters
            self.d   = Param.d;
            self.m_c = Param.m_c;
            self.J_c = Param.J_c;
            self.m_r = Param.m_r;
            self.m_l = Param.m_l;
            self.mu  = Param.mu ;
            self.g   = Param.g  ;

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
            self.calculate_gains( Param.t_r_h, Param.zeta_h, ...
                Param.t_r_z, Param.zeta_z, ...
                Param.t_r_theta, Param.zeta_theta, ...
                Param.tf_F2h, Param.tf_tau2theta, Param.tf_theta2z)
        end

        function [inputs_sat,theta_r_sat] = update(self, states, reference)

            % HW8 SECTION START ------------------------------------------
            % Impliment PD control. 
            % - States is the state vector. 
            % - Reference is the reference signals (h and z in that order). 
            % The outputs are
            % - inputs_sat the saturate inputs (f_r and f_l in that order).
            % This is what is actually input into the system.
            % - theta_r_sat is output of the outer loop which is feed to
            % the inner loop as the reference signal. It has been saturated
            % so that theta is between self.theta_min and self.theta_max.
            % For the derivative term use the derivative of the output
            % instead of the derivative of the error. Assume you have
            % access to the whole state. The dirty derivative will be
            % implimented elsewhere. Don't forget to convert your final
            % torque and thrust into individual motor thrusts (one for the
            % left and one for the right). Remember that we linearized
            % around the equilibrium input F_e.

            % Unpack
            h     = states(1);
            z     = states(2);
            theta = states(3);
            h_dot = states(4);
            z_dot = states(5);
            theta_dot = states(6);
            r_h = reference(1);
            r_z = reference(2);

            % Error
            e_h = r_h - h;
            e_z = r_z - z;
            
            % PD theta
            r_theta = (self.k_p_z*e_z) - (self.k_d_z*z_dot);

            % Error theta
            e_theta = r_theta - theta;

            % PD
            u_theta = (self.k_p_theta*e_theta) - (self.k_d_theta*theta_dot);
            u_h = (self.k_p_h*e_h) - (self.k_d_h*h_dot);

            % Feedback Linerization
            F = u_h + self.F_e;
            Tau = u_theta;

            p = [1, 1; self.d, -self.d]^-1 * [F; Tau];
            F_r = p(1);
            F_l = p(2);

            % Saturation
            F_r_sat = Gillam_uavSaturate(F_r, self.f_min, self.f_max);
            F_l_sat = Gillam_uavSaturate(F_l, self.f_min, self.f_max);

            theta_r_sat = Gillam_uavSaturate(r_theta, self.theta_min, self.theta_max);
            inputs_sat = [F_r_sat; F_l_sat];

            % HW8 SECTION END --------------------------------------------
        end

        function calculate_gains(self, t_r_h, zeta_h, t_r_z, zeta_z, ...
                t_r_theta, zeta_theta, tf_F2h, tf_tau2theta, tf_theta2z)
            
            % HW8 SECTION START ------------------------------------------
            % Calculate the control gains k_p_h, k_d_h, k_p_z, k_d_z,
            % k_p_theta, and k_d_theta. Save them in the appropriate class
            % properties. To exactly match my solution note that I used the
            % full Equation 8.5 from the textbook. Not the approximation.

            omega_ntheta = pi/(2*t_r_theta*sqrt(1-zeta_theta^2));
            omega_nz     = pi/(2*t_r_z*sqrt(1-zeta_z^2));
            omega_nh     = pi/(2*t_r_z*sqrt(1-zeta_h^2));

            self.k_p_theta = (self.J_c + 2*self.m_r*self.d^2)*(omega_ntheta^2);
            self.k_d_theta = (self.J_c + 2*self.m_r*self.d^2)*(2*omega_ntheta*zeta_theta);
            self.k_p_z     = omega_nz^2/(-self.g);
            self.k_d_z     = ((2*omega_nz*zeta_z)-(self.mu/(self.m_c+2*self.m_r)))/(-self.g);
            self.k_p_h     = (omega_nh^2)*(self.m_c+2*self.m_r);
            self.k_d_h     = (self.m_c+2*self.m_r)*(2*omega_nh*zeta_h);

            % HW8 SECTION END --------------------------------------------
        end
    end
end