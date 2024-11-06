classdef uavControllerMPC < handle
    properties

        % Parameters
        m_c 
        J_c 
        m_r 
        m_l 
        d   
        mu  
        g

        % State space model
        n
        A
        B
        C_r
        D_r

        % Equilibrium
        F_e

        % Saturation Limits
        f_min
        f_max

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
        function self = uavControllerMPC(Param)

            % System Parameters
            self.m_c = Param.m_c;
            self.J_c = Param.J_c;
            self.m_r = Param.m_r;
            self.m_l = Param.m_l;
            self.d   = Param.d  ;
            self.mu  = Param.mu ;
            self.g   = Param.g  ;

            % Equilibrium
            self.F_e = Param.F_e;
            
            % Saturation Limits
            self.f_min = Param.f_min;
            self.f_max = Param.f_max;

            % State space model
            self.n = size(Param.A,1);
            self.A = Param.A;
            self.B = Param.B;
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
            self.e_integral   = [0;0];
    
            % Values form previous time step
            self.previous_e   = 0;
            self.previous_F   = Param.F_e;
        end

        function inputs_sat = update(self, states, reference)

            % HW16 SECTION START ------------------------------------------
            % Impliment MPC control. By back propigating the riccati
            % equation over the course of the horizon. You will have to
            % solve for the gains K_x, k_i, and K_r at every timestep. From
            % there the implimentation is very similar to the full state
            % feedback with integrator. Use the solve_riccati method to
            % back propigate the riccati equation.
            % - States is the state vector. 
            % - Reference is the reference signals (h and z in that order). 
            % The outputs are
            % - inputs_sat the saturate inputs (f_r and f_l in that order).
            % Apply saturation based integrator antiwindup. When applying
            % anti-windup to the longitudinal system (h and F) use 2*f_min
            % and 2*f_max to saturate the input. When applying anti-windup
            % to the latteral system use plus or minus d*f_max/2. After the
            % mixing you should also saturate each individual motor to be
            % between f_min and f_max. Unlike the textbook you should leave
            % the k_r term in the control law because it stops the
            % integrator from winding up unnessisarily and improves
            % performance. Don't forget to convert your final torque and
            % thrust into individual motor thrusts (one for the left and
            % one for the right).  Remember that we linearized around the
            % equilibrium input F_e. Use NZSP to find k_r. Note that I have
            % not linearized the system around an arbitary point for you.
            % You will have to do that yourself. Save previous_F after all
            % the saturation is complete.

            
            self.e_integral = NaN;
            self.previous_e = NaN;
            inputs_sat = NaN;
            self.previous_F = NaN;

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

            % Riccati Equation
            S_a_dot = NaN;
            
            % HW16 SECTION END --------------------------------------------

        end
    end
end