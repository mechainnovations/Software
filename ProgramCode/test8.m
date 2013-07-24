% Tetsing the maximum dispalcement
clear
clc
close all

I = 1;
J = 1;

dthe   = -pi/2:0.1:pi/2;
drad   = 2.48:0.1:(4.65+2.48);

dx = drad' * sin(dthe);
dy = drad' * cos(dthe);

[n,m] = size(dx);
I = 1;
J = 1;
while J < n+1
    while I < m+1
        [dtheta1, dtheta2]  = calcAnglesFromPosition([dx(J,I),dy(J,I)],[0,0]);
        [Cd, Dd, Ed, Fd, Id]  = calcPositionFromAngles(dtheta1, dtheta2);
        BC(J,I) = norm([.68,-.408] - Cd);
        DE(J,I) = norm(Dd - Ed);
        I = I + 1;
    end
    I = 1;
    J = J + 1;
end


figure;
subplot(2,2,1);surf(dx,dy,BC);
title('BC Ram');
subplot(2,2,2);surf(dx,dy,DE);
title('DE Ram');


% Find the line path;
currentX = 0;
currentY = -6;

desiredX = 4;
desiredY = 4;
N = 50;
matrix = [ linspace(currentX,desiredX,N)', linspace(currentY,desiredY,N)'];

II = 1;
while II < N+1
        [dtheta1, dtheta2]  = calcAnglesFromPosition([matrix(II,1),matrix(II,2)],[0,0]);
        [Cd, Dd, Ed, Fd, Id]  = calcPositionFromAngles(dtheta1, dtheta2);
        BC2(II) = norm([.68,-.408] - Cd);
        DE2(II) = norm(Dd - Ed);
        II = II + 1;
end


subplot(2,2,3); plot(matrix(:,1),BC2','c',matrix(:,1),DE2','k');
legend('Boom','Stick');
title('Extension vs. X');
subplot(2,2,4); plot(matrix(:,2),BC2','g',matrix(:,2),DE2','r');
legend('Boom','Stick');
title('Extension vs. Y');








        