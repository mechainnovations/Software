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
subplot(2,2,1);surf(dx,dy,BC,'linestyle','none');
title('Boom Ram');
subplot(2,2,2);surf(dx,dy,DE,'linestyle','none');
title('Stick Ram');


% Find the line path;
currentX = 0;
currentY = -6;

desiredX = 4;
desiredY = 4;


N = 500;
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
title('Radial Movement vs. Ram Extension');
subplot(2,2,4); plot(matrix(:,2),BC2','g',matrix(:,2),DE2','r');
legend('Boom','Stick');
title('Vertical Movement vs. Ram Extensions');



% PID Ram stuff;
JJ = 2;
currentRam1 = zeros(1,N);
currentRam2 = currentRam1;

while JJ < N + 1;
    [a,b] = getPIDRam([BC2(JJ) DE2(JJ) 0], [currentRam1(JJ-1), currentRam2(JJ-1) 0]...
        ,[0.9 0.2 0.5],[0.9 0 0.05],[0 0 0]);
    currentRam1(JJ) = currentRam1(JJ-1) + a;
    currentRam2(JJ) = currentRam2(JJ-1) + b;
    JJ = JJ + 1;
end

x = 1:N;
figure;
%plot(x',currentRam1','c',x,BC2','g'); hold on;
plot(x',currentRam1','c',x,BC2','g'); hold on;
plot(x',currentRam2','r',x,DE2','k'); hold on; hold off;


%% Set what happens with discretisation

II = 2;
JJ = 1;
KK = 1;

t = 0:1:1000;

currentRam1 = zeros(1,1000);
currentRam2 = currentRam1;

while II < length(t)
    
    if II == 400
        currentX = 4;
        currentY = -5;
        desiredX = 2;
        desiredY = -2;
        
        % Update the Graph
        N = 600;
        matrix = [ linspace(currentX,desiredX,N+1)', linspace(currentY,desiredY,N+1)'];
        
        JJ = II;
        while JJ < 1000+1
            [dtheta1, dtheta2]  = calcAnglesFromPosition([matrix(JJ-399,1),matrix(JJ-399,2)],[0,0]);
            [Cd, Dd, Ed, Fd, Id]  = calcPositionFromAngles(dtheta1, dtheta2);
            BC2(JJ) = norm([.68,-.408] - Cd);
            DE2(JJ) = norm(Dd - Ed);
            JJ = JJ + 1;
        end
    end
    [a,b] = getPIDRam([BC2(II) DE2(II) 0], [currentRam1(II-1), currentRam2(II-1) 0]...
    ,[0.2 0 0],[0.2 0 0],[0 0 0]);
    currentRam1(II) = currentRam1(II-1) + a;
    currentRam2(II) = currentRam2(II-1) + b;
    II = II + 1;
end
    
    
    
x = 1:1000;
figure;
plot(x',currentRam1','c',x,BC2','g'); hold on;
plot(x',currentRam2','r',x,DE2','k'); hold on; hold off;




        