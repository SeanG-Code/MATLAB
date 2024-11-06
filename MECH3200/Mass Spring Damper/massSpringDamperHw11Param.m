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
Param.z_measurment_std        = 0.01;  % m
Param.parameteric_uncertianty = 0.2;   % Percent of true value

%% Control Tuning Parameters
% HW11 SECTION START ------------------------------------------
% Adjust these rise times and damping ratios until the system is well tuned
% (quick response with little to no overshoot, little to no satturation,
% and no steady state error). t_r_integrator is the integrator rise time
% for the outer loop.
Param.t_r  = NaN;
Param.zeta = NaN;
Param.t_r_integrator = NaN;
% HW11 SECTION END --------------------------------------------