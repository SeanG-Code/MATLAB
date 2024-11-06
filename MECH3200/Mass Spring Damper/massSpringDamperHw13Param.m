massSpringDamperParam

%% Intial State
Param.z_0     = 0; % m
Param.z_dot_0 = 0; % m/s

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
Param.z_measurment_std = deg2rad(0);  % Radians
Param.parameteric_uncertianty = 0.0;      % Percent of true value

%% Control Tuning Parameters
% HW13 SECTION START ------------------------------------------
% Copy over your gains from homework 9. You shouldn't need to change
% anything.
Param.t_r  = NaN;
Param.zeta = NaN;
Param.t_r_integrator = NaN;
% HW13 SECTION END --------------------------------------------

%% Bode Plot Settings

Param.reference_frequency = 1/20; % Hz
Param.noise_frequency     = 100;  % Hz
Param.reference_amplitude = 1;    % 0
Param.noise_amplitude     = 0.01; % m
