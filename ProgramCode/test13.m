% Testing PID tracking of the rams as compared to the movment of the
% points;
clc;
clear all;
close all;

% Generate the path and truncate it (as per normal)
desiredX = 6;
desiredY = -.5;

currentX = 3;
currentY = 0;

dt     = 0.1;
N      = 100*1/dt;
matrix = [ linspace(currentX,desiredX,N)', linspace(currentY,desiredY,N)'];

II = 1;
while II < N+1
    
    [dtheta1, dtheta2]  = calcAnglesFromPosition([matrix(II,1),matrix(II,2)],[0,0]);
    [Cd, Dd, Ed, Fd, Id]  = calcPositionFromAngles(dtheta1, dtheta2,0);
    BC2(II) = norm([.68,-.408] - Cd);
    DE2(II) = norm(Dd - Ed);
    II = II + 1;
    
end
G = Cd;
% Truncate the vectors so there are no NaN
% (end point)
[a, b] = find(isnan(BC2),1);
if isempty(a) == 1
    temp1 = BC2(1:end);
    temp2 = DE2(1:end);
else
    temp1 = BC2(1:b);
    temp2 = DE2(1:b);
end

[a, b] = find(isnan(temp2),1);
if isempty(a) == 1
    finalBC = temp1(1:end);
    finalDE = temp2(1:end);
else
    finalBC = temp1(1:b);
    finalDE = temp2(1:b);
end

% First RAM
ddu1  = zeros(1,length(finalBC));
du1   = zeros(1,length(finalBC));
u1    = zeros(1,length(finalBC));
u1(:) = finalBC(1);
sp1   = finalBC;

% Second RAM
ddu2  = zeros(1,length(finalDE));
du2   = zeros(1,length(finalDE));
u2    = zeros(1,length(finalDE));
u2(:) = finalDE(1);
sp2   = finalDE;

% Control Parameters
P1  = .50;
D1  = 100;
I1  = 5;

P2  = P1;
D2  = D1;
I2  = I1;

N  = length(sp1);

% Now PID track the loop for all points
for III = 3:N
    
    ddu1(III) = P1*(sp1(III - 1) - u1(III - 1))-D1*(u1(III-1) - u1(III-2))...
        + I1*sum( sp1(1:III-1) - u1(1:III-1) );
    du1 (III) = du1(III - 1)  + ddu1(III)  * dt; % v = a*t
    u1  (III) = u1 (III - 1)  + du1 (III) * dt;  % u = v*t
    
    ddu2(III) = P2*(sp2(III - 1) - u2(III - 1))-D2*(u2(III-1) - u2(III-2))...
        + I2*sum( sp2(1:III-1) - u2(1:III-1) );
    du2 (III) = du2(III - 1)  + ddu2(III)  * dt; % v = a*t
    u2  (III) = u2 (III - 1)  + du2 (III)  * dt;  % u = v*t
    
end

% figure;
% t = 1:N;
% plot(t,[sp1', u1',sp2', u2']);
% legend('SP1','U1','SP2','U2');




for III = 1:N
    
   Cp1(III,:) = calcIntersectionPoint2([0 0],[.68,-.408],u1(III),2.0132) ;
   
   theta1 = atan2d (Cp1(III,2),Cp1(III,1) ) + 7.9;
   [Cd1(III,:), Dd1, ~, Fd1, ~]  = calcPositionFromAngles(theta1, 0,0);
     
   Ep1(III,:) = calcIntersectionPoint2(Dd1,Fd1,0.6844,u2(III)) ;
   
   theta2 = atan2d (+Ep1(III,2) - Fd(2),+Ep1(III,1) - Fd(1) ) - 156.9;
   [Cd, Dd, Ed1(III,:), Fd, Id]  = calcPositionFromAngles(theta1, theta2,0);
    
   I0(III,:) = Id;
   e1(III) = norm(Cp1(III,:)-[.68 -.408]); 
   e2(III) = norm(Ed1(III,:)-Dd1); 
end


figure;
plot(I0(2:end,1),I0(2:end,2),'r',[currentX,desiredX],[currentY, desiredY],'c');
legend('Desired','Actual');
axis([0 7.5 -5 5]);
% figure;
% ttt = 1:length(e1);
% plot(ttt,[e2',sp2']);
% 
% figure;plot(Ed1(:,1),Ed1(:,2),'.c'); hold on;
% plot(Ep1(:,1),Ep1(:,2),'.r'); hold off;


ang= 0:0.01:2*pi;
% x1 = (2.0132)*cos(ang);
% y1 = (2.0132)*sin(ang);
% x2 = (sp1(III))*cos(ang) + .68;
% y2 = (sp1(III))*sin(ang) + -.408;
% 
% figure;plot(x1,y1,'g',x2,y2,'r',Cd1(III,1),Cd1(III,2),'oc')
% 
% x3 = (0.6844)*cos(ang) + Fd(1);
% y3 = (0.6844)*sin(ang) + Fd(2);
% x4 = (sp2(III))*cos(ang) + Dd(1);
% y4 = (sp2(III))*sin(ang) + + Dd(2);
% 
% figure;plot(x3,y3,'g',x4,y4,'r',Ed1(III,1),Ed1(III,2),'oc',Ep1(III,1),Ep1(III,2),'oy')
