classdef massSpringDamperObserverLuenberger < handle
    properties

        % Observer States
        states_hat

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
        function self = massSpringDamperObserverLuenberger(Param, measurments)

            % Observer States
            self.states_hat = [measurments(1);0];
    
            % Time Step
            self.Ts = Param.Ts;

            % Model
            self.A   = Param.A  ;
            self.B   = Param.B  ;
            self.C_m = Param.C_m;
            self.D_m = Param.D_m;
    
            % Observer gains
            self.calculate_gains(Param.t_r_o, Param.zeta_o, Param.A, Param.C_m)

        end

        function states = update(self, inputs, measurments)

            % Integrate ODE using Runge-Kutta RK4 algorithm
            x_hat_dot_1 = self.luenberger_dif_eq(self.states_hat,                         inputs, measurments);
            x_hat_dot_2 = self.luenberger_dif_eq(self.states_hat + self.Ts/2*x_hat_dot_1, inputs, measurments);
            x_hat_dot_3 = self.luenberger_dif_eq(self.states_hat + self.Ts/2*x_hat_dot_2, inputs, measurments);
            x_hat_dot_4 = self.luenberger_dif_eq(self.states_hat + self.Ts  *x_hat_dot_3, inputs, measurments);
            self.states_hat = self.states_hat + self.Ts/6 * (x_hat_dot_1 + 2*x_hat_dot_2 + 2*x_hat_dot_3 + x_hat_dot_4);
            states = self.states_hat;
        end

        function x_hat_dot = luenberger_dif_eq(self, states_hat, inputs, measurments)
            % HW12 SECTION START -----------------------------------------
            % Enter the differential equation describing the luenberge
            % observer. The equation should be in state space form.
            % states_hat is the current estimate of the state (column)
            % vector. inputs is the system input. measurments is a column
            % vector containing the measurments. x_hat_dot is the
            % derivative of the estimate of the state vector which will be
            % used to solve the ODE using 4rth order runge-kutta. You'll
            % need to calculate the estimate of what the system out put
            % should be (y_hat).

            x_hat_dot = NaN;

            % HW12 SECTION END -----------------------------------------
        end

        function calculate_gains(self,t_r,zeta,A,C_m)

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