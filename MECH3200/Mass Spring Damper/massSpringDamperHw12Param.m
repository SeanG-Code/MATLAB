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
Param.parameteric_uncertianty = 0.0;   % Percent of true value

%% Control Tuning Parameters
% HW12 SECTION START ------------------------------------------
% Copy over your gains from homework 11. You shouldn't need to change
% anything.
Param.t_r  = NaN;
Param.zeta = NaN;
Param.t_r_integrator = NaN;
% HW12 SECTION END --------------------------------------------


%% Observer Tuning Parameters
% HW12 SECTION START ------------------------------------------
% Adjust these rise times and damping ratios until the OBSERVER is well
% tuned (traks the true values with little no error).
Param.t_r_o  = NaN;
Param.zeta_o = NaN;
% HW12 SECTION END --------------------------------------------

Param.cutoff_frequency = 3.18; % Hz