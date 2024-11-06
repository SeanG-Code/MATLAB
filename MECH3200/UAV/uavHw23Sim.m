uavHw23Param

% Instantiate objects
[controller, ~]  = uavControllerQRL(Param);
dynamics    = uavDynamics(Param);
animation   = uavAnimation(Param);
plotter     = uavDataPlotter(Param);

% Stop learning and random exploration
controller.deterministic();

% Activate the desired figure
list_of_figures =  findobj('type','figure');
number_of_figures = length(list_of_figures);
if Param.active_figure <= number_of_figures
    figure(Param.active_figure);
end

% Main simulation loop
t = Param.t_start;
timer = tic;
t_next_plot = 0;
while t < Param.t_end

    drawn_recently = false;
    while toc(timer) < t/Param.speed
        % Do nothing while we wait for the time to plot
        if ~drawn_recently
            drawnow
            drawn_recently = true;
        end
    end

    while t <= t_next_plot
        % Reference
        h_r = 6;
        z_r = 0;
        reference = [h_r;z_r];
    
        % Inputs
        [input, ~] = controller.update(dynamics.states, reference, t);
    
        % Dynamics
        dynamics.update(input);

        t = t + Param.Ts;
    end

    % Combine the states into a single vector
    states     = dynamics.states;
    estimate   = NaN(size(states));
    references = [reference; NaN(4,1)];
    model      = NaN(size(states));

    % Update animation and plots
    animation.update(states);
    plotter.update(t, states, estimate, references, model, input)

    % Update time
    t_next_plot = t + Param.t_plot;
end
simulation_length = toc(timer);
fprintf("Simulation took: %f seconds.\n",simulation_length);

