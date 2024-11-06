classdef uavControllerLQR < handle
    properties

        % System Parameters
        d

        % Equilibrium
        F_e

        % Saturation Limits
        f_min
        f_max

        % Control States
        e_integral

        % Values form previous time step
        previous_e

        % Time Step
        Ts

        % Gains
        K_x
        K_i
        K_r
    end
    methods
        function self = uavControllerLQR(Param)

            % System Parameters
            self.d = Param.d;

            % Equilibrium
            self.F_e = Param.F_e;
            
            % Saturation Limits
            self.f_min = Param.f_min;
            self.f_max = Param.f_max;

            % Time Step
            self.Ts = Param.Ts;

            % Control gains
            self.calculate_gains(Param.Q_a, Param.R_a, Param.N_a, Param.A, Param.B, Param.C_r, Param.D_r);

            % Intilize Values
            % Control States
            self.e_integral   = [0;0];
    
            % Values form previous time step
            self.previous_e   = [0;0];
        end

        function inputs_sat = update(self, states, reference)

            % HW15 SECTION START ------------------------------------------
            % Impliment MIMO LQR with an integrator. 
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
            % equilibrium input F_e.

            self.e_integral = NaN;
            self.previous_e = NaN;

            inputs_sat = NaN;

            % HW15 SECTION END -----------------------------------------

        end

        function calculate_gains(self, Q_a, R_a, N_a, A, B, C_r, D_r)

            % HW15 SECTION START ---------------------------------------
            % Calculate the control gains K_x, k_i, and k_r. Save them in
            % the appropriate class properties. Also check for
            % controllability of the augmented system. Use Non-Zero Set
            % Point (NZSP to find k_r).

            assert(NaN, "Error: System Not Controllable.");

            self.K_x = NaN;
            self.K_i = NaN;
            self.K_r = NaN;
            % HW15 SECTION END -----------------------------------------
        end
    end
end