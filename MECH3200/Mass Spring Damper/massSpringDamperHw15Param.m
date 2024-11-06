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
% HW15 SECTION START ------------------------------------------
% Adjust these gains from the LQR cost function until the system is well
% tuned (quick response with little to no overshoot, little to no
% satturation, and no steady state error). Note that these are for the
% augmented system.
Param.Q_a = NaN;
Param.R_a = NaN;
Param.N_a = NaN;
% HW15 SECTION END ------------------------------------------

%% Observer Tuning Parameters
% HW15 SECTION START ------------------------------------------
% Copy over your gains from homework 12. You shouldn't need to change
% anything.
Param.t_r_o  = NaN;
Param.zeta_o = NaN;
% HW15 SECTION END --------------------------------------------
