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
% HW10 SECTION START ------------------------------------------
% Adjust these rise times and damping ratios until the system is well
% tuned (quick response with little to no overshoot and little to no
% satturation). Some steady state error may occur depending on the system.
% If there is steady state error, can you explain it intutatively?
Param.t_r_theta      = NaN;
Param.zeta_theta     = NaN;
Param.t_r_z          = NaN;
Param.zeta_z         = NaN;
% HW10 SECTION END --------------------------------------------
