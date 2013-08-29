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
gainsMatrixP = xlsread('boomGains.xlsx','proportional');

x1 = gainsMatrixP(1,2:end);
y1 = gainsMatrixP(2:end,1);
gains = gainsMatrixP(2:end,2:end);
figure
surf(x1,y1,gains)
gainsMatrixD = xlsread('boomGains.xlsx','derivative');

x1 = gainsMatrixD(1,2:end);
y1 = gainsMatrixD(2:end,1);
gains = gainsMatrixD(2:end,2:end);
figure
surf(x1,y1,gains)
gainsMatrixI = xlsread('boomGains.xlsx','integral');

x1 = gainsMatrixI(1,2:end);
y1 = gainsMatrixI(2:end,1);
gains = gainsMatrixI(2:end,2:end);
figure
surf(x1,y1,gains)
size(x1)
size(y1)
size(gains)
% 0m - 5m in both directinos

U1 = [0 3.5];


gain = interp2(x1,y1,gains,U1(1),U1(2));

gain