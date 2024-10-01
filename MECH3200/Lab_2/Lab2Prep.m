clc, clear, close all;
% Initial Values
m = .531; % kg
l_cg = 0.073; % m
l_t = 0.343; % m
g = 9.81; % m/s^2

% Load data
data = readmatrix('putty2.csv');

% Separate columns
time = data(:, 1);   % First column (e.g., time)
theta = data(:, 2);  % Second column (angular position or inertia)

% Adjust theta so that hanging vertically down is at theta = - 90°
theta = theta - theta(end) - (pi/2);  % Shift all values by 90 degrees

% Preallocate arrays for the first and second derivatives
theta_d = zeros(length(theta)-2,1);
theta_dd = zeros(length(theta)-2,1);

% Loop through the data to calculate finite differences
for n = 2:length(theta)-1
    % Approximation of dot_theta (first derivative)
    theta_d(n) = (theta(n+1) - theta(n-1)) / (time(n+1) - time(n-1));
    
    % Approximation of ddot_theta (second derivative)
    theta_dd(n) = 4*(theta(n+1) - 2*theta(n) + theta(n-1)) / (time(n+1) - time(n-1))^2;
end

theta = theta(3:end-3);
time = time(3:end-3);
theta_d = theta_d(3:end-3);
theta_dd = theta_dd(3:end-3);

y_1 = theta_dd;
H_1 = [-theta_d,-m*g*l_cg*cos(theta(1:end-1))];

p_1 = abs((H_1' * H_1)^-1 * H_1' * y_1);
%p_1 = H_1 \ y_1;

p1_1 = p_1(1);
p2_1 = p_1(2);

J = 1 / p2_1;
b = abs(p1_1 / p2_1);

disp(['J = ', num2str(J)]);
disp(['b = ', num2str(b)]);

% ODE function
ode_function = @(~,x) [x(2); (-b*x(2) - m*g*l_cg*cos(x(1)))/J];

% ODE Initial Conditions
initial_conditions = [theta(1), theta_d(1)];

% Solve ODE
[t_ode, x_history] = ode45(ode_function, time, initial_conditions);%[0;0]);

% Plot the adjusted data
figure;
plot(time, theta, 'b', 'LineWidth', .5); % original data in blue
hold on;

% Overlay the ODE solution
plot(t_ode, x_history(:,1), 'r--', 'LineWidth', .5);

% Add labels and title
axis tight;
xlabel('Time (s)');
ylabel('Angular Position (rad)');
title('Angular Position vs. Time (Data and ODE Solution)');
legend('Original Data', 'ODE Solution');
grid on;
hold off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 2
% Example Data
l_cg = 0.05; % m
m = 0.5; % kg

u = [.31; .33; .34; .35];
theta_e = [-31.9;-23.5;-12.3;-3.3];

% Calculate Fe
Fe = m*g*(l_cg/l_t)*cos(deg2rad(theta_e));
Fe_0 = m*g*(l_cg/l_t)*cos(0);

% Create Vectors for y and H
y_2 = Fe;
H_2 = [2*u,ones(size(u))];

% Calculate p
p_2 = H_2 \ y_2;

% Pull out eacj part
p1_2 = p_2(1);
p2_2 = p_2(2);

% Calculate k_m and u_e0
k_m = p1_2;
u_e0 = (1/(2*k_m))*(Fe_0-p2_2);

% Print out the data
disp(['Fe_0 = ',num2str(Fe_0)]);
disp(['k_m = ', num2str(k_m)]);
disp(['u_e0 = ', num2str(u_e0)]);