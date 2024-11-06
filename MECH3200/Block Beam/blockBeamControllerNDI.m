classdef blockBeamControllerNDI < handle
    properties
        % Parameters
        m_1
        m_2
        ell
        g
        
        % Saturation Limits
        F_min
        F_max
        theta_max
        theta_min

        % Control States
        x_m_z
        x_m_theta

        % Time Step
        Ts

        % Gains
        k_0_z
        k_1_z
        k_0_theta
        k_1_theta
        A_m_z
        B_m_z
        A_m_theta
        B_m_theta 
        
    end
    methods
        function self = blockBeamControllerNDI(Param, measurments)
            
            % System properties
            self.m_1 = Param.m_1;
            self.m_2 = Param.m_2;
            self.ell = Param.ell;
            self.g   = Param.g  ;

            % Saturation Limits
            self.F_min = Param.F_min;
            self.F_max = Param.F_max;
            self.theta_min = Param.theta_min;
            self.theta_max = Param.theta_max;

            % Time Step
            self.Ts = Param.Ts;

            % Control gains
            self.calculate_gains(Param.t_r_model_z, ...
                                 Param.zeta_model_z, ...
                                 Param.t_r_model_theta   , ...
                                 Param.zeta_model_theta  , ...
                                 Param.t_r_error_z , ...
                                 Param.zeta_error_z, ...
                                 Param.t_r_error_theta   , ...
                                 Param.zeta_error_theta);

            % Intilize Control States
            self.x_m_z = [measurments(1);0];
            self.x_m_theta   = [measurments(2);0];
   
        end

        function [F_sat,states_m,theta_r_sat] = update(self, states, reference)

            % HW20 SECTION START --------------------------------------
            % Impliment NDI control.
            % - States is the state vector. 
            % - Reference is the reference signal (scalar). 
            % The outputs are
            % - F_sat the saturate input (scalar). This is what is actually
            % input into the system. 
            % - states_m is a vector of the same size as states representing the
            % reference model for each state respectively.
            % - theta_r_sat is the reference angle for z saturated to be
            % between self.theta_min and self.theta_max.
            % Use the update_z_reference_model and
            % update_theta_reference_model methods to propigate the
            % reference model forward in time. Use the
            % z_reference_model_dif_eq and theta_reference_model_dif_eq
            % method to obtain x_m_dot. Don't forget to saturate the input.

            theta_r_sat = NaN;
            F_sat = NaN;
            states_m = NaN;

            % HW20 SECTION END -----------------------------------------
        end

        function calculate_gains(self, t_r_model_z , ...
                                       zeta_model_z, ...
                                       t_r_model_theta   , ...
                                       zeta_model_theta  , ...
                                       t_r_error_z , ...
                                       zeta_error_z, ...
                                       t_r_error_theta   , ...
                                       zeta_error_theta)

            % HW20 SECTION START ---------------------------------------
            % Calculate the control gains k_0 and k_1. Also calculate the
            % state space representation of the reference model A_m and
            % B_m. Save them in the appropriate class properties. To
            % exactly match my solution note that I used the full Equation
            % 8.5 from the textbook. Not the approximation.

            
            self.k_0_z     = NaN;
            self.k_0_theta = NaN;
            self.k_1_z     = NaN;
            self.k_1_theta = NaN;

            self.A_m_z     = NaN;
            self.A_m_theta = NaN;
            self.B_m_z     = NaN;
            self.B_m_theta = NaN;

            % HW20 SECTION END -----------------------------------------
        end

        function x_m_z_dot = z_reference_model_dif_eq(self, x_m_z, z_r)
            % HW20 SECTION START ------------------------------------------
            % Enter the differential equation describing the dynamics of
            % z reference model. The equation should be in state space
            % form. Treat z_r as the input to the system and x_m_z
            % as the state vector. x_m_z_dot is the time derivative of
            % x_m_z which will be used to solve the ODE using 4th order
            % runge-kutta.

            % Differential equation describing how the reference model
            % behaves.
            x_m_z_dot = NaN;
            % HW20 SECTION END -----------------------------------------
        end

        function x_m_theta_dot = theta_reference_model_dif_eq(self, x_m_theta, theta_r)
            % HW20 SECTION START ------------------------------------------
            % Enter the differential equation describing the dynamics of
            % theta reference model. The equation should be in state space
            % form. Treat theta_r as the input to the system and x_m_theta
            % as the state vector. x_m_theta_dot is the time derivative of
            % x_m_theta which will be used to solve the ODE using 4th order
            % runge-kutta.

            % Differential equation describing how the reference model
            % behaves.
            x_m_theta_dot = NaN;
            % HW20 SECTION END -----------------------------------------
        end

        function x_m_z = update_z_reference_model(self, tehta_r)
            % Integrate ODE using Runge-Kutta RK4 algorithm
            x_m_z_dot_1 = self.z_reference_model_dif_eq(self.x_m_z,                       tehta_r);
            x_m_z_dot_2 = self.z_reference_model_dif_eq(self.x_m_z + self.Ts/2*x_m_z_dot_1, tehta_r);
            x_m_z_dot_3 = self.z_reference_model_dif_eq(self.x_m_z + self.Ts/2*x_m_z_dot_2, tehta_r);
            x_m_z_dot_4 = self.z_reference_model_dif_eq(self.x_m_z + self.Ts  *x_m_z_dot_3, tehta_r);
            self.x_m_z = self.x_m_z + self.Ts/6 * (x_m_z_dot_1 + 2*x_m_z_dot_2 + 2*x_m_z_dot_3 + x_m_z_dot_4);
            x_m_z = self.x_m_z;
        end

        function x_m_theta = update_theta_reference_model(self, z_r)
            % Integrate ODE using Runge-Kutta RK4 algorithm
            x_m_theta_dot_1 = self.theta_reference_model_dif_eq(self.x_m_theta,                       z_r);
            x_m_theta_dot_2 = self.theta_reference_model_dif_eq(self.x_m_theta + self.Ts/2*x_m_theta_dot_1, z_r);
            x_m_theta_dot_3 = self.theta_reference_model_dif_eq(self.x_m_theta + self.Ts/2*x_m_theta_dot_2, z_r);
            x_m_theta_dot_4 = self.theta_reference_model_dif_eq(self.x_m_theta + self.Ts  *x_m_theta_dot_3, z_r);
            self.x_m_theta = self.x_m_theta + self.Ts/6 * (x_m_theta_dot_1 + 2*x_m_theta_dot_2 + 2*x_m_theta_dot_3 + x_m_theta_dot_4);
            x_m_theta = self.x_m_theta;
        end
    end
end