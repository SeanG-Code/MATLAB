classdef uavControllerSISOFSFI < handle
    properties

        % System Prameters
        d

        % Equilibrium
        F_e
        
        % Saturation Limits
        f_min
        f_max

        % Control States
        e_z_integral
        e_h_integral

        % Values form previous time step
        previous_e_z
        previous_e_h

        % Time Step
        Ts

        % Gains
        K_x_lat
        K_x_lon
        k_i_lat
        k_i_lon
        k_r_lat
        k_r_lon
    end
    methods
        function self = uavControllerSISOFSFI(Param)

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
            self.calculate_gains(Param.t_r_h, Param.zeta_h, Param.t_r_h_integrator, ...
                Param.t_r_z, Param.zeta_z, Param.t_r_z_integrator, ...
                Param.t_r_theta, Param.zeta_theta, ...
                Param.A_lat, Param.B_lat, Param.C_r_lat, ...
                Param.A_lon, Param.B_lon, Param.C_r_lon);

            % Intilize Values
            % Control States
            self.e_z_integral   = 0;
            self.e_h_integral   = 0;
    
            % Values form previous time step
            self.previous_e_z   = 0;
            self.previous_e_h   = 0;
        end

        function inputs_sat = update(self, states, reference)

            % HW11 SECTION START ------------------------------------------
            % Impliment SISO Full State Feedback with an integrator. 
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

            self.e_z_integral = NaN;
            self.e_h_integral = NaN;
            self.previous_e_z = NaN;
            self.previous_e_h = NaN;
            inputs_sat = NaN;
            
            % HW11 SECTION END -----------------------------------------

        end

        function calculate_gains(self, t_r_h, zeta_h, t_r_h_integrator, ...
                t_r_z, zeta_z, t_r_z_integrator, t_r_theta, zeta_theta, ...
                A_lat, B_lat, C_r_lat, A_lon, B_lon, C_r_lon)

            % HW11 SECTION START ------------------------------------------
            % Calculate the control gains K_x_lat, k_i_lat, k_r_lat,
            % K_x_lon, k_i_lon, and k_r_lon. Save them in the appropriate
            % class properties. lat refers to the lateral system (theta and
            % z) lon refers to the longitudinal system (h). Save them in
            % the appropriate class properties. To exactly match my
            % solution note that I used the full Equation 8.5 from the
            % textbook. Not the approximation. Also check for
            % controllability of the augmented system. Use
            % log(1/9)/t_r_integrator for the real pole.

            assert(NaN, "Error: Lateral System Not Controllable.")
            assert(NaN, "Error: Longitudinal System Not Controllable.")
            self.K_x_lat = NaN;
            self.K_x_lon = NaN;
            self.k_i_lat = NaN;
            self.k_i_lon = NaN;
            self.k_r_lat = NaN;
            self.k_r_lon = NaN;

            % HW11 SECTION END -----------------------------------------
        end
    end
end