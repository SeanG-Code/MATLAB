clear
close all
clc

% System Paramters
Param.J_s = 5.00; % kg m^2
Param.J_p = 1.00; % kg m^2
Param.k   = 0.10; % Nm
Param.b   = 0.05; % Nms

% Intial State
Param.z_0     = deg2rad(10);  % rad
Param.theta_0       = deg2rad(-10); % rad
Param.z_dot_0 = 0;            % rad/s
Param.theta_dot_0   = 0;            % rad/s

% Time settings
Param.Ts = 0.01;
Param.t_end = 30;

% Initilize Dynamics
dynamics = uavQuickDynamics(Param);

% Initilize History Variables
time_history = (0:Param.Ts:Param.t_end);
state_history = NaN(4, size(time_history,2));

% Simulation
for i = 1:length(time_history)
    % Input
    tau = 0;

    % Step Dynamics forward in time
    state_history(:,i) = dynamics.update(tau);
end

% Plot Response
figure(1)

subplot(4,1,1)
plot(time_history, rad2deg(state_history(1,:)));
ylabel("z (deg)")

subplot(4,1,2)
plot(time_history, rad2deg(state_history(2,:)));
ylabel("theta (deg)")

subplot(4,1,3)
plot(time_history, rad2deg(state_history(3,:)));
ylabel("z dot (deg/s)")

subplot(4,1,4)
plot(time_history, rad2deg(state_history(4,:)));
ylabel("theta dot (deg/s)")

xlabel("t - time (s)")

