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
Param.t_end         = 30;

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