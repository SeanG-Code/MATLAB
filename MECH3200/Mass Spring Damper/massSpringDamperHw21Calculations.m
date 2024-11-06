clear
close all
clc

load("massSpringDamperLeastSquaresData.mat","x_history","x_dot_history","u_history")

% HW21 SECTION START ------------------------------------------
% The code above loads the following variables
% - x_history: a matrix with each column representing the state vector x at
% a given point in time.
% - u_history: a matrix with each column representing the state input u at
% a given point in time.
% - x_dot_history: a matrix with each column representing the derivative of
% the state vector x at a given point in time.
% Use this data and least squares to estimate the A and B matricies for
% this system. Note: parametric uncertianty means that your state space
% matricies won't match the ones we've used previously. Submit your answers
% on the Canvas quiz.

% HW21 SECTION END --------------------------------------------
