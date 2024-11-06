massSpringDamperHw23Param

% Reference signals
period = 20;
z_r_signal = massSpringDamperSignalGenerator(1, 1/period,  Param.z_e);

% Instantiate objects
[controller, Param]  = massSpringDamperControllerQRL(Param);
dynamics    = massSpringDamperDynamics(Param);

% Activate the desired figure
list_of_figures =  findobj('type','figure');
number_of_figures = length(list_of_figures);
if Param.active_figure <= number_of_figures
    figure(Param.active_figure);
end

% main simulation loop
t = Param.t_start;  % time starts at t_start
episode_counter = 1;
reward_history = NaN(1,Param.training_episodes);
length_history = NaN(1,Param.training_episodes);
tic
while episode_counter <= Param.training_episodes
    z_r = z_r_signal.step(t);

    % Inputs
    [F, episode_reset] = controller.update(dynamics.states, z_r, t);

    % Dynamics
    dynamics.update(F);  % Propagate the dynamics

    t = t + Param.Ts;

    % If reseting episode
    if episode_reset
        
        % Save meta data for plotting
        reward_history(episode_counter) = controller.total_reward;
        length_history(episode_counter) = t;

        % Every so often display progress
        if ~mod(episode_counter,Param.print_frequency)
            fprintf("Episode: %i, Mean Reward: %f, Mean Episode Length: %f seconds \n", episode_counter,...
                mean(reward_history((episode_counter-Param.print_frequency+1):episode_counter)),...
                mean(length_history((episode_counter-Param.print_frequency+1):episode_counter)))
        end
        
        % Increment counter
        episode_counter = episode_counter + 1;

        % Reset controller
        controller.episode_reset();

        % Return to start location
        dynamics.states = [Param.z_0;Param.z_dot_0];

        % Reset time
        t = Param.t_start;
    end
end
fprintf("Training took %f minutes \n",toc/60);

% Filter the reward history to smooth out plots
filtered_reward_history = movmean(reward_history,Param.print_frequency);
filtered_length_history = movmean(length_history,Param.print_frequency);

% Plot reward and epsidoe lenght over training
figure(1)
plot(filtered_reward_history,'LineWidth',2)
xlabel("episode")
ylabel("Mean Reward")

figure(2)
plot(filtered_length_history,'LineWidth',2)
xlabel("Episode")
ylabel("Mean Episode Length")

% Save Q table
controller.save_Q(Param.file_name, Param);