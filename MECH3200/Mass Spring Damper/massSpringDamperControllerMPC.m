classdef massSpringDamperControllerMPC < handle
    properties

        % State space model
        n
        A
        B
        C_r
        D_r
        A_a
        B_a
        
        % Saturation Limits
        F_min
        F_max

        % Control States
        e_integral

        % Values form previous time step
        previous_e

        % Time Step
        Ts

        % Gains
        Q_a
        R_a
        horizon
    end
    methods
        function self = massSpringDamperControllerMPC(Param)

            % Saturation Limits
            self.F_min = Param.F_min;
            self.F_max = Param.F_max;

            % State space model
            self.n = size(Param.A,1);
            self.A   = Param.A;
            self.B   = Param.B;
            self.C_r = Param.C_r;
            self.D_r = Param.D_r;
            self.A_a = [Param.A, zeros(self.n,1); -Param.C_r, 0];
            self.B_a = [Param.B; 0];

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
        end

        function F_sat = update(self, states, reference)

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
            % - u_sat is the saturated input measured from the feedback
            % linearization input (i.e. F_sat_tilde)
            % Do not forget to apply feedback linearization. Apply
            % saturation based anti-windup. You should leave the k_r term
            % in the control law because it stops the integrator from
            % winding up unnessisarily and improves performance. Use NZSP
            % to find k_r. Because this system is already linear (after
            % feedback linearization) you don't need to change the A and B
            % matricies at each timestep. That does mean you will get the
            % same solution to the ricatti equation everytime timestep, but
            % changing the horizon will still have interesting effects on
            % the optimallity of the resulting responce.
            
            self.e_integral = NaN;
            self.previous_e = NaN;
            F_sat = NaN;

            % HW16 SECTION END --------------------------------------------
        end

        function S_a = solve_riccati(self)
            S_a = zeros(size(self.A_a));
            for i = 1:self.horizon
                % Integrate ODE using Runge-Kutta RK4 algorithm. Make ODE
                % negative to integrate backwards in time.
                S_a_dot_1 = -self.riccati(S_a                    );
                S_a_dot_2 = -self.riccati(S_a + self.Ts/2*S_a_dot_1);
                S_a_dot_3 = -self.riccati(S_a + self.Ts/2*S_a_dot_2);
                S_a_dot_4 = -self.riccati(S_a + self.Ts  *S_a_dot_3);
                S_a = S_a + self.Ts/6 * (S_a_dot_1 + 2*S_a_dot_2 + 2*S_a_dot_3 + S_a_dot_4); 
            end
        end

        function S_a_dot = riccati(self, S_a)
            % HW16 SECTION START -----------------------------------------
            % Enter the Riccati equation. S_a is the current value of the
            % riccati state matrix. Use the class properties to obtain the
            % augmented system state space matricies evaluated at the
            % current timestep. S_a_dot is the derivative of the Riccati
            % state matrix which will be used to solve the ODE using 4th
            % order runge-kutta.

            S_a_dot = NaN;

            % HW16 SECTION END --------------------------------------------

        end
    end
end