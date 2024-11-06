classdef blockBeamObserverLuenberger < handle
    properties

        % Observer States
        states_hat

        % Equiblibrium
        z_e        
        theta_e    
        z_dot_e    
        theta_dot_e
        F_e

        % Time Step
        Ts

        % Observer gains
        K_L

        % Model
        A
        B
        C_m
        D_m
    end
    methods
        function self = blockBeamObserverLuenberger(Param, measurements)

            % Observer States
            self.states_hat = [measurements(1);measurements(2);0;0];

            % Equiblibrium
            self.z_e         = Param.z_e        ;
            self.theta_e     = Param.theta_e    ;
            self.z_dot_e     = Param.z_dot_e    ;
            self.theta_dot_e = Param.theta_dot_e;
            self.F_e         = Param.F_e        ;
    
            % Time Step
            self.Ts = Param.Ts;

            % Model
            self.A   = Param.A  ;
            self.B   = Param.B  ;
            self.C_m = Param.C_m;
            self.D_m = Param.D_m;
    
            % Observer gains
            self.calculate_gains(Param.t_r_o_theta, Param.zeta_o_theta, ...
                Param.t_r_o_z, Param.zeta_o_z, Param.A, Param.C_m)

        end

        function states = update(self, inputs, measurements)
            
            % Integrate ODE using Runge-Kutta RK4 algorithm
            x_hat_dot_1 = self.luenberger_dif_eq(self.states_hat,                         inputs, measurements);
            x_hat_dot_2 = self.luenberger_dif_eq(self.states_hat + self.Ts/2*x_hat_dot_1, inputs, measurements);
            x_hat_dot_3 = self.luenberger_dif_eq(self.states_hat + self.Ts/2*x_hat_dot_2, inputs, measurements);
            x_hat_dot_4 = self.luenberger_dif_eq(self.states_hat + self.Ts  *x_hat_dot_3, inputs, measurements);
            self.states_hat = self.states_hat + self.Ts/6 * (x_hat_dot_1 + 2*x_hat_dot_2 + 2*x_hat_dot_3 + x_hat_dot_4);
            states = self.states_hat;
        end

        function x_hat_dot = luenberger_dif_eq(self, states_hat, inputs, measurements)
            % HW12 SECTION START -----------------------------------------
            % Enter the differential equation describing the luenberge
            % observer. The equation should be in state space form. x_hat
            % is the current estimate of the state (column) vector. u is
            % the system input. y_m is a column vector containing the
            % measurements. x_hat_dot is the derivative of the estimate of
            % the state vector which will be used to solve the ODE using
            % 4rth order runge-kutta. You'll need to calculate the estimate
            % of what the system out put should be (y_hat). Do not forget
            % that we have linearized around z_e and F_e which is not zero.
            % How does that affect your linear observer?

            x_hat_dot = NaN;

            % HW12 SECTION END -----------------------------------------
        end

        function calculate_gains(self, t_r_o_theta, zeta_o_theta, t_r_o_z, zeta_o_z, A, C_m)
            
            % HW12 SECTION START ------------------------------------------
            % Calculate the luenberger observer gain K_L. Save it in the
            % appropriate class properties. To exactly match my solution
            % note that I used the full Equation 8.5 from the textbook. Not
            % the approximation. Also check for observability.

            assert(NaN, "Error: System Not Observable.")
            self.K_L = NaN;

            % HW12 SECTION END --------------------------------------------
            
        end
    end
end