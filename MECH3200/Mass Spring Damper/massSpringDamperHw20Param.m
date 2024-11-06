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
Param.plot_model        = true;
Param.plot_estimate     = true;
Param.animate           = true;

%% Uncertianty Settings
Param.z_measurment_std        = 0.01;  % m
Param.parameteric_uncertianty = 0.0;   % Percent of true value

%% Control Tuning Parameters
% HW20 SECTION START ------------------------------------------
% Adjust these gains until the system is well tuned (quick response with
% little to no overshoot, little to no satturation, and no steady state
% error). the _model parameteres are for the reference model's convergence
% to the reference signal. The _error parameters are a measure of how
% quickly the system and the reference model converge to each other.
Param.t_r_model      = NaN;
Param.zeta_model     = NaN;
Param.t_r_error      = NaN;
Param.zeta_error     = NaN;
% HW20 SECTION END ------------------------------------------

%% Observer Tuning Parameters
% HW20 SECTION START ------------------------------------------
% Copy over your gains from homework 17. You shouldn't need to change
% anything.
Param.P_0 = NaN;
Param.G   = NaN;
Param.Q   = NaN;
Param.R   = NaN;
% HW20 SECTION END --------------------------------------------
