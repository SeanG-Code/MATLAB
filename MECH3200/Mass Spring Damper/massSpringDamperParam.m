%% Simulation
clear
close all
clc

% Reset Random Number Generator for repeatablity
rng(1);

%% Time
Param.t_start = 0;
Param.Ts      = 0.01;
Param.t_plot  = 0.1;

%% Animation
Param.box_size = 0.25; % m

Param.hlim = [-1.5,1.5];    % m
Param.vlim = [-1,2];    % m

Param.line_width = 1.5;

%% System Parameters
Param.m   = 5;    % kg
Param.k   = 3;    % m
Param.b   = 0.5;  % Ns/m

%% Saturation Limits
Param.F_max =  6; % N
Param.F_min = -6; % N

%% Equilibrium

% HW5 SECTION START ------------------------------------------
% Enter the equilibrium for each state variable. This does not need to be
% submitted, but must be completed correctly for future assignments.
Param.z_e     = 0;
Param.z_dot_e = 0;
Param.F_e     = Param.z_e*Param.k;
% HW5 SECTION END --------------------------------------------

%% Transfer Function
% HW6 SECTION START ------------------------------------------
% Enter the transfer function from F to z. Use matlab's tf function.
% This section does not need to be submitted, but must be completed
% correctly for future assignements.
Param.tf = NaN;
% HW6 SECTION END --------------------------------------------


%% State Space Matricies

% HW6 SECTION START ------------------------------------------
% Enter the state space matricies. Subscript r refers to the output
% associated with the reference signal. Subscript m refers to the output
% associated with the measurments which is to be feed back to the observer.
% This section does not need to be submitted, but must be completed
% correctly for future assignemtns.
Param.A   = NaN;
Param.B   = NaN;
Param.C_r = NaN;
Param.C_m = NaN;
Param.D_r = NaN;
Param.D_m = NaN;
% HW6 SECTION END --------------------------------------------
