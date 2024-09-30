clear; close all;
% Initial Values
Z_L = 50;
Z_0 = 50;
length_tran = 7.62; % meters
length_load = 0.9144; % meters
L = 290e-9;
C = 95e-12;

f = 0.1e6:0.1e6:20.0e6; % Frequency range
imaginary_values = zeros(1, numel(f)); % Preallocate array
counter = 1;

for i = 1:numel(f)
    freq = f(i);
    beta = 2 * pi * freq * sqrt(L * C);
    
    % Compute R1 and R2
    R1 = Z_0 * (Z_L + 1i * Z_0 * tan(beta * length_load)) / (Z_0 + 1i * Z_L * tan(beta * length_load));
    R2 = -1i * Z_0 * cot(beta * length_load);
    
    % Parallel combination of R1 and R2
    Z_P = 1 / (1/R1 + 1/R2);
    
    % Compute input impedance Z_in
    Z_in = Z_0 * ((Z_P + 1i * Z_0 * tan(beta * length_tran)) / (Z_0 + 1i * Z_P * tan(beta * length_tran)));
    
    % Store the imaginary part of Z_in
    imaginary_values(counter) = imag(Z_in);
    counter = counter + 1;
end

% Plot the results
plot(f / 1e6, imaginary_values);
xlabel('Frequency (MHz)');
ylabel('Imaginary Part');
title('Imaginary Part vs. Frequency');
grid on;