classdef massSpringDamperQuickDynamics < handle
    properties
        % Parameters
        m  
        k 
        b 

        % Time step
        Ts

        % System state
        states
    end

    methods
        function self = massSpringDamperQuickDynamics(Param)
            % System properties
            self.m = Param.m;
            self.k = Param.k;
            self.b = Param.b;

            % Time step
            self.Ts  = Param.Ts;

            % System state
            self.states = [Param.z_0; Param.z_dot_0];
        end
        
        function states = update(self, input)
            % Propigate the model
            self.rk4_step(input);

            % Set output
            states = self.states;
        end

        function states_dot = dynamics(self, states, input)
            % Unpack
            z     = states(1);
            z_dot = states(2);
            F       = input;

            % Parameters
            m   = self.m;
            k   = self.k;
            b   = self.b;

            % Dynamic Equations
            z_ddot = -k/m*z - b/m*z_dot + 1/m*F;

            % Pack
            states_dot = [z_dot; z_ddot];
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