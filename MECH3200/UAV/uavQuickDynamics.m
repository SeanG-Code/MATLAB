classdef uavQuickDynamics < handle
    properties
        % Parameters
        J_s
        J_p
        k  
        b  

        % Time step
        Ts

        % System state
        states
    end

    methods
        function self = uavQuickDynamics(Param)
            % System properties
            self.J_s = Param.J_s;
            self.J_p = Param.J_p;
            self.k   = Param.k  ;
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
            z     = states(1);
            theta       = states(2);
            z_dot = states(3);
            theta_dot   = states(4);
            tau       = input;

            % Parameters
            J_s = self.J_s;
            J_p = self.J_p;
            k   = self.k  ;
            b   = self.b  ;

            
            % Dynamic Equations
            z_ddot = 1/J_s*(tau-b*(z_dot-theta_dot)-k*(z-theta));
            theta_ddot   = 1/J_p*(    b*(z_dot-theta_dot)+k*(z-theta));

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