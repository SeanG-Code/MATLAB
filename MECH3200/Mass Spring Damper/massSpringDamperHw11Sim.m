massSpringDamperHw11Param

% Reference signals
period = 20;
z_ref_signal = massSpringDamperSignalGenerator(1, 1/period,  Param.z_e);

% Instantiate objects
dynamics    = massSpringDamperDynamics(Param);
controller  = massSpringDamperControllerFSFI(Param);
animation   = massSpringDamperAnimation(Param);
plotter     = massSpringDamperDataPlotter(Param);

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
        z_ref = z_ref_signal.square(t);

        % Sensors and Observers
        states = dynamics.states;
    
        % Inputs
        F = controller.update(states, z_ref);
    
        % Dynamics
        dynamics.update(F);

        % Time step
        t = t + Param.Ts;
    end
    
    % Combine the states into a single vector
    estimate      = NaN(2,1);
    references    = [z_ref;NaN];
    model         = NaN(size(states));
    input         = F;

    % Update animation and plots
    animation.update(states);
    plotter.update(t, states, estimate, references, model, F)

    % Update time
    t_next_plot = t + Param.t_plot;
end
simulation_length = toc(timer);
fprintf("Simulation took: %f seconds.\n",simulation_length);
