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
Param.plot_model        = true;
Param.plot_estimate     = false;
Param.animate           = true;

%% Uncertianty Settings
Param.z_measurment_std         = 0.001;        % m
Param.theta_measurment_std     = deg2rad(0.1); % rad
Param.parameteric_uncertianty  = 0.02;         % Percent of true value
Param.input_disturbance        = 0.0;          % N

%% Control Tuning Parameters
% HW22 SECTION START ------------------------------------------
% Adjust these gains until the system is well tuned (quick response with
% little to no overshoot, little to no satturation, and no steady state
% error). the _model parameteres are for the reference model's convergence
% to the reference signal. The Gamma parameters are the adaptation rate
% gains. sign_of_Lambda should be positive 1 if Lambda is positive definate
% and -1 otherwise. Q_lyap is a positive definate matrix used in the
% lyapunov equation to solve for P which is used as the positive definate
% weight matrix in the lyapunov equation. P is also used in the adaption
% laws. 
Param.t_r_z            = NaN;
Param.zeta_z           = NaN;
Param.t_r_theta        = NaN;
Param.zeta_theta       = NaN;
Param.Gamma_x          = NaN;   
Param.Gamma_r          = NaN;
Param.sign_of_Lambda   = NaN;
Param.Q_lyap           = NaN;
% HW22 SECTION END --------------------------------------------