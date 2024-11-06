classdef Gillam_uavDynamics < handle
    properties
        % Parameters
        m_c 
        J_c 
        m_r 
        m_l 
        d   
        mu  
        g
        
        % Uncertianty
        h_measurment_std
        z_measurment_std
        theta_measurment_std
        input_disturbance

        % Simulation Parameters
        states
        Ts

        % Saturation
        f_max
        f_min
    end
    methods
        function self = Gillam_uavDynamics(Param)
            % System Properties 
            self.m_c = normrnd(Param.m_c,Param.m_c*Param.parameteric_uncertianty);
            self.J_c = normrnd(Param.J_c,Param.J_c*Param.parameteric_uncertianty);
            self.m_r = normrnd(Param.m_r,Param.m_r*Param.parameteric_uncertianty);
            self.m_l = normrnd(Param.m_l,Param.m_l*Param.parameteric_uncertianty);
            self.d   = normrnd(Param.d,  Param.d  *Param.parameteric_uncertianty);
            self.mu  = normrnd(Param.mu ,Param.mu *Param.parameteric_uncertianty);
            self.g   = Param.g;

            self.h_measurment_std     = Param.h_measurment_std;
            self.z_measurment_std     = Param.z_measurment_std;
            self.theta_measurment_std = Param.theta_measurment_std;
            self.input_disturbance    = Param.input_disturbance;         

            % Intialize Variables
            self.states = [Param.h_0; Param.z_0; Param.theta_0; Param.h_dot_0; Param.z_dot_0; Param.theta_dot_0];

            % Saturation limits
            self.f_max = Param.f_max;
            self.f_min = Param.f_min;

            % Simulation Parameters
            self.Ts    = Param.Ts;
        end

        function measurments = update(self, input)
            % Saturate input
            input = Gillam_uavSaturate(input + self.input_disturbance, self.f_min, self.f_max);

            % Propigate the model
            self.rk4_step(input);

            % Use sensors to measure system state
            measurments = self.sensors();
        end

        function measurments = sensors(self)
            % Measured Values
            h     = self.states(1);
            z     = self.states(2);
            theta = self.states(3);

            % Add Sensor Noise
            measurments = [normrnd(h,     self.h_measurment_std    );
                           normrnd(z,     self.z_measurment_std    );
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
            theta = states(3);
            h_dot = states(4);
            z_dot = states(5);
            theta_dot = states(6); 
            m_c = self.m_c; %#ok<PROPLC> 
            J_c = self.J_c; %#ok<PROPLC> 
            m_r = self.m_r; %#ok<PROPLC> 
            m_l = self.m_l; %#ok<PROPLC> 
            d = self.d; %#ok<PROPLC> 
            mu = self.mu; %#ok<PROPLC> 
            g = self.g; %#ok<PROPLC> 
            f_l = input (2);
            f_r = input (1);

            h_ddot = ( (f_l + f_r)*cos(theta) - (m_c + m_r+ m_l)*g ) / (m_c + m_r +m_l); %#ok<PROPLC> 
            z_ddot = (-(f_l + f_r)*sin(theta) - mu*z_dot ) / (m_c + m_r + m_l); %#ok<PROPLC> 
            theta_ddot = ( d*(f_r - f_l) ) / (J_c + (m_r + m_l)*d^2); %#ok<PROPLC> 

            states_dot = [h_dot; z_dot; theta_dot; h_ddot; z_ddot; theta_ddot];


            

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