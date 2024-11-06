uavHw11Param

% Reference signals
period = 40;
h_ref_signal = uavSignalGenerator(2, 1/period,  Param.h_0);
z_ref_signal = uavSignalGenerator(2, 1/period,  Param.z_0);

% Instantiate objects
dynamics    = uavDynamics(Param);
% controller  = uavControllerSISOFSFI(Param);
controller  = uavControllerMIMOFSFI(Param);
animation   = uavAnimation(Param);
plotter     = uavDataPlotter(Param);

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
        h_r = h_ref_signal.square(t + period/4);
        z_r = z_ref_signal.square(t);
        reference = [h_r;z_r];

        % Sensors and Observers
        states = dynamics.states;
    
        % Inputs
        input = controller.update(states, reference);
    
        % Dynamics
        dynamics.update(input);

        % Time step
        t = t + Param.Ts;
    end
    
    % Combine the states into a single vector
    estimate      = NaN(size(states));
    references    = [h_r; z_r; NaN(4,1)];
    model         = NaN(size(states));

    % Update animation and plots
    animation.update(states);
    plotter.update(t, states, estimate, references, model, input)

    % Update time
    t_next_plot = t + Param.t_plot;
end
simulation_length = toc(timer);
fprintf("Simulation took: %f seconds.\n",simulation_length);

