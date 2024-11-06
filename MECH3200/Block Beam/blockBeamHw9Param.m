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
Param.parameteric_uncertianty  = 0.02;         % Percent of true value
Param.input_disturbance        = 0.0;          % N

%% Control Tuning Parameters
% HW9 SECTION START ------------------------------------------
% Adjust these rise times and damping ratios until the system is well tuned
% (quick response with little to no overshoot, little to no satturation,
% and no steady state error). t_r_i is the integrator rise time.
Param.t_r_theta      = NaN;
Param.zeta_theta     = NaN;
Param.t_r_z          = NaN;
Param.zeta_z         = NaN;
Param.t_r_integrator = NaN;
% HW9 SECTION END --------------------------------------------
Param.theta_min = deg2rad(-30); % deg
Param.theta_max = deg2rad( 30); % deg


%% Observer Tuning Parameters
Param.cutoff_frequency_theta = 1; % Hz
Param.cutoff_frequency_z     = 1; % Hz
