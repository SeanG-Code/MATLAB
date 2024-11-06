classdef Gillam_massSpringDamperDynamics < handle
    properties
        % Parameters
        m  
        k 
        b  

        % Uncertianty
        z_measurment_std

        % Simulation Parameters
        states
        Ts

        % Saturation
        F_max
        F_min
    end
    methods
        function self = Gillam_massSpringDamperDynamics(Param)
            % System Properties 
            self.m = normrnd(Param.m ,Param.m*Param.parameteric_uncertianty);
            self.k = normrnd(Param.k, Param.k*Param.parameteric_uncertianty);
            self.b = normrnd(Param.b ,Param.b*Param.parameteric_uncertianty);

            self.z_measurment_std = Param.z_measurment_std;

            % Intialize Variables
            self.states = [Param.z_0; Param.z_dot_0];

            % Saturation limits
            self.F_max = Param.F_max;
            self.F_min = Param.F_min;

            % Simulation Parameters
            self.Ts    = Param.Ts;
        end

        function measurments = update(self, input)
            % Saturate input
            input = Gillam_massSpringDamperSaturate(input, self.F_min, self.F_max);

            % Propigate the model
            self.rk4_step(input);

            % Use sensors to measure system state
            measurments = self.sensors();
        end

        function measurments = sensors(self)
            % Measured Values
            z = self.states(1);

            % Add Sensor Noise
            measurments = normrnd(z,self.z_measurment_std);
        end

        function states_dot = dynamics(self, states, input)
            % HW2 SECTION START ------------------------------------------
            % Using the method input variables and class properties,
            % impliment the differential equation describing the dynamics
            % of this system. states is a column vector of the system
            % states. Input is a column vector of the system inputs.
            % states_dot is a column vector of the time derivative of
            % states. See canvas for the order of the states and inputs in 
            % these vectors.

           z  = states(1);
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


            % HW2 SECTION END --------------------------------------------
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