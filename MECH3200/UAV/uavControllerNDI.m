classdef uavControllerNDI < handle
    properties
        % Parameters
        m_c 
        J_c 
        m_r 
        m_l 
        d   
        mu  
        g
        
        % Saturation Limits
        f_min
        f_max
        theta_max
        theta_min

        % Control States
        x_m_h
        x_m_z
        x_m_theta

        % Time Step
        Ts

        % Gains
        k_0_h
        k_1_h
        k_0_z
        k_1_z
        k_0_theta
        k_1_theta
        A_m_h
        B_m_h
        A_m_z
        B_m_z
        A_m_theta
        B_m_theta 
        
    end
    methods
        function self = uavControllerNDI(Param, measurments)
            
            % System Parameters
            self.m_c = Param.m_c;
            self.J_c = Param.J_c;
            self.m_r = Param.m_r;
            self.m_l = Param.m_l;
            self.d   = Param.d  ;
            self.mu  = Param.mu ;
            self.g   = Param.g  ;

            % Saturation Limits
            self.f_min     = Param.f_min;
            self.f_max     = Param.f_max;
            self.theta_min = Param.theta_min;
            self.theta_max = Param.theta_max;

            % Time Step
            self.Ts = Param.Ts;

            % Control gains
            self.calculate_gains(Param.t_r_model_h, ...
                                 Param.zeta_model_h, ...
                                 Param.t_r_model_z, ...
                                 Param.zeta_model_z, ...
                                 Param.t_r_model_theta, ...
                                 Param.zeta_model_theta, ...
                                 Param.t_r_error_h, ...
                                 Param.zeta_error_h, ...
                                 Param.t_r_error_z, ...
                                 Param.zeta_error_z, ...
                                 Param.t_r_error_theta   , ...
                                 Param.zeta_error_theta);

            % Intilize Control States
            self.x_m_h     = [measurments(1);0];
            self.x_m_z     = [measurments(2);0];
            self.x_m_theta = [measurments(3);0];
   
        end

        function [inputs_sat,states_m,theta_r_sat] = update(self, states, reference)

            % HW20 SECTION START --------------------------------------
            % Impliment NDI control.
            % - States is the state vector. 
            % - Reference is the reference signals (h and z in that order). 
            % The outputs are
            % - inputs_sat the saturate inputs (f_r and f_l in that order).
            % This is what is actually input into the system.
            % - states_m is a vector of the same size as states representing the
            % reference model for each state respectively.
            % - theta_r_sat is output of the outer loop which is feed to
            % the inner loop as the reference signal. It has been saturated
            % so that theta is between self.theta_min and self.theta_max.
            % You do not need to saturate the thrust and torque. Instead
            % you should only saturate the individual motor thrust after
            % mixing. Use the update_h_reference_model,
            % update_z_reference_model, and update_theta_reference_model
            % methods to propigate the reference model forward in time. Use
            % the h_reference_model_dif_eq, z_reference_model_dif_eq, and
            % theta_reference_model_dif_eq method to obtain x_m_dot. Don't
            % forget to convert your final torque and thrust into
            % individual motor thrusts (one for the left and one for the
            % right).

            theta_r_sat = NaN;
            inputs_sat = NaN;
            states_m = NaN;

            % HW20 SECTION END -----------------------------------------
        end

        function calculate_gains(self, t_r_model_h , ...
                                       zeta_model_h, ...
                                       t_r_model_z , ...
                                       zeta_model_z, ...
                                       t_r_model_theta   , ...
                                       zeta_model_theta  , ...
                                       t_r_error_h , ...
                                       zeta_error_h, ...
                                       t_r_error_z , ...
                                       zeta_error_z, ...
                                       t_r_error_theta   , ...
                                       zeta_error_theta)

            % HW20 SECTION START ---------------------------------------
            % Calculate the control gains k_0 and k_1. You will need these
            % gains for h, z, and theta. Also calculate the state space
            % representation of the reference model A_m and B_m for each of
            % h, z, and theta. Save them in the appropriate class
            % properties. To exactly match my solution note that I used the
            % full Equation 8.5 from the textbook. Not the approximation.

            self.k_0_h     = NaN;
            self.k_0_z     = NaN;
            self.k_0_theta = NaN;
            self.k_1_h     = NaN;
            self.k_1_z     = NaN;
            self.k_1_theta = NaN;

            % Reference model
            self.A_m_h     = NaN;
            self.A_m_z     = NaN;
            self.A_m_theta = NaN;
            self.B_m_h     = NaN;
            self.B_m_z     = NaN;
            self.B_m_theta = NaN;

            % HW20 SECTION END -----------------------------------------
        end

        function x_m_h_dot = h_reference_model_dif_eq(self, x_m_h, h_r)
            % HW20 SECTION START ------------------------------------------
            % Enter the differential equation describing the dynamics of
            % h reference model. The equation should be in state space
            % form. Treat h_r as the input to the system and x_m_h
            % as the state vector. x_m_h_dot is the time derivative of
            % x_m_h which will be used to solve the ODE using 4th order
            % runge-kutta.

            % Differential equation describing how the reference model
            % behaves.
            x_m_h_dot = NaN;
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

        function x_m_h = update_h_reference_model(self, h_r)
            % Integrate ODE using Runge-Kutta RK4 algorithm
            x_m_h_dot_1 = self.h_reference_model_dif_eq(self.x_m_h,                         h_r);
            x_m_h_dot_2 = self.h_reference_model_dif_eq(self.x_m_h + self.Ts/2*x_m_h_dot_1, h_r);
            x_m_h_dot_3 = self.h_reference_model_dif_eq(self.x_m_h + self.Ts/2*x_m_h_dot_2, h_r);
            x_m_h_dot_4 = self.h_reference_model_dif_eq(self.x_m_h + self.Ts  *x_m_h_dot_3, h_r);
            self.x_m_h = self.x_m_h + self.Ts/6 * (x_m_h_dot_1 + 2*x_m_h_dot_2 + 2*x_m_h_dot_3 + x_m_h_dot_4);
            x_m_h = self.x_m_h;
        end

        function x_m_z = update_z_reference_model(self, z_r)
            % Integrate ODE using Runge-Kutta RK4 algorithm
            x_m_z_dot_1 = self.z_reference_model_dif_eq(self.x_m_z,                         z_r);
            x_m_z_dot_2 = self.z_reference_model_dif_eq(self.x_m_z + self.Ts/2*x_m_z_dot_1, z_r);
            x_m_z_dot_3 = self.z_reference_model_dif_eq(self.x_m_z + self.Ts/2*x_m_z_dot_2, z_r);
            x_m_z_dot_4 = self.z_reference_model_dif_eq(self.x_m_z + self.Ts  *x_m_z_dot_3, z_r);
            self.x_m_z = self.x_m_z + self.Ts/6 * (x_m_z_dot_1 + 2*x_m_z_dot_2 + 2*x_m_z_dot_3 + x_m_z_dot_4);
            x_m_z = self.x_m_z;
        end

        function x_m_theta = update_theta_reference_model(self, theta_r)
            % Integrate ODE using Runge-Kutta RK4 algorithm
            x_m_theta_dot_1 = self.theta_reference_model_dif_eq(self.x_m_theta,                             theta_r);
            x_m_theta_dot_2 = self.theta_reference_model_dif_eq(self.x_m_theta + self.Ts/2*x_m_theta_dot_1, theta_r);
            x_m_theta_dot_3 = self.theta_reference_model_dif_eq(self.x_m_theta + self.Ts/2*x_m_theta_dot_2, theta_r);
            x_m_theta_dot_4 = self.theta_reference_model_dif_eq(self.x_m_theta + self.Ts  *x_m_theta_dot_3, theta_r);
            self.x_m_theta = self.x_m_theta + self.Ts/6 * (x_m_theta_dot_1 + 2*x_m_theta_dot_2 + 2*x_m_theta_dot_3 + x_m_theta_dot_4);
            x_m_theta = self.x_m_theta;
        end
    end
end