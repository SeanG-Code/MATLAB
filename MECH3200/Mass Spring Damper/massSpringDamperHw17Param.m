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
% HW17 SECTION START ------------------------------------------
% Copy over your gains from homework 15. You shouldn't need to change
% anything.
Param.Q_a = NaN;
Param.R_a = NaN;
Param.N_a = NaN;
Param.horizon = NaN;
% HW17 SECTION END --------------------------------------------


%% Observer Tuning Parameters
% HW17 SECTION START ------------------------------------------
% Adjust the following EKF covariances until the EKF is well tuned (quickly
% converges to the true value of each state without overshooting too much.
% It should also filter out noise.) Yes, the natation here is a bit
% confusing when compared with the LQR cost function gains. However, that
% just emphasizes the similarities between the two methods.
Param.P_0 = NaN;
Param.G   = NaN;
Param.Q   = NaN;
Param.R   = NaN;
% HW17 SECTION END --------------------------------------------
