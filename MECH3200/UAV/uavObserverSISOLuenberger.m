classdef uavObserverSISOLuenberger < handle
    properties

        % Parameters
        d

        % Observer States
        states_hat

        % Equilibrium
        F_e

        % Time Step
        Ts

        % Observer gains
        K_L_lon
        K_L_lat

        % Model
        A_lon
        A_lat
        B_lon
        B_lat
        C_m_lon
        C_m_lat
        D_m_lon
        D_m_lat
    end
    methods
        function self = uavObserverSISOLuenberger(Param, measurments)

            % Parameters
            self.d = Param.d;

            % Observer States
            self.states_hat = [measurments;0;0;0];

            % Equilibrium
            self.F_e = Param.F_e;
    
            % Time Step
            self.Ts = Param.Ts;

            % Model
            self.A_lon   = Param.A_lon  ;
            self.A_lat   = Param.A_lat  ;
            self.B_lon   = Param.B_lon  ;
            self.B_lat   = Param.B_lat  ;
            self.C_m_lon = Param.C_m_lon;
            self.C_m_lat = Param.C_m_lat;
            self.D_m_lon = Param.D_m_lon;
            self.D_m_lat = Param.D_m_lat;
    
            % Observer gains
            self.calculate_gains(Param.t_r_o_theta, Param.zeta_o_theta, ...
                Param.t_r_o_z, Param.zeta_o_z, Param.t_r_o_h, Param.zeta_h, ...
                Param.A_lon, Param.A_lat, Param.C_m_lon, Param.C_m_lat)

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
            % Enter the differential equation describing the SISO luenberge
            % observer. The equation should be in state space form. states_hat
            % is the current estimate of the state (column) vector. inputs is
            % the system input. measurements is a column vector containing the
            % measurments. x_hat_dot is the derivative of the estimate of
            % the state vector which will be used to solve the ODE using
            % 4rth order runge-kutta. You'll need to calculate the estimate
            % of what the system out put should be (y_hat).

            x_hat_lon_dot = NaN;
            x_hat_lat_dot = NaN;

            x_hat_dot = NaN;
            
            % HW12 SECTION END -----------------------------------------
        end

        function calculate_gains(self, t_r_o_theta, zeta_o_theta, t_r_o_z, zeta_o_z, t_r_o_h, zeta_o_h, A_lon, A_lat, C_m_lon, C_m_lat)
            
            % HW12 SECTION START ------------------------------------------
            % Calculate the luenberger observer gains K_L_lon and K_L_lat.
            % Lon refers to the longitudinal system (h and F) and lat
            % refers to the lateral system (z, theta, and tau). Save it in
            % the appropriate class properties. To exactly match my
            % solution note that I used the full Equation 8.5 from the
            % textbook. Not the approximation. Also check for
            % observability.

            assert(NaN, "Error: Lateral System Not Observable.")
            assert(NaN, "Error: Longitudinal System Not Observable.")
            self.K_L_lon = NaN;
            self.K_L_lat = NaN;

            % HW12 SECTION END --------------------------------------------
            
        end
    end
end