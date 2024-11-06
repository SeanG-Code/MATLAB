classdef blockBeamControllerMRAC < handle
    properties
        % State Space
        B

        % Equiblibrium
        z_e        
        theta_e    
        z_dot_e    
        theta_dot_e
        F_e
        
        % Saturation Limits
        F_min
        F_max

        % Control States
        x_m

        % Time Step
        Ts

        % Gains
        P
        Gamma_x
        Gamma_r
        K_x
        K_r
        A_m
        B_m
        sign_of_Lambda
        
    end
    methods
        function self = blockBeamControllerMRAC(Param, measurments)

            % State Space
            A      = Param.A;
            self.B = Param.B;
            % The system components related to theta are ignored because
            % they are nonminimum phase. We assume that these elements are
            % unmoddeled dynamics and allow them to converge to their
            % stable equilibrium at theta = 180 degrees.

            % Saturation Limits
            self.F_min = Param.F_min;
            self.F_max = Param.F_max;

            % Equiblibrium
            self.z_e         = Param.z_e        ;
            self.theta_e     = Param.theta_e    ;
            self.z_dot_e     = Param.z_dot_e    ;
            self.theta_dot_e = Param.theta_dot_e;
            self.F_e         = Param.F_e        ;

            % Time Step
            self.Ts = Param.Ts;

            % Control gains
            self.calculate_gains(Param.t_r_z, Param.zeta_z, ...
                Param.t_r_theta, Param.zeta_theta, A, self.B, Param.C_r, Param.Q_lyap);
            self.Gamma_x        = Param.Gamma_x;
            self.Gamma_r        = Param.Gamma_r;
            self.sign_of_Lambda = Param.sign_of_Lambda;

            % Intilize Values --------------------------------------------
            % Control States
            self.x_m = [measurments(1);measurments(2);0;0] - [self.z_e; self.theta_e; self.z_dot_e; self.theta_dot_e];
   
        end

        function [F_sat,states_m] = update(self, states, reference)

            % HW22 SECTION START --------------------------------------
            % Impliment MRAC control.
            % - States is the state vector. 
            % - Reference is the reference signal (scalar). 
            % The outputs are
            % - F_sat the saturate input (scalar). This is what is actually
            % input into the system. 
            % - states_m is a vector of the same size as states representing the
            % reference model for each state respectively.
            % Use the update_reference_model method to propigate the
            % reference model forward in time. Use the
            % update_adapting_gains method to propigate the adapting gains
            % forward in time. Don't forget to saturate the input. Do NOT
            % apply feedback lineraization. However, do not forget that we
            % have linearized around z_e and F_e which is not zero. How
            % does that affect your linear control law?

            states_m = NaN;
            F_sat = NaN;

            % HW22 SECTION END ----------------------------------------
        end

        function calculate_gains(self, t_r_z, zeta_z, t_r_theta, zeta_theta, A, B, C_r, Q)

            % HW22 SECTION START ---------------------------------------
            % Calculate an initial guess for the gains K_x and K_r assuming
            % there is no parametric uncertianty using Ackermann's formula.
            % Then use those gains to calculate what A_m and B_m. Would be
            % if the paramters were known. Finally, solve Lyapunov equation
            % for P using the Matlab lyap function, A_m, and Q. A_m must be
            % transposed because Matlab solves AP + PA' = -Q. However we
            % want A'P + PA = -Q. Save them in the appropriate class
            % properties. To exactly match my solution note that I used the
            % full Equation 8.5 from the textbook. Not the approximation.

            self.K_x = NaN;
            self.K_r = NaN;
            self.A_m = NaN;
            self.B_m = NaN;
            self.P   = NaN;

            % HW22 SECTION END ----------------------------------------
        end

        function [K_x_dot, K_r_dot] = adaptive_law(self,x,r,e)

            % HW22 SECTION START ------------------------------------------
            % Enter the differential equation describing the time evolution
            % of the adapting control gain. x is the system state (column)
            % vector, r is the reference, and e is the error between the
            % system output and the reference signal. K_x_dot and K_r_dot
            % are the time derivative of the adapting gains which will be
            % used to solve the ODE using Euler's method.

            % Adaptive laws
            K_x_dot = NaN;
            K_r_dot = NaN;

            % HW22 SECTION END ----------------------------------------
        end

        function [K_x,K_r] = update_adapting_gains(self,x,r,e)
            
            % Differential equations describing how the gains change over time
            [K_x_dot, K_r_dot] = adaptive_law(self,x,r,e);

            % Integrate ODE using the Euler method
            self.K_x = self.K_x + self.Ts * K_x_dot;
            self.K_r = self.K_r + self.Ts * K_r_dot;

            % Pack for return
            K_x = self.K_x;
            K_r = self.K_r;
        end

        function x_m_dot = reference_model_dif_eq(self, x_m, r)

            % HW22 SECTION START ------------------------------------------
            % Enter the differential equation describing the dynamics of
            % reference model. The equation should be in state space form.
            % Treat r as the input to the system and x_m as the state
            % vector. x_m_dot is the time derivative of x_m which will be
            % used to solve the ODE using 4th order runge-kutta.

            % Differential equation describing how the reference model
            % behaves.
            x_m_dot = NaN;

            % HW22 SECTION END ----------------------------------------
        end

        function x_m = update_reference_model(self, r)
            % Integrate ODE using Runge-Kutta RK4 algorithm
            x_m_dot_1 = self.reference_model_dif_eq(self.x_m,                       r);
            x_m_dot_2 = self.reference_model_dif_eq(self.x_m + self.Ts/2*x_m_dot_1, r);
            x_m_dot_3 = self.reference_model_dif_eq(self.x_m + self.Ts/2*x_m_dot_2, r);
            x_m_dot_4 = self.reference_model_dif_eq(self.x_m + self.Ts  *x_m_dot_3, r);
            self.x_m = self.x_m + self.Ts/6 * (x_m_dot_1 + 2*x_m_dot_2 + 2*x_m_dot_3 + x_m_dot_4);
            x_m = self.x_m;
        end
    end
end