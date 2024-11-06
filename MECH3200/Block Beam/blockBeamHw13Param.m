blockBeamParam

%% Intial State
Param.z_0         = Param.z_e;  % m
Param.theta_0     = deg2rad(0); % rad
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
Param.z_measurment_std         = 0.001;        % m
Param.theta_measurment_std     = deg2rad(0.1); % rad
Param.parameteric_uncertianty  = 0.0;          % Percent of true value
Param.input_disturbance        = 0.0;          % N

%% Control Tuning Parameters
% HW13 SECTION START ------------------------------------------
% Copy over your gains from homework 9. You shouldn't need to change
% anything.
Param.t_r_theta      = NaN;
Param.zeta_theta     = NaN;
Param.t_r_z          = NaN;
Param.zeta_z         = NaN;
Param.t_r_integrator = NaN;
% HW13 SECTION END --------------------------------------------
Param.theta_min = deg2rad(-30); % deg
Param.theta_max = deg2rad( 30); % deg

%% Bode Plot Settings

Param.reference_frequency_outer = 1/30;         % Hz
Param.noise_frequency_outer     = 100;          % Hz
Param.reference_amplitude_outer = Param.ell/4;  % m
Param.noise_amplitude_outer     = 0.001;        % m

Param.reference_frequency_inner = 1/3; % Hz
Param.noise_frequency_inner     = 100; % Hz
Param.reference_amplitude_inner = 2;   % deg
Param.noise_amplitude_inner     = 0.1; % deg
