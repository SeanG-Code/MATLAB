classdef massSpringDamperObserverKalman < handle
    properties

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
        function self = massSpringDamperObserverKalman(Param, measurments)

            % Observer States
            self.states_hat = [measurments(1);0];
            self.P     = Param.P_0;
    
            % Time Step
            self.Ts = Param.Ts;

            % Model
            self.A   = Param.A  ;
            self.B   = Param.B  ;
            self.C_m = Param.C_m;
            self.D_m = Param.D_m;
    
            % Observer gains
            self.G = Param.G;
            self.Q = Param.Q;
            self.R = Param.R;
        end

        function states = update(self, inputs, measurements)

            % Integrate ODE using Runge-Kutta RK4 algorithm
            [x_hat_dot_1, P_dot_1] = self.kalman_dif_eq(self.states_hat,                         self.P,                     inputs, measurements);
            [x_hat_dot_2, P_dot_2] = self.kalman_dif_eq(self.states_hat + self.Ts/2*x_hat_dot_1, self.P + self.Ts/2*P_dot_1, inputs, measurements);
            [x_hat_dot_3, P_dot_3] = self.kalman_dif_eq(self.states_hat + self.Ts/2*x_hat_dot_2, self.P + self.Ts/2*P_dot_2, inputs, measurements);
            [x_hat_dot_4, P_dot_4] = self.kalman_dif_eq(self.states_hat + self.Ts  *x_hat_dot_3, self.P + self.Ts  *P_dot_3, inputs, measurements);
            self.states_hat = self.states_hat + self.Ts/6 * (x_hat_dot_1 + 2*x_hat_dot_2 + 2*x_hat_dot_3 + x_hat_dot_4);
            self.P     = self.P     + self.Ts/6 * (    P_dot_1 + 2*    P_dot_2 + 2*    P_dot_3 +     P_dot_4);
            states = self.states_hat;
        end

        function [x_hat_dot,P_dot] = kalman_dif_eq(self, states_hat, P, inputs, measurements)

            % HW17 SECTION START -----------------------------------------
            % Enter the differential equations describing a linear Kalman
            % Filter. We use the linear version because the feedback
            % linearized system is linear. x_hat is the current estimate of
            % the state (column) vector. P is the current value of the
            % estimation error auto-covariance matrix. u is the system
            % input. y_m is a column vector containing the measurments.
            % x_hat_dot is the derivative of the estimate of the state
            % vector. P_dot is the derivative of the estimation error
            % auto-covariance matrix. Both of which will be used to solve
            % the ODEs using 4rth order runge-kutta. You'll need to
            % calculate the estimate of what the system measurments should
            % be (y_hat) as well as the Kalman gain. Remember that you
            % should use the linear equations for the propigation phase,
            % not the nonlinear equations. Use the system properties to
            % access the required constant matricies.

            x_hat_dot = NaN;
            P_dot = NaN;
            % HW17 SECTION END --------------------------------------------
        end
    end
end