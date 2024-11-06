classdef Gillam_blockBeamControllerPD < handle
    properties
        % Parameters
        m_1
        m_2
        ell
        g
        F_e
        z_e
        
        % Saturation Limits
        F_min
        F_max
        theta_max
        theta_min

        % Time step
        Ts

        % Gains
        k_p_z
        k_d_z
        k_p_theta
        k_d_theta
    end
    methods
        function self = Gillam_blockBeamControllerPD(Param)

            % System properties
            self.m_1 = Param.m_1;
            self.m_2 = Param.m_2;
            self.ell = Param.ell;
            self.g   = Param.g  ;
            self.z_e = Param.z_e;
            self.F_e = Param.F_e;

            % Saturation Limits
            self.F_min     = Param.F_min;
            self.F_max     = Param.F_max;
            self.theta_min = Param.theta_min;
            self.theta_max = Param.theta_max;

            % Time Step
            self.Ts = Param.Ts;

            % Control gains
            self.calculate_gains(Param.t_r_theta, Param.zeta_theta, ...
                Param.t_r_z, Param.zeta_z, Param.tf_F2theta, Param.tf_theta2z);
        end

        function [F_sat,theta_r_sat] = update(self, states, reference)

            % HW8 SECTION START ------------------------------------------
            % Impliment PD control. 
            % - States is the state vector. 
            % - Reference is the reference signal (scalar). 
            % The outputs are
            % - F_sat the saturate input (scalar). This is what is actually
            % input into the system. 
            % - theta_r_sat is output of the outer loop which is feed to
            % the inner loop as the reference signal. It has been saturated
            % so that theta is between self.theta_min and self.theta_max.
            % For the derivative term use the derivative of the output
            % instead of the derivative of the error. Assume you have
            % access to the whole state. The dirty derivative will be
            % implimented elsewhere. Use feedback lineraization to
            % eleminate the effect of gravity from the differential
            % equation for theta.

            % Unpack
            z = states(1);
            theta = states(2);
            z_dot = states(3);
            theta_dot = states(4);
            r = reference(1);

            % Error (theta)
            e_z = r - z;

            % PD (theta)
            theta_r = (self.k_p_z*e_z) - (self.k_d_z*z_dot);
            
            % Saturation for theta
            theta_r_sat = Gillam_blockBeamSaturate(theta_r,self.theta_min,self.theta_max);
            
            % Error
            e_theta = theta_r_sat - theta;

            % Feedback Linerization
            F_tilde = self.k_p_theta*e_theta - self.k_d_theta*theta_dot;
            F_fl = ((6*self.m_1*self.g*z)+ (3*self.m_2*self.g*self.ell))/(6*self.ell);
            F = F_tilde + F_fl;

            % Saturation for F
            F_sat = Gillam_blockBeamSaturate(F,self.F_min,self.F_max);

            % HW8 SECTION END --------------------------------------------
        end

        function calculate_gains(self, t_r_theta, zeta_theta, t_r_z, zeta_z, tf_F2theta, tf_theta2z)
            
            % HW8 SECTION START ------------------------------------------
            % Calculate the control gains k_p_z, k_d_z, k_p_theta,
            % and k_d_theta. Save them in the appropriate class properties.
            % To exactly match my solution note that I used the full
            % Equation 8.5 from the textbook. Not the approximation.
            omega_ntheta = pi/(2*t_r_theta*sqrt(1-zeta_theta^2));
            omega_nz     = pi/(2*t_r_z*sqrt(1-zeta_z^2));

            self.k_p_theta = omega_ntheta^2*(self.ell*self.m_2/3 + self.m_1*self.z_e^2/self.ell);
            self.k_d_theta = 2*omega_ntheta*zeta_theta*(self.ell*self.m_2/3 + self.m_1*self.z_e^2/self.ell);
            self.k_p_z     = omega_nz^2/(-self.g);
            self.k_d_z     = (2*omega_nz*zeta_z)/(-self.g);

            % HW8 SECTION END --------------------------------------------
        end
    end
end