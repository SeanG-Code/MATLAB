classdef blockBeamControllerMPC < handle
    properties

        % Parameters
        m_1
        m_2
        ell
        g

        % Equiblibrium
        z_e        
        theta_e    
        z_dot_e    
        theta_dot_e
        F_e

        % State space model
        n
        A
        B
        C_r
        D_r
        
        % Saturation Limits
        F_min
        F_max

        % Control States
        e_integral

        % Values form previous time step
        previous_e
        previous_F

        % Time Step
        Ts

        % Gains
        Q_a
        R_a
        horizon
    end
    methods
        function self = blockBeamControllerMPC(Param)

            % System properties
            self.m_1 = Param.m_1;
            self.m_2 = Param.m_2;
            self.ell = Param.ell;
            self.g   = Param.g  ;

            % Equiblibrium
            self.z_e         = Param.z_e        ;
            self.theta_e     = Param.theta_e    ;
            self.z_dot_e     = Param.z_dot_e    ;
            self.theta_dot_e = Param.theta_dot_e;
            self.F_e         = Param.F_e        ;

            % Saturation Limits
            self.F_min = Param.F_min;
            self.F_max = Param.F_max;

            % State space model
            self.n = size(Param.A,1);
            self.A   = Param.A;
            self.B   = Param.B;
            self.C_r = Param.C_r;
            self.D_r = Param.D_r;

            % Time Step
            self.Ts = Param.Ts;

            % Control gains
            self.Q_a = Param.Q_a;
            self.R_a = Param.R_a;
            self.horizon = Param.horizon;

            % Intilize Values --------------------------------------------
            % Control States
            self.e_integral   = 0;
    
            % Values form previous time step
            self.previous_e   = 0;
            self.previous_F   = 0;
        end

        function F_sat = update(self, states, reference)

            % Unpack
            z         = states(1);
            theta     = states(2);
            z_dot     = states(3);
            theta_dot = states(4);
            F         = self.previous_F;

            % Unpack parameters for shorter equations
            m_1 = self.m_1;
            m_2 = self.m_2;
            ell = self.ell;
            g   = self.g  ;

            % Linearize at current state
            A = [                                                                                                                                                                                               0,                                                                          0,                                            1,                                        0;
                                                                                                                                                                                                                0,                                                                          0,                                            0,                                        1;
                                                                                                                                                                                                      theta_dot^2,                                                              -g*cos(theta),                                            0,                            2*theta_dot*z;
                 -(3*m_1*(6*F*ell*z*cos(theta) + 2*ell^2*m_2*theta_dot*z_dot - 6*m_1*theta_dot*z^2*z_dot + ell^2*g*m_2*cos(theta) - 3*g*m_1*z^2*cos(theta) - 3*ell*g*m_2*z*cos(theta)))/(m_2*ell^2 + 3*m_1*z^2)^2, (sin(theta)*(3*ell*g*m_2 - 6*F*ell + 6*g*m_1*z))/(2*m_2*ell^2 + 6*m_1*z^2), -(6*m_1*theta_dot*z)/(m_2*ell^2 + 3*m_1*z^2), -(6*m_1*z*z_dot)/(m_2*ell^2 + 3*m_1*z^2)];

            B = [                                         0;
                                                          0;
                                                          0;
                 (3*ell*cos(theta))/(m_2*ell^2 + 3*m_1*z^2)];


            % Augmented State Space System
            A_a = [A, zeros(self.n,1); -self.C_r, 0];
            B_a = [B; 0];

            % HW16 SECTION START ------------------------------------------
            % Impliment MPC control. By back propigating the riccati
            % equation over the course of the horizon. You will have to
            % solve for the gains K_x, k_i, and K_r at every timestep. From
            % there the implimentation is very similar to the full state
            % feedback with integrator. Use the solve_riccati method to
            % back propigate the riccati equation.
            % - States is the state vector. 
            % - Reference is the reference signal (scalar). 
            % The outputs are
            % - F_sat the saturate input (scalar). This is what is actually
            % input into the system. 
            % Apply saturation based integrator antiwindup. You should
            % leave the k_r term in the control law because it stops the
            % integrator from winding up unnessisarily and improves
            % performance. Use NZSP to find k_r. To save you some time I
            % have already found the augmented state space matricies at any
            % arbitrary point (i.e. not nessisarly the equilibrium.). Do
            % NOT apply feedback lineraization. However, do not forget that
            % we have linearized around z_e and F_e which is not zero. How
            % does that affect your linear control law?

            self.e_integral = NaN;
            self.previous_e = NaN;
            F_sat = NaN;

            % HW16 SECTION END --------------------------------------------
        end

        function S_a = solve_riccati(self, A_a, B_a)
            S_a = zeros(size(A_a));
            for i = 1:self.horizon
                % Integrate ODE using Runge-Kutta RK4 algorithm. Make ODE
                % negative to integrate backwards in time.
                S_a_dot_1 = -self.riccati(S_a                      , A_a, B_a);
                S_a_dot_2 = -self.riccati(S_a + self.Ts/2*S_a_dot_1, A_a, B_a);
                S_a_dot_3 = -self.riccati(S_a + self.Ts/2*S_a_dot_2, A_a, B_a);
                S_a_dot_4 = -self.riccati(S_a + self.Ts  *S_a_dot_3, A_a, B_a);
                S_a = S_a + self.Ts/6 * (S_a_dot_1 + 2*S_a_dot_2 + 2*S_a_dot_3 + S_a_dot_4); 
            end
        end

        function S_a_dot = riccati(self, S_a, A_a, B_a)
            % HW16 SECTION START -----------------------------------------
            % Enter the Riccati equation. S_a is the current value of the
            % riccati state matrix. A_a and B_a are the augmented system
            % state space matricies evaluated at the current timestep.
            % S_a_dot is the derivative of the Riccati state matrix which
            % will be used to solve the ODE using 4th order runge-kutta.
            
            S_a_dot = NaN;
            
            % HW16 SECTION END --------------------------------------------

        end
    end
end