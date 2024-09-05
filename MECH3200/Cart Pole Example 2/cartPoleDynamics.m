classdef cartPoleDynamics < handle
    properties
        % Parameters
        m_1
        m_2
        ell
        g  
        b  

        % Uncertianty
        z_measurment_std
        theta_measurment_std
        input_disturbance

        % Simulation Parameters
        states
        Ts

        % Saturation
        F_max
        F_min
    end
    methods
        function self = cartPoleDynamics(Param)
            % System Properties 
            self.m_1 = normrnd(Param.m_1,Param.m_1*Param.parameteric_uncertianty);
            self.m_2 = normrnd(Param.m_2,Param.m_2*Param.parameteric_uncertianty);
            self.ell = normrnd(Param.ell,Param.ell*Param.parameteric_uncertianty);
            self.g   = Param.g;
            self.b   = normrnd(Param.b  ,Param.b  *Param.parameteric_uncertianty);
            

            self.theta_measurment_std = Param.theta_measurment_std;
            self.z_measurment_std     = Param.z_measurment_std;
            self.input_disturbance    = Param.input_disturbance;         

            % Intialize Variables
            self.states = [Param.z_0; Param.theta_0; Param.z_dot_0; Param.theta_dot_0];

            % Saturation limits
            self.F_max = Param.F_max;
            self.F_min = Param.F_min;

            % Simulation Parameters
            self.Ts    = Param.Ts;
        end

        function measurments = update(self, input)
            % Saturate input
            input = cartPoleSaturate(input + self.input_disturbance, self.F_min, self.F_max);

            % Propigate the model
            self.rk4_step(input);

            % Use sensors to measure system state
            measurments = self.sensors();
        end

        function measurments = sensors(self)
            % Measured Values
            z     = self.states(1);
            theta = self.states(2);

            % Add Sensor Noise
            measurments = [normrnd(    z, self.z_measurment_std);
                           normrnd(theta, self.theta_measurment_std)];
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

            % Unpack
            %z         = states(1);
            theta     = states(2);
            z_dot     = states(3);
            theta_dot = states(4);
            F         = input;

            % Dynamics Equations
            equations_of_motion = [self.m_1 + self.m_2, self.m_1*self.ell/2*cos(theta);
            self.m_1*self.ell/2*cos(theta), self.m_1*self.ell^2/3]^-1 ...
            *[self.m_1*self.ell/2*theta_dot^2*sin(theta) + F - self.b*z_dot;
              self.m_1*self.g*self.ell/2*sin(theta)];
            z_ddot = equations_of_motion(1);
            theta_ddot = equations_of_motion(2);

            % Pack
            states_dot = [z_dot; theta_dot; z_ddot; theta_ddot];
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