classdef Gillam_blockBeamQuickDynamics < handle
    properties
        % System Properties
        m_1
        m_2
        ell
        g

        % Time Step
        Ts

        % System State
        states
    end

    methods
        function self = Gillam_blockBeamQuickDynamics(Param)
            % System Properties
            self.m_1 = Param.m_1;
            self.m_2 = Param.m_2;
            self.ell = Param.ell;
            self.g   = Param.g;

            % Time Step
            self.Ts = Param.Ts;

            %System State
            self.states = [Param.z_0; Param.theta_0; Param.z_dot_0; Param.theta_dot_0]; 
        end

        function states = update(self, input)
            % Propigate the model
            self.rk4_step(input);

            % Set Output
            states = self.states;
        end

        function states_dot = dynamics(self, states, input)
            % Unpack
            z         = states(1);
            theta     = states(2);
            z_dot     = states(3);
            theta_dot = states(4);
            F         = input;

            % Dynamics Equations
            equations_of_motion = [z*theta_dot^2 - self.g*sin(theta);
                                   (((-6*self.m_1)/((3*self.m_1*z^2)+(self.m_2*self.ell^2)))*z*z_dot*theta_dot) - ...
                                   ((((6*self.m_1*self.g*z)+(3*self.m_2*self.g*self.ell)-(6*F*self.ell))/((6*self.m_1*z^2)+(2*self.m_2*self.ell^2)))*cos(theta))];
            z_ddot = equations_of_motion(1);
            theta_ddot = equations_of_motion(2);

            % Pack
            states_dot = [z_dot; theta_dot; z_ddot; theta_ddot];
        end

        function rk4_step(self, input)
            % Integrate ODE using Runge-Kutta RK4 algorithm
            states_dot_1 = self.dynamics(self.states,                          input);
            states_dot_2 = self.dynamics(self.states + self.Ts/2*states_dot_1, input);
            states_dot_3 = self.dynamics(self.states + self.Ts/2*states_dot_2, input);
            states_dot_4 = self.dynamics(self.states + self.Ts  *states_dot_3, input);
            self.states = self.states + self.Ts/6 * (states_dot_1 + 2*states_dot_2 + 2*states_dot_3 + states_dot_4);
        end
    end
end