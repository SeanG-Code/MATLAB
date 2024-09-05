cartPoleHw2Param

% Instantiate objects
dynamics  = cartPoleDynamics(Param);
animation = cartPoleAnimation(Param);
plotter   = cartPoleDataPlotter(Param);

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
        % Forces and Moments for Simulation
        F = 0;
    
        % Update dynamics
        dynamics.update(F);

        % Time step
        t = t + Param.Ts;
    end
    
    % Combine the states into a single vector
    state         = dynamics.states;
    estimate      = NaN(size(state));
    reference     = NaN(size(state));
    model         = NaN(size(state));
    input         = F;

    % Update animation and plots
    animation.update(state);
    plotter.update(t, state, estimate, reference, model, input)

    % Update plot time
    t_next_plot = t + Param.t_plot;
end
simulation_length = toc(timer);
fprintf("Simulation took: %f seconds.\n",simulation_length);