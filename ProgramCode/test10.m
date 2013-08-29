<<<<<<< HEAD
% Test 10: Track point placement
clc;
close all;

points = zeros(8,2);
A = 1;
x = 0;
y = 0;
I0 = [0 0];
points(1,:) = I0;
points(2,:) = [0.1 -0.15] + I0;
points(3,:) = [0.1 -0.25] + I0;
points(4,:) = [0 -.4] + I0;
points(5,:) = [-2 -.4] + I0;
points(6,:) = [-2.1 -.25] + I0;
points(7,:) = [-2.1 -.15] + I0;
points(8,:) = [-2 0] + I0;
points(9,:) = I0;





h1 = plot(points(:,1),points(:,2),'-k');
while 1
    points(A,:) = [x y];
    

    set(h1,'XData',points(:,1),'YData',points(:,2))
    axis equal
    pause(0.1);
end
=======
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
>>>>>>> origin/TL-Tetsing
