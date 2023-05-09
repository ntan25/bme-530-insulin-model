function dydt = Feedback_Model_TP1(t,y)

trt = 0;
x1 = 6.95e-11 + 0.4*6.95e-11*abs(sin(2*pi*0.5*0.0021*t));

 if(t > 300 & t <= 540)
         trt = 10*6.95e-11;
 end

    x2 = y(1); 
    x3 = y(2); 
    x4 = y(3); 
    x5 = y(4); 
    x6 = y(5); 
    x7 = y(6); 
    x8 = y(7); 
    x9 = y(8); 
    x10 = y(9); 
    x10a = y(10); 
    x11 = y(11); 
    x12 = y(12); 
    x13 = y(13); 
    x14 = y(14); 
    x15 = y(15); 
    x16 = y(16);
    x17 = y(17); 
    x18 = y(18); 
    x19 = y(19); 
    x20 = y(20); 
    x21 = y(21); 
    
    
    %params
    k1 = 6e7; 
    k_1 = 0.2; 
    k2 = k1; 
    k_2 = 100*k_1; 
    k3 = 2500; 
    k_3 = k_1; 
    k_4 = 0.003; 
    k4 = k_4/9; 
    k4p = 2.1e-3;
    k_4p = 2.1e-4; 
    k_5 = 1.67e-18; 
    k5 = 0;
    if (x6 + x7 + x8) > 1e-13
        k5 = 10 * k_5;
    else
        k5 = 60*k_5;
    end
    k6 = 0.461; 
    k7 = 4.16; 
    k_7 = (2.5/7.45) * k7; 
    k7p = log(2)/2; 
    k_7p = k7p * ((2.5/7.45)*(3.7e-13))/((6.27e-13) - (2.5/7.45)*(3.7e-13)); 
    k_8 = 10; 
    k8 = k_8 * (5/70.775)*(10^12); 
     PI3K = k8 * (3.7e-13) * (1e-13) / (k8 * (3.7e-13) + k_8); 
%PI3K = 2.54e-15
    k9_stimulated = 1.39; 
    k_9 = (94/3.1) * k9_stimulated; 
    k9_basal = (0.31/99.4) * k_9; 
    k9 = (k9_stimulated - k9_basal)*(x12/PI3K) + k9_basal; 
    k_10 = 2.77; 
    k10 = (3.1/2.9) * k_10; 
    k_11 = 10 * log(2); 
    k11 = (0.1 * k_11) * (x13 - 0.31) / (3.10 - 0.31); 
    k_12 = 10 * log(2); 
    k12 = (0.1 * k_12) * (x13 - 0.31) / (3.10 - 0.31); 
    k_13 = 0.167; 
    k13 = (4/96) * k_13; 
    APequil = 100/11; 
    effect = (0.2 * x17 + 0.8 * x19) / (APequil);
    k13p = ((40/60) - (4/96)) * k_13 * effect; 
    k_14 = 0.001155; 
    k14 = 96 * k_14; 
    IRp = 8.97e-13; 
    SHIP = 1.00; 
    PTEN = 1.00; 
    PTP = 0; 
    if x17 <= (400/11)
        PTP = (1 - 0.25*(x17/(100/11)));
    end
    Vmax = 20;
    Kd = 12; 
%     n = 1; 
    tau = 1.5; 
    PKC = (Vmax * x19 * ((t-tau)^1)) / (Kd^4 + x19*(t-tau)^4); 

    dydt(1, 1) = k_1 * x3 + k_3 * PTP * x5 - k1 * (trt+x1) * x2 + k_4 * x6 - k4 * x2; 
    dydt(2, 1) = k1 * (trt+x1) * x2 - k_1 * x3 - k3 * x3; 
    dydt(3, 1) = k2 * (trt+x1) * x5 - k_2 * x4 + k_4p * x7 - k4p * x4; 
    dydt(4, 1) = k3 * x3 + k_2 * x4 - k2 * (trt+x1) * x5 - k_3 * PTP * x5 + k_4p * x8 - k4p * x5;
    
    dydt(5, 1) = k5 - k_5 * x6 + k6 * PTP * (x7 + x8) + k4 * x2 - k_4 * x6; 

    dydt(6, 1) = k4p * x4 - k_4p * x7 - k6 * PTP * x7; 
    dydt(7, 1) = k4p * x5 - k_4p * x8 - k6 * PTP * x8; 

    dydt(8, 1) = k_7 * PTP * x10 - k7 * x9 * (x4 + x5) / IRp + k_7p * x10a  - k7p * PKC * x9; 
    dydt(9, 1) = k7 * x9 * (x4 + x5) / IRp + k_8 * x12 - (k_7 * PTP + k8 * x11) * x10; 
    
    dydt(10, 1) = k7 * PKC * x9 - k_7p * x10a; 

    dydt(11, 1) = k_8 * x12 - k8 * x10 * x11; 
    dydt(12, 1) = k8 * x10 * x11 - k_8 * x12; 

    dydt(13, 1) = k9 * x14 + k10 * x15 - (k_9 * PTEN + k_10 * SHIP) * x13; 
    dydt(14, 1) = k_9 * PTEN * x13 - k9 * x14; 

    dydt(15, 1) = k_10 * SHIP * x13 - k10 * x15; 
    dydt(16, 1) = k_11 * x17 - k11 * x16; 
    dydt(17, 1) = k11 * x16 - k_11 * x17; 
    dydt(18, 1) = k_12 * x19 - k12 * x18; 
    dydt(19, 1) = k12 * x18 - k_12 * x19; 
    dydt(20, 1) = k_13 * x21 - (k13 + k13p) * x20 + k14 - k_14 * x20; 
    dydt(21, 1) = (k13 + k13p) * x20 - k_13 * x21; 
    
end