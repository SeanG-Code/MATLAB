uavParam

%% Intial State
Param.h_0         = 4;          % m
Param.z_0         = 0;          % m
Param.theta_0     = deg2rad(0); % rad
Param.h_dot_0     = 0;          % m/s
Param.z_dot_0     = 0;          % m/s
Param.theta_dot_0 = 0;          % rad/s

%% Simulation Settings
Param.speed         = 1;
Param.t_end         = 60;

%% Plot settings
Param.active_figure = 1;
Param.plot_state        = true;
Param.plot_input        = true;
Param.plot_reference    = true;
Param.plot_model        = false;
Param.plot_estimate     = true;
Param.animate           = true;

%% Uncertianty Settings
Param.h_measurment_std        = 0.01;        % m
Param.z_measurment_std        = 0.01;        % m
Param.theta_measurment_std    = deg2rad(1);  % Radians
Param.parameteric_uncertianty = 0;         % Percent of true value
Param.input_disturbance       = [0;0];% N - right and left motor

%% Control Tuning Parameters
% HW16 SECTION START ------------------------------------------
% Copy over your gains from homework 15. horizon is the number of timesteps
% to propigate backward the Riccatti equation. It represents how far into
% the future we're looking when performing the optimization. Play around
% with different values for the horizon.
Param.Q_a = NaN;
Param.R_a = NaN;
Param.N_a = NaN;
Param.horizon = NaN;
% HW16 SECTION END --------------------------------------------

%% Observer Tuning Parameters
% HW16 SECTION START ------------------------------------------
% Copy over your gains from homework 12. You shouldn't need to change
% anything.
Param.t_r_o_theta    = NaN;
Param.zeta_o_theta   = NaN;
Param.t_r_o_z        = NaN;
Param.zeta_o_z       = NaN;
Param.t_r_o_h        = NaN;
Param.zeta_o_h       = NaN;
% HW16 SECTION END --------------------------------------------