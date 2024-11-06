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
% HW16 SECTION START ------------------------------------------
% Copy over your gains from homework 15. horizon is the number of timesteps
% to propigate backward the Riccatti equation. It represents how far into
% the future we're looking when performing the optimization. Play around
% with different values for the horizon.
Param.Q_a = NaN;
Param.R_a = NaN;
Param.horizon = NaN;
% HW16 SECTION END --------------------------------------------


%% Observer Tuning Parameters
% HW16 SECTION START ------------------------------------------
% Copy over your gains from homework 12. You shouldn't need to change
% anything.
Param.t_r_o  = NaN;
Param.zeta_o = NaN;
% HW16 SECTION END --------------------------------------------
