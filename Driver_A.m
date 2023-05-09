% Neel Tangella, tangella@usc.edu

%   Note we set and update all parameter values
%   in the function, as such we have different functions
%   they all contain the same code but for different parameter
%   perturbations we define different functions
%   Running the driver files in alphabetical order will yield 
%   the figures in generally the same order they appear in the paper
%   For time sake we use ODE15s, ODE45 will work but takes 
%   significantly longer


clear; clc; close all; 

numdiffeqn = 21; 

initvalue = zeros(numdiffeqn, 1); 

initvalue(1, 1) = 9e-13; 
initvalue(5, 1) = 1e-13; 
initvalue(8, 1) = 1e-12; 
initvalue(11, 1) = 1e-13; 
initvalue(13, 1) = 0.31; 
initvalue(14, 1) = 99.4; 
initvalue(15, 1) = 0.29; 
initvalue(16, 1) = 100; 
initvalue(18, 1) = 100; 
initvalue(20, 1) = 96; 
initvalue(21, 1) = 4; 

tstep = 0.001; 
stopTime = 2500; 
tspan = 0:tstep:stopTime; 
options = odeset('RelTol',1e-13);
[tsim, results] = ode15s(@Feedback_Model_A, tspan, initvalue, options);

figure(1);
subplot(2,1, 1)
knockdown_ratio = []; 
ss_conc = [];
varying_conc = 0.1:0.05:1; 
for i = 1:size(varying_conc, 2)
    initvalue(1, 1) = varying_conc(i) * 9e-13; 
    [tsim, results] = ode15s(@Feedback_Model_A, tspan, initvalue, options);
    knockdown_ratio = [knockdown_ratio, varying_conc(i)];
    ss_conc = [ss_conc, results(end, 9)];
end
plot(knockdown_ratio, ss_conc, 'LineWidth', 2); 
xlabel('IR Level (normalized)');
ylabel('S.S p-IRS1 (tyrosine phosphorylated) (M)');



subplot(2, 1, 2)
knockdown_ratio = []; 
ss_conc = [];
varying_conc = 0.1:0.05:1; 
for i = 1:size(varying_conc, 2)
    initvalue(1, 1) = varying_conc(i) * 9e-13; 
    [tsim, results] = ode15s(@Feedback_Model_A, tspan, initvalue, options);
    knockdown_ratio = [knockdown_ratio, varying_conc(i)];
    ss_conc = [ss_conc, results(end, 10)];
end
plot(knockdown_ratio, ss_conc, 'LineWidth', 2); 
xlabel('IR Level (normalized)');
ylabel('S.S p-IRS1 (serine phosphorylated) (M)');



figure(2)
subplot(2, 1, 1)
init_conc = [1, 2, 6, 7, 10];
hold on
for i = 1:5
    initvalue(1, 1) = 0.1 * init_conc(i) * 9e-13; 
    [tsim, results] = ode15s(@Feedback_Model_A, tspan, initvalue, options);
    plot(tsim, results(:, 17), 'LineWidth', 2); 
end
xlim([0 stopTime]);
legend('10%', '20%', '60%', '70%', '100%', 'Location', 'southeast');
ylabel('%p-Akt')
xlabel('time [min]')
hold off

subplot(2, 1, 2)
knockdown_ratio = []; 
ss_conc = [];
varying_conc = 0.1:0.05:1; 
for i = 1:size(varying_conc, 2)
    initvalue(1, 1) = varying_conc(i) * 9e-13; 
    [tsim, results] = ode15s(@Feedback_Model_A, tspan, initvalue, options);
    knockdown_ratio = [knockdown_ratio, varying_conc(i)];
    ss_conc = [ss_conc, results(end, 17)];
end
plot(knockdown_ratio, ss_conc, 'LineWidth', 2); 
xlabel('IR Level (normalized)');
ylabel('% p-AKT S.S');

