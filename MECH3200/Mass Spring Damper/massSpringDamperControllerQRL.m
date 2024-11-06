classdef massSpringDamperControllerQRL < handle
    properties

        % Inital States (for reset after episodes)
        z_0
        z_dot_0

        % State and input space
        z_observation_space     % Range of possible states quantized.
        z_dot_observation_space % Range of possible states quantized.
        action_space                % Range of possible actions quantized.
        
        % Saturation Limits
        F_min
        F_max

        % Control States
        total_reward               % reward for this timestep
        previous_z_index       % Previous state for updating Q table
        previous_z_dot_index   % Previous state for updating Q table
        previous_action_index      % Previous action for updating Q table

        % Time properties
        t_start % Start time, used to check if it is the first timestep in an episode
        t_end   % End time, used to check if the epsidoe is over yet
        Ts      % Time step

        % Gains
        Q        % Expected reward of a given state action pair
        alpha    % Learning rate (how quickly to update Q)
        gamma    % Discount factor (how much less valuable future reward is compared to current reward. A measure of urgency)
        epsilon  % How frequently to explore (i.e. take a sub optimal action)
        reward_for_success % How much reward to give if the task is successful
        cost_of_failure % How much reward to give if the task is failed
    end

    methods
        function [self, Param] = massSpringDamperControllerQRL(Param)

            % Determine if we're trying to use a Q table which is already
            % saved to a file. This is done by looking for a existing file 
            % with the same name as the given file save name.
            use_pretrained_table = isfile(Param.file_name+".mat");

            % If we're using a pretrained Q table then load that table and
            % overwirte the parameters (the parameters are overwirtten
            % because the dimensions of the Q table must match the
            % observation spaces. This means that the hyperparameters (e.g. 
            % learning rate, discount factor, epsilon) are overwritten as
            % well.)
            if use_pretrained_table
                Param = self.load_Q(Param.file_name);
            end

            % Inital States
            self.z_0 = Param.z_0;
            self.z_dot_0 = Param.z_dot_0;

            % State and input space
            self.z_observation_space = Param.z_observation_space;
            self.z_dot_observation_space = Param.z_dot_observation_space;
            self.action_space = Param.action_space;

            % Saturation Limits
            self.F_min = Param.F_min;
            self.F_max = Param.F_max;

            % Time properties
            self.t_start = Param.t_start;
            self.t_end = Param.t_end;
            self.Ts = Param.Ts;
            
            % Gains 
            % Only load Q if we're not loading a previously trained file
            if ~use_pretrained_table
                self.Q = rand(length(self.z_observation_space), ...
                              length(self.z_dot_observation_space), ...
                              length(self.action_space));
            end

            self.alpha = Param.alpha;
            self.gamma = Param.gamma;
            self.epsilon = Param.epsilon;

            self.reward_for_success = Param.reward_for_success;
            self.cost_of_failure = Param.cost_of_failure;

            % Display size of Q for metadata evaluation (i.e. are there too
            % many elements to successfully learn?)
            size_of_Q = size(self.Q);
            fprintf("Size of Q: [%i,%i,%i], Total Elements: %i \n",size_of_Q(1),size_of_Q(2),size_of_Q(3),numel(self.Q));

            % Reset episode
            self.episode_reset();
        end

        function [F, episode_reset] = update(self,x,r,t)
            % Unpack data
            z     = x(1);
            z_dot = x(2);

            % Check to see if it's time to reset
            [episode_reset, state_out_of_range] = self.reset_check(z, z_dot, r, t);

            % Quantize the state.
            z_index = self.get_descrete_index(z, self.z_observation_space);
            z_dot_index = self.get_descrete_index(z_dot, self.z_dot_observation_space);
            z_r_index = self.get_descrete_index(r, self.z_observation_space);

            % Calculate reward using previous timestep data.
            if t ~= self.t_start
                R = self.reward(z_index, z_dot_index, z_r_index, state_out_of_range);
            else
                R = 0; % If this is the first timestep then give zero reward.
            end
            % Add new reward to total
            self.total_reward = self.total_reward + R;

            % Update the Q table
            if t ~= self.t_start
                self.learn(z_index, z_dot_index, R);
            end
            
            % Choose next action
            action_index = self.epsilon_greedy(z_index, z_dot_index);
            F = self.action_space(action_index);

            % Save state and action pair
            self.previous_z_index = z_index;
            self.previous_z_dot_index = z_dot_index;
            self.previous_action_index = action_index;
        end

        function learn(self, z_index, z_dot_index, reward_recived)

            % HW23 SECTION START ------------------------------------------
            % Impliment the Bellman equation to update the Q table. The
            % index inputs represent the index of the quantized states at
            % the current timestep. You'll also need to use the properties
            % which store these values from the previous timestep.
            % reward_recived is the reward which was recived when we
            % arrived at the current state. Hyperparameters and the Q table
            % are stored as class properties.

            % Bellman Equation
            self.Q(self.previous_z_index, self.previous_z_dot_index, self.previous_action_index) ...
                = NaN;

            % HW23 SECTION END --------------------------------------------
        end

        function [episode_reset, state_out_of_range] = reset_check(self, z, z_dot, ~, t)
            % Check if the state is out of the observation space
            z_out_of_range = ((z < self.z_observation_space(1)) || (self.z_observation_space(end) < z));
            z_dot_out_of_range = ((z_dot < self.z_dot_observation_space(1)) || (self.z_dot_observation_space(end) < z_dot));
            
            % Determine if EITHER state is out of range.
            state_out_of_range = z_out_of_range || z_dot_out_of_range;
            
            % Check if time has expired
            episode_length_exceeded = t >= self.t_end;   

            % End the episode if EITHER the state is out of range or time
            % has expired.
            episode_reset = state_out_of_range || episode_length_exceeded;
        end

        function R = reward(self, z_index, ~, z_r_index, state_out_of_range)

            % HW23 SECTION START -----------------------------------------
            % Try a few different reward functions to try to get the best
            % performance and fastest learning. 

            R = NaN;

            % HW23 SECTION END --------------------------------------------
        end

        function episode_reset(self)
            % Reset reward to 0
            self.total_reward = 0;
            
            % Intilize previous values (steady state at start point)
            self.previous_z_index     = self.get_descrete_index(self.z_0, self.z_observation_space);
            self.previous_z_dot_index = self.get_descrete_index(self.z_dot_0, self.z_dot_observation_space);
            self.previous_action_index    = self.get_descrete_index(0, self.action_space);
        end

        function action_index = epsilon_greedy(self, z_index, z_dot_index)

            % HW23 SECTION START -----------------------------------------
            % Impliment the epsilon-greedy algorithm to determine the next
            % action index. The index inputs to this method are the current
            % index in the observation space. action_index is the index in
            % the action space of the choosen action. The exploration rate
            % epsilon and the Q table are stored as a class property. 

            action_index = NaN;

            % HW23 SECTION END --------------------------------------------

        end

        function index = get_descrete_index(~,value,space)

            % Distance from value to each quantized value.
            distance_from_each_point = abs(space - value);

            % Find the smallest distance
            [~,index] = min(distance_from_each_point);
        end

        function save_Q(self,file_name,Param)
            % Create a variable for saving.
            Q = self.Q; %#ok<PROPLC>

            % Check to see if we're overwriting another file.
            if isfile(file_name+".mat")
                % If so ask for permision
                overwrite = input("This file name is already a file. " + ...
                    "Are you sure you want to overwrite it? (y - yes overwite | enter - cancel or use different name) ",'s');
                if strcmpi(overwrite,"y")
                    % Save the table and parameters
                    save(file_name+".mat","Q","Param",'-v7.3');
                else
                    % Check for saving under a different name.
                    file_name = input("Would you like to save this Q table under a different name? (type name to use different name | enter - cancel) ",'s');
                    
                    if ~isempty(file_name)
                        % Save the table and parameters
                        save(file_name+".mat","Q","Param",'-v7.3');
                    end
                end
            else
                % Save the table and parameters
                save(file_name+".mat","Q","Param",'-v7.3');
            end
        end

        function Param = load_Q(self,file_name)
            % Load the table and parameters
            load(file_name+".mat","Q","Param");

            % Set the Q table.
            self.Q = Q; %#ok<PROPLC>
        end

        function deterministic(self)

            % HW23 SECTION START -----------------------------------------
            % Set the learning rate and the exploration rate to the values
            % nessisary to stop learning and exploration. Hyperparamters
            % are stored as class properties.

            % Set learning rate and explortation rate to 0 so no learning
            % or exploration occurs.
            self.alpha = NaN;
            self.epsilon = NaN;

            % HW23 SECTION END -------------------------------------------

        end
    end
end