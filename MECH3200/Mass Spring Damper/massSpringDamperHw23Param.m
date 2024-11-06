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

%% Controller Settings

% HW23 SECTION START ------------------------------------------
% Adjust these RL Hyperparameters until the system successfully learns to
% balance move the arm from 0 degrees to 45 degrees.

Param.alpha = NaN; % Learning rate
Param.gamma = NaN; % Discount factor
Param.epsilon = NaN; % Exploration likelyhood

Param.reward_for_success = NaN; % Reward for successfully reaching the reference
Param.cost_of_failure = NaN; % Penalty for leaving the observation space (should be negative)

% Observation and action spaces
Param.z_observation_space     = NaN;
Param.z_dot_observation_space = NaN;
Param.action_space            = NaN;

Param.training_episodes = 1000; % Number of episodes to train for
Param.print_frequency = 100; % How many episodes between printing the progress.

% Name of the file which the Q table will be saved to. If this file already
% exists then it will be loaded instead of initillizing Q as random
% numbers.
Param.file_name = "firstAttempt"; % "massSpringDamperTrainedQTable";

% HW23 SECTION END --------------------------------------------