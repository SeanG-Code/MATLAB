classdef cartPoleQuickDynamics < handle
    properties
        % System properties
        m_1
        m_2
        ell
        g
        b

        % Time step
        Ts

        % System state
        states
    end

    methods
        function self = cartPoleQuickDynamics(Param)
            % System properties
            self.m_1 = Param.m_1;
            self.m_2 = Param.m_2;
            self.ell = Param.ell;
            self.g   = Param.g  ;
            self.b   = Param.b  ;

            % Time step
            self.Ts  = Param.Ts;

            % System state
            self.states = [Param.z_0; Param.theta_0; Param.z_dot_0; Param.theta_dot_0];
        end
        
        function states = update(self, input)
            % Propigate the model
            self.rk4_step(input);

            % Set output
            states = self.states;
        end

        function states_dot = dynamics(self, states, input)
            % Unpack
            % z         = states(1);
            theta     = states(2);
            z_dot     = states(3);
            theta_dot = states(4);
            F         = input;

            % Parameters
            m_1 = self.m_1;
            m_2 = self.m_2;
            ell = self.ell;
            g   = self.g  ;
            b   = self.b  ;

            
            % Dynamic Equations
            equations_of_motion = [m_1 + m_2, m_1*ell/2*cos(theta);
            m_1*ell/2*cos(theta), m_1*ell^2/3]^-1 ...
            *[m_1*ell/2*theta_dot^2*sin(theta) + F - b*z_dot;
              m_1*g*ell/2*sin(theta)];
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