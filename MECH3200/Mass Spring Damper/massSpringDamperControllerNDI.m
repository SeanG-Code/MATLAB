classdef massSpringDamperControllerNDI < handle
    properties
        % Parameters
        m
        k
        b
        
        % Saturation Limits
        F_min
        F_max

        % Control States
        x_m

        % Time Step
        Ts

        % Gains
        k_0
        k_1
        A_m
        B_m
        
    end
    methods
        function self = massSpringDamperControllerNDI(Param, measurments)
            
            % Save parameters
            self.m = Param.m;
            self.k = Param.k;
            self.b = Param.b;

            % Saturation Limits
            self.F_min = Param.F_min;
            self.F_max = Param.F_max;

            % Time Step
            self.Ts = Param.Ts;

            % Control gains
            self.calculate_gains(Param.t_r_model, Param.zeta_model, Param.t_r_error, Param.zeta_error);

            % Intilize Control States
            self.x_m = [measurments(1);0];
   
        end

        function [F_sat,states_m] = update(self, states, reference)

            % HW20 SECTION START --------------------------------------
            % Impliment NDI control.
            % - States is the state vector. 
            % - Reference is the reference signal (scalar). 
            % The outputs are
            % - F_sat the saturate input (scalar). This is what is actually
            % input into the system. 
            % - u_sat is the saturated input measured from the feedback
            % linearization input (i.e. F_sat_tilde)
            % - states_m is a vector of the same size as states representing the
            % reference model for each state respectively.
            % Use the update_reference_model method to propigate the
            % reference model forward in time. Use the
            % reference_model_dif_eq method to obtain x_m_dot. Don't forget
            % to saturate the input.

            F_sat = NaN;
            states_m = NaN;

            % HW20 SECTION END -----------------------------------------
        end

        function calculate_gains(self, t_r_model, zeta_model, t_r_error, zeta_error)
            % HW20 SECTION START ---------------------------------------
            % Calculate the control gains k_0 and k_1. Also calculate the
            % state space representation of the reference model A_m and
            % B_m. Save them in the appropriate class properties. To
            % exactly match my solution note that I used the full Equation
            % 8.5 from the textbook. Not the approximation.

            self.k_0 = NaN;
            self.k_1 = NaN;
            self.A_m = NaN;
            self.B_m = NaN;

            % HW20 SECTION END -----------------------------------------
        end

        function x_m_dot = reference_model_dif_eq(self, x_m, r)
            % HW20 SECTION START ------------------------------------------
            % Enter the differential equation describing the dynamics of
            % reference model. The equation should be in state space form.
            % Treat r as the input to the system and x_m as the state
            % vector. x_m_dot is the time derivative of x_m which will be
            % used to solve the ODE using 4rth order runge-kutta.

            % Differential equation describing how the reference model
            % behaves.
            x_m_dot = NaN;
            % HW20 SECTION END -----------------------------------------
        end

        function x_m = update_reference_model(self, r)
            % Integrate ODE using Runge-Kutta RK4 algorithm
            x_m_dot_1 = self.reference_model_dif_eq(self.x_m,                       r);
            x_m_dot_2 = self.reference_model_dif_eq(self.x_m + self.Ts/2*x_m_dot_1, r);
            x_m_dot_3 = self.reference_model_dif_eq(self.x_m + self.Ts/2*x_m_dot_2, r);
            x_m_dot_4 = self.reference_model_dif_eq(self.x_m + self.Ts  *x_m_dot_3, r);
            self.x_m = self.x_m + self.Ts/6 * (x_m_dot_1 + 2*x_m_dot_2 + 2*x_m_dot_3 + x_m_dot_4);
            x_m = self.x_m;
        end
    end
end