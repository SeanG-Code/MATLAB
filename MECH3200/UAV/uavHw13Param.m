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
Param.input_disturbance       = [0;0];% N - left and right motor

%% Control Tuning Parameters
% HW13 SECTION START ------------------------------------------
% Copy over your gains from homework 9. You shouldn't need to change
% anything.
Param.t_r_h            = NaN;
Param.zeta_h           = NaN;
Param.t_r_h_integrator = NaN;
Param.t_r_z            = NaN;
Param.zeta_z           = NaN;
Param.t_r_z_integrator = NaN;
Param.t_r_theta        = NaN;
Param.zeta_theta       = NaN;
% HW13 SECTION END --------------------------------------------
Param.theta_min = deg2rad(-45); % deg
Param.theta_max = deg2rad( 45); % deg

%% Bode Plot Settings

Param.reference_frequency_outer_lat = 1/40; % Hz
Param.noise_frequency_outer_lat     = 100;  % Hz
Param.reference_amplitude_outer_lat = 2;    % m
Param.noise_amplitude_outer_lat     = 0.01; % m

Param.reference_frequency_inner_lat = 10/4; % Hz
Param.noise_frequency_inner_lat     = 100;  % Hz
Param.reference_amplitude_inner_lat = 20;   % deg
Param.noise_amplitude_inner_lat     = 1;    % deg

Param.reference_frequency_lon = 1/40; % Hz
Param.noise_frequency_lon     = 100;  % Hz
Param.reference_amplitude_lon = 2;    % m
Param.noise_amplitude_lon     = 0.01; % m
