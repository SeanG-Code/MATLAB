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
Param.parameteric_uncertianty = 0.0;         % Percent of true value
Param.input_disturbance       = [0;0];       % N - left and right motor

%% Control Tuning Parameters
% HW8 SECTION START ------------------------------------------
% Adjust these rise times and damping ratios until the system is well
% tuned (quick response with little to no overshoot and little to no
% satturation). Some steady state error may occur depending on the system.
% If there is steady state error, can you explain it intutatively? In the
% next section we'll learn to predict it mathmatically.
Param.t_r_h      = 1.75;
Param.zeta_h     = 0.65;
Param.t_r_z      = 1.8;
Param.zeta_z     = 0.707;
Param.t_r_theta  = 0.15;
Param.zeta_theta = 0.707;
% HW8 SECTION END --------------------------------------------
Param.theta_min = deg2rad(-45); % deg
Param.theta_max = deg2rad( 45); % deg
