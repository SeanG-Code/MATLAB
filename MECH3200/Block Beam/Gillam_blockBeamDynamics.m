classdef Gillam_blockBeamDynamics < handle
    properties
        % Parameters
        m_1
        m_2
        ell
        g
        
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
        function self = Gillam_blockBeamDynamics(Param)
            % System Properties 
            self.m_1 = normrnd(Param.m_1,Param.m_1*Param.parameteric_uncertianty);
            self.m_2 = normrnd(Param.m_2,Param.m_2*Param.parameteric_uncertianty);
            self.ell = normrnd(Param.ell,Param.ell*Param.parameteric_uncertianty);
            self.g   = Param.g;

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
            input = Gillam_blockBeamSaturate(input + self.input_disturbance, self.F_min, self.F_max);

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
            measurments = [normrnd(z,     self.z_measurment_std    );
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
            z         = states(1);
            theta     = states(2);
            z_dot     = states(3);
            theta_dot = states(4);
            F         = input;

            % Parameters
            m_1 = self.m_1;
            m_2 = self.m_2;
            ell = self.ell;
            g   = self.g  ;
            %%b   = self.b  ;

            
            % Dynamic Equations
            %%equations_of_motion = [m_1 + m_2, m_1*ell/2*cos(theta);
            %%m_1*ell/2*cos(theta), m_1*ell^2/3]^-1 ...
           %%% *[m_1*ell/2*theta_dot^2*sin(theta) + F - b*z_dot;
            %%  m_1*g*ell/2*sin(theta)];
            %%z_ddot = equations_of_motion(1);
            %%theta_ddot = equations_of_motion(2);

            % Pack
         
             z_ddot = ((z * (theta_dot^2)) - (g * sin(theta)));
    theta_ddot = ((-6*m_1)/((3*m_1*z^2) + (m_2*ell^2)) * (z*z_dot*theta_dot)) - ...
       ((6*m_1*g*z) + (3*m_2*g*ell) - (6*F*ell)) / ((6*m_1*z^2) + (2*m_2*(ell^2))) * cos(theta);
          %% z_ddot=(z*(theta_dot)^2)-(g*sin(theta));

           %theta_ddot=(((-6*m_1)/(((3*m_1)*(z^2))+(m_2*(ell)^2))*z*z_dot*theta_dot))-((6*m_1*g*z)+(3*m_2*g*ell)-((6*F*ell))/(6*m_1*(z^2)+(2*m_2*(ell^2)))*(cos(theta)));
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