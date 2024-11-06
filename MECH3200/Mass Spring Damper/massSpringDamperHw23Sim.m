massSpringDamperHw23Param

% Reference signals
period = 20;
z_r_signal = massSpringDamperSignalGenerator(1, 1/period,  Param.z_e);

% Instantiate objects
[controller, ~]  = massSpringDamperControllerQRL(Param);
dynamics    = massSpringDamperDynamics(Param);
animation   = massSpringDamperAnimation(Param);
plotter     = massSpringDamperDataPlotter(Param);

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
F = Param.F_e;
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
        z_r = z_r_signal.step(t);
    
        % Inputs
        [F, ~] = controller.update(dynamics.states, z_r, t);
    
        % Dynamics
        dynamics.update(F);

        t = t + Param.Ts;
    end

    % Combine the states into a single vector
    states     = dynamics.states;
    estimate   = NaN(2,1);
    references = [z_r; NaN];
    model      = NaN(2,1);
    input      = F;

    % Update animation and plots
    animation.update(states);
    plotter.update(t, states, estimate, references, model, input)

    % Update time
    t_next_plot = t + Param.t_plot;
end
simulation_length = toc(timer);
fprintf("Simulation took: %f seconds.\n",simulation_length);

