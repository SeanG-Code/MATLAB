massSpringDamperHw1Param

% Reference signals
period = Param.t_end/6;
z_ref = massSpringDamperSignalGenerator(0.5, 1/period, Param.z_0);

% Instantiate objects
animation = massSpringDamperAnimation(Param);
plotter = massSpringDamperDataPlotter(Param);

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

    % Set all states to either a sinusoid or the intial conditions.
    z       = z_ref.sin(t);
    z_dot   = Param.z_dot_0;
    
    % Combine the states into a single vector
    state         = [z; z_dot];
    estimate      = NaN(size(state));
    reference     = NaN(size(state));
    model         = NaN(size(state));
    input         = zeros(1,1);

    % Update animation and plots
    animation.update(state);
    plotter.update(t, state, estimate, reference, model, input)

    % Update time
    t = t + Param.t_plot;
end
simulation_length = toc(timer);
fprintf("Simulation took: %f seconds.\n",simulation_length);