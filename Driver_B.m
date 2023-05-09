% Neel Tangella, tangella@usc.edu
clear; clc; close all; 
%   Note we set and update all parameter values
%   in the function, as such we have different functions
%   they all contain the same code but for different parameter
%   perturbations we define different functions
%   Running the driver files in alphabetical order will yield 
%   the figures in generally the same order they appear in the paper
%   For time sake we use ODE15s, ODE45 will work but takes 
%   significantly longer


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

tstep = 0.01; 
stopTime = 1740; 
tspan = 0:tstep:stopTime; 
options = odeset('RelTol',1e-13);

%%
%plot healthy vs diseased pIR, pIRS(Y), pAKT, PIP3
[tsim0, results0] = ode15s(@Feedback_Model_no_trt, tspan, initvalue,options);
initvalue(1,1) = 0.1*9e-13
[tsim6, results6] = ode15s(@Feedback_Model_no_trt, tspan, initvalue,options);
figure(1)
subplot(2,2,1)
plot(tsim6, results6(:,13),tsim0, results0(:,13),'LineWidth', 2) %PIP3
ylabel('Percentage (%)')
xlabel('Time(mins)')
title('PIP3')
xlim([300 1740])
xticks([400 600 800 1000 1200 1400 1600]);
xticklabels({'100', '300', '500', '700', '900', '1100', '1400'})

subplot(2,2,2)
plot(tsim6, results6(:,3),tsim0, results0(:,3),'LineWidth', 2) %pIR
ylabel('Molar Concentration (M)')
xlabel('Time(mins)')
title('pIR')
xlim([300 1740])
xticks([400 600 800 1000 1200 1400 1600]);
xticklabels({'100', '300', '500', '700', '900', '1100', '1400'})
legend('Healthy','Diseased')

subplot(2,2,3)
plot(tsim6, results6(:,9),tsim0, results0(:,9),'LineWidth', 2) %pIRS(Y)
ylabel('Molar Concentration (M)')
xlabel('Time(mins)')
title('pIRS(Y)')
xlim([300 1740])
xticks([400 600 800 1000 1200 1400 1600]);
xticklabels({'100', '300', '500', '700', '900', '1100', '1400'})

subplot(2,2,4)
plot(tsim6, results6(:,17),tsim0, results0(:,17),'LineWidth', 2) %pAKT
ylabel('Percentage (%)')
xlabel('Time(mins)')
title('pAKT')
xlim([300 1740])
xticks([400 600 800 1000 1200 1400 1600]);
xticklabels({'100', '300', '500', '700', '900', '1100', '1400'})

%% 
% plot trt simulaitons
initvalue(1,1) = 9e-13
[tsim1, results1] = ode15s(@Feedback_Model_no_trt, tspan, initvalue,options);

initvalue(1,1) = 0.1*9e-13
[tsim2, results2] = ode15s(@Feedback_Model_no_trt, tspan, initvalue,options);


[tsim3, results3] = ode15s(@Feedback_Model_TP1, tspan, initvalue,options);
[tsim4, results4] = ode15s(@Feedback_Model_TP2, tspan, initvalue,options);
[tsim5, results5] = ode15s(@Feedback_Model_TP3, tspan, initvalue,options);

figure(2)
plot(tsim3, results3(:,13),'m','LineWidth', 2)
hold on
plot(tsim4, results4(:,13),'c-.','LineWidth', 2)
plot(tsim5, results5(:,13),'k--','LineWidth', 2)
plot(tsim2, results2(:,13),'g--','LineWidth', 2);
plot(tsim1, results1(:,13),'LineWidth', 2)
hold off

xlabel('Time (mins)')
ylabel('Percentage (%)')
title('PIP3')
xticks([400 600 800 1000 1200 1400 1600]);
xticklabels({'100', '300', '500', '700', '900', '1100', '1400'})
xlim([320 1740])
legend("TP1", "TP2", "TP3", 'Diseased (No Treatment)','Healthy (No Treatment)','Location','northwest')
