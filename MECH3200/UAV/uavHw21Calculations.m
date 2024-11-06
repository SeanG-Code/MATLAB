clear
close all
clc

load("uavLeastSquaresData.mat","states_history","states_dot_history","inputs_history")

% HW21 SECTION START ------------------------------------------
% The code above loads the following variables
% - states_history: a matrix with each column representing the state vector x at
% a given point in time. This is measured from the equilibrium.
% - inputs_history: a matrix with each column representing the state input u at
% a given point in time. This is measured from the equilibrium.
% - states_dot_history: a matrix with each column representing the derivative of
% the state vector x at a given point in time.
% Use this data and least squares to estimate the A and B matricies for
% this system. Note: parametric uncertianty means that your state space
% matricies won't match the ones we've used previously. Submit your answers
% on the Canvas quiz. You may assume that the system has been at
% equilibrium for a very long time before this dataset was created. As such
% the controller has learned the equilibrium input (through use of the
% integrator). Therefore, you should use the first entry in the
% inputs_history vector as the equilibrium input.



% HW21 SECTION END --------------------------------------------
