%   Neel Tangella, tangella@usc.edu
clear; clc; close all; 


%% Square Waveform Input
tstep = 1; 
stopTime = 500;
tspan = 0:tstep:stopTime; 
perturb_val = 10; 
f = 0.05; 
A = 6; 
y_square = [];
y_sine = [];

for i = 1:size(tspan, 2)
    if (tspan(i) >= 100 && tspan(i) <= 130)
        y_square = [y_square, perturb_val]; 
    elseif (tspan(i) >= 200 && tspan(i) <= 230)
        y_square = [y_square, perturb_val]; 
    elseif (tspan(i) >= 300 && tspan(i) <= 330)
        y_square = [y_square, perturb_val]; 
    elseif (tspan(i) >= 400 && tspan(i) <= 430)
        y_square = [y_square, perturb_val]; 
    else
        y_square = [y_square, 0]; 
    end
end
figure(1); 
plot(tspan, y_square, 'LineWidth', 2, 'Color','k');
ylim([0 12]);
xlabel('time [min]');
xticks([100, 130, 200, 230, 300, 330, 400, 430])
xticklabels({'T_1 start', 'T_1 end', ...
    'T_2 start', 'T_2 end', ...
    'T_3 start', 'T_3 end', ...
    'T_4 start', 'T_4 end'})
xtickangle(45)
ylabel('Insulin Input (M)');

%% Sine Input

for i = 1:size(tspan, 2)
    if (tspan(i) >= 100 && tspan(i) <= 130)
        y_sine = [y_sine, A * abs(sin(2 * pi * f*tspan(i)))]; 
    elseif (tspan(i) >= 200 && tspan(i) <= 230)
        y_sine = [y_sine, A * abs(sin(2 * pi * f*tspan(i)))]; 
    elseif (tspan(i) >= 300 && tspan(i) <= 330)
        y_sine = [y_sine, A * abs(sin(2 * pi * f*tspan(i)))]; 
    elseif (tspan(i) >= 400 && tspan(i) <= 430)
        y_sine = [y_sine, A * abs(sin(2 * pi * f*tspan(i)))]; 
    else
        y_sine = [y_sine, 0]; 
    end
end


        
figure(2); 
plot(tspan, y_sine, 'LineWidth', 2, 'Color','k'); 
xlabel('time [min]')
xticks([100, 130, 200, 230, 300, 330, 400, 430])
xticklabels({'T_1 start', 'T_1 end', ...
    'T_2 start', 'T_2 end', ...
    'T_3 start', 'T_3 end', ...
    'T_4 start', 'T_4 end'})
xtickangle(45)
ylim([0 8]);
ylabel('Insulin Input (M)'); 

%% Dynamics


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

options = odeset('RelTol',1e-13);
[tsim, results] = ode15s(@Feedback_Model_A, tspan, initvalue); 
figure(3)
plot(tsim, results, 'LineWidth', 2);
xticks([300]); 
xticklabels({'\bf Insulin Input Added'}); 
xlabel('time [min]')
xtickangle(45)
ylabel('\bf Dynamics')

