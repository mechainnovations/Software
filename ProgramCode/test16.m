% Testing new PID structure loop
% WORKING!
close all;
clear all;
clc;


ctrlHandle = createCtrlHandle(0.01, 0.4, 0, 2000, 2000, 0);
ccc = ctrlHandle;
%% NEW PID CONTROLLER CODE
IIII = 2;
setpoint(1:200) = 0;
setpoint(200:400) = 250;
setpoint(400:600) = 0;
dup = 0;
up = 0;
dt = 0.01;

while IIII < length(setpoint)+1
    ccc.SP = setpoint(IIII);
    ccc = calcPID(ccc);
    
   
    ccc.CV(1) = ccc.PID(1) + ccc.CV(1);
    rr(IIII) = ccc.CV(1);
    IIII = IIII + 1;
end

x = 1:length(rr);

figure;
plot(x,setpoint,'g'); hold on;
plot(x,rr,'r');

