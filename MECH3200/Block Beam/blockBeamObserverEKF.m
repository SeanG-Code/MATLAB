classdef blockBeamObserverEKF < handle
    properties

        % Parameters
        m_1
        m_2
        ell
        g

        % Equiblibrium
        z_e        
        theta_e    
        z_dot_e    
        theta_dot_e
        F_e

        % Observer States
        states_hat
        P

        % Time Step
        Ts

        % Model
        A
        B
        C_m
        D_m
        G
        Q
        R
    end
    methods
        function self = blockBeamObserverEKF(Param, measurments)

            % Observer States
            self.states_hat = [measurments(1);measurments(2);0;0];
            self.P          = Param.P_0;

            % System properties
            self.m_1 = Param.m_1;
            self.m_2 = Param.m_2;
            self.ell = Param.ell;
            self.g   = Param.g  ;

            % Equiblibrium
            self.z_e         = Param.z_e        ;
            self.theta_e     = Param.theta_e    ;
            self.z_dot_e     = Param.z_dot_e    ;
            self.theta_dot_e = Param.theta_dot_e;
            self.F_e         = Param.F_e        ;
    
            % Time Step
            self.Ts = Param.Ts;

            % Model
            self.A   = Param.A;
            self.B   = Param.B;
            self.C_m = Param.C_m;
            self.D_m = Param.D_m;
    
            % Observer gains
            self.G = Param.G;
            self.Q = Param.Q;
            self.R = Param.R;
        end

        function states = update(self, inputs, measurements)

            % Integrate ODE using Runge-Kutta RK4 algorithm
            [x_hat_dot_1, P_dot_1] = self.ekf_dif_eq(self.states_hat,                         self.P,                     inputs, measurements);
            [x_hat_dot_2, P_dot_2] = self.ekf_dif_eq(self.states_hat + self.Ts/2*x_hat_dot_1, self.P + self.Ts/2*P_dot_1, inputs, measurements);
            [x_hat_dot_3, P_dot_3] = self.ekf_dif_eq(self.states_hat + self.Ts/2*x_hat_dot_2, self.P + self.Ts/2*P_dot_2, inputs, measurements);
            [x_hat_dot_4, P_dot_4] = self.ekf_dif_eq(self.states_hat + self.Ts  *x_hat_dot_3, self.P + self.Ts  *P_dot_3, inputs, measurements);
            self.states_hat = self.states_hat + self.Ts/6 * (x_hat_dot_1 + 2*x_hat_dot_2 + 2*x_hat_dot_3 + x_hat_dot_4);
            self.P          = self.P          + self.Ts/6 * (    P_dot_1 + 2*    P_dot_2 + 2*    P_dot_3 +     P_dot_4);
            states = self.states_hat;
        end

        function [x_hat_dot,P_dot] = ekf_dif_eq(self, states_hat, P, inputs, measurements)

            % Unpack
            z         = states_hat(1);
            theta     = states_hat(2);
            z_dot     = states_hat(3);
            theta_dot = states_hat(4);
            F         = inputs;

            % Unpack parameters for shorter equations
            m_1 = self.m_1;
            m_2 = self.m_2;
            ell = self.ell;
            g   = self.g  ;

            % Relinearize
            A = [                                                                                                                                                                                               0,                                                                          0,                                            1,                                        0;
                                                                                                                                                                                                                0,                                                                          0,                                            0,                                        1;
                                                                                                                                                                                                      theta_dot^2,                                                              -g*cos(theta),                                            0,                            2*theta_dot*z;
                 -(3*m_1*(6*F*ell*z*cos(theta) + 2*ell^2*m_2*theta_dot*z_dot - 6*m_1*theta_dot*z^2*z_dot + ell^2*g*m_2*cos(theta) - 3*g*m_1*z^2*cos(theta) - 3*ell*g*m_2*z*cos(theta)))/(m_2*ell^2 + 3*m_1*z^2)^2, (sin(theta)*(3*ell*g*m_2 - 6*F*ell + 6*g*m_1*z))/(2*m_2*ell^2 + 6*m_1*z^2), -(6*m_1*theta_dot*z)/(m_2*ell^2 + 3*m_1*z^2), -(6*m_1*z*z_dot)/(m_2*ell^2 + 3*m_1*z^2)];

            % HW17 SECTION START -----------------------------------------
            % Enter the differential equations describing kalman filter.
            % states_hat is the current estimate of the state (column) vector. P
            % is the current value of the estimation error auto-covariance
            % matrix. inputs is the system input. measurements is a column vector
            % containing the measurments. x_hat_dot is the derivative of
            % the estimate of the state vector. P_dot is the derivative of
            % the estimation error auto-covariance matrix. Both of which
            % will be used to solve the ODEs using 4th order runge-kutta.
            % You'll need to calculate the estimate of what the system
            % measurments should be (y_hat) as well as the Kalman gain. Use
            % the system properties to access the required constant
            % matricies. To save you some time I have already found the
            % augmented state space matricies at any arbitrary point (i.e.
            % not nessisarly the equilibrium.). Do not forget that
            % we have linearized around z_e and F_e which is not zero. How
            % does that affect your linear observer?

            x_hat_dot = NaN;
            P_dot = NaN;
            
            % HW17 SECTION END --------------------------------------------
        end
    end
end