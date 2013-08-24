% Testing all possible points around the digger.
clc;
clear all;
close all;
N = 50;

xPos = linspace(2.4,7.5  ,N);  % All xValues
yPos = linspace(-2.5, 4.5  ,N);  % All yValues
tht3 = linspace(0 ,360,N);  % All theta3 Values


for I = 1:length(xPos)
    for J = 1:length(yPos)
        for K = 1:length(tht3)
            [theta1, theta2,] = calcAnglesFromPosition([xPos(I), yPos(J)],[0, 0]);
            tmp = 180 + theta2 - tht3(K);
            tmp2(I,J,K) = tmp;
            if theta1 < 80 && theta1 > 45
                if theta2 < 15 && theta2 > -115
                    if tmp < 120 && tmp > 20
                        flag(I,J) = 1;
                    end
                end
            else
                flag(I,J) = 0;
            end
        end
    end
end

tmp = tmp(:);
figure;
contour(xPos,yPos,flag',1)