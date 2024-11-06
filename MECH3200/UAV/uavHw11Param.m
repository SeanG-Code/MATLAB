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
Param.parameteric_uncertianty = 0.;         % Percent of true value
Param.input_disturbance       = [0;0];% N - left and right motor

%% Control Tuning Parameters
% HW11 SECTION START ------------------------------------------
% Adjust these rise times and damping ratios until the system is well tuned
% (quick response with little to no overshoot, little to no satturation,
% and no steady state error). t_r_integrator is the integrator rise time
% for the outer loop.
Param.t_r_h            = NaN;
Param.zeta_h           = NaN;
Param.t_r_h_integrator = NaN;
Param.t_r_z            = NaN;
Param.zeta_z           = NaN;
Param.t_r_z_integrator = NaN;
Param.t_r_theta        = NaN;
Param.zeta_theta       = NaN;
% HW11 SECTION END --------------------------------------------
