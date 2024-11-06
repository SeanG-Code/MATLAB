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

%% Controller Settings

% HW23 SECTION START ------------------------------------------
% Adjust these RL Hyperparameters until the system successfully learns to
% balance the pole vertically. For the purpose of this assignment we won't
% worry about what the z position is (other than reseting if it leaves the
% z observation space). For the rise times and damping ratios, set them to
% match your Homework 20 values.

Param.alpha = NaN; % Learning rate
Param.gamma = NaN; % Discount factor
Param.epsilon = NaN; % Exploration likelyhood

Param.reward_for_success = NaN; % Reward for successfully reaching the reference
Param.cost_of_failure    = NaN; % Penalty for leaving the observation space (should be negative)

% Observation and action spaces
Param.z_observation_space         = NaN;
Param.z_dot_observation_space     = NaN;
Param.action_space                = NaN;


Param.training_episodes = 1000; % Number of episodes to train for
Param.print_frequency = 100; % How many episodes between printing the progress.

% Name of the file which the Q table will be saved to. If this file already
% exists then it will be loaded instead of initillizing Q as random
% numbers.
Param.file_name = "firstAttempt"; % "blockBeamTrainedQTable";

% Inner loop rise times and damping ratios. Copy these over from your the
% assignment.
Param.t_r_model_theta  = NaN;
Param.zeta_model_theta = NaN;
Param.t_r_error_theta  = NaN;
Param.zeta_error_theta = NaN;


% HW23 SECTION END --------------------------------------------
Param.theta_min = deg2rad(-30); % deg
Param.theta_max = deg2rad( 30); % deg