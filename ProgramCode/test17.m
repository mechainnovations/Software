% Testing the gains lookup
close all;
clear all;
clc;

x1 = 0:0.1:6;
y1 = 0:0.1:4;

for x = 1:length(x1)
    for y = 1:length(y1)
        gains(y,x) = 900+900/10*((cos(x/length(x1)*2*pi) + sin(y/length(y1)*2*pi))/2);
    end
end


% 0m - 5m in both directinos

U1 = [0 3.5];


gain = interp2(0:0.1:6,0:0.1:4,gains,U1(1),U1(2));

surf(x1,y1,gains)
gain