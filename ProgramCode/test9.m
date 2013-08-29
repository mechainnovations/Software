<<<<<<< HEAD
clc;
clear;
close all;


JJ = 0;
while JJ < 360
    
    [a] = bucketPoints(JJ, [0 0]);
    plot(a(:,1),a(:,2),'-oc');
    axis([-0.7 0.7 -0.7 0.7]);
    drawnow;
    JJ = JJ +0.5;
end
=======
% Tetsing the maximum dispalcement
clear
clc
close all

I = 1;
J = 1;

dthe   = -pi/2:0.2:pi/2;
drad   = 2.48:0.2:(4.65+2.48);

dx = drad' * sin(dthe);
dy = drad' * cos(dthe);
tic
[n,m] = size(dx);
I = 1;
J = 1;
while J < n+1
    while I < m+1
        [dtheta1, dtheta2]  = calcAnglesFromPosition([dy(J,I),dx(J,I)],[0,0]);
        [Cd, Dd, Ed, Fd, Id]  = calcPositionFromAngles(dtheta1, dtheta2, 0);
        BC(J,I) = norm([.68,-.408] - Cd);
        DE(J,I) = norm(Dd - Ed);
        I = I + 1;
    end
    I = 1;
    J = J + 1;
end
t3 = toc;


figure;
subplot(1,2,1);surf(dx,dy,BC,'linestyle','none');
title('Boom Ram');
subplot(1,2,2);surf(dx,dy,DE,'linestyle','none');
title('Stick Ram');





%% Find point [x,y];
% N = 1;
% for III = 1:N
%     point = [4 -4.018];
%     
%     tmp1 = abs(dy - point(1));
%     tmp2 = abs(dx - point(2));
%     
%     Atmp = sqrt((tmp1.^2+tmp2.^2));
%     
%     [value, index] = min(Atmp(:));
%     [i,j] = ind2sub(size(Atmp),index);
%     
%     
%     % Get the Height value
%     val1 = BC(i,j);
%     
%     % Calculate the Height at the given point
%     [dtheta1, dtheta2]  = calcAnglesFromPosition(point,[0,0]);
%     [Cd, Dd, Ed, Fd, Id]  = calcPositionFromAngles(dtheta1, dtheta2, 0);
%     val2 = norm([.68,-.408] - Cd);
%     
%     avgD(III)  = val1 - val2;
%     
% end
% disp(['Val 1: ' num2str(val1)]);
% disp(['Val 2: ' num2str(val2)]);
% 
% figure;
% x = 1:N;
% plot(x,avgD);

%%
% Timing testing
num = 10;
N = 500;
currentX = 1;
currentY = -5;

desiredX = 5;
desiredY = 2.5;

% Regular method
tic;
for NN = 1:num
    clear matrix;
    matrix = [ linspace(currentX,desiredX,N)', linspace(currentY,desiredY,N)'];
    
    II = 1;
    while II < N+1
        [dtheta1, dtheta2]  = calcAnglesFromPosition([matrix(II,1),matrix(II,2)],[0,0]);
        [Cd, Dd, Ed, Fd, Id]  = calcPositionFromAngles(dtheta1, dtheta2,0);
        BC2(II) = norm([.68,-.408] - Cd);
        DE2(II) = norm(Dd - Ed);
        II = II + 1;
    end
end
t1 = toc;
tic;
% New method
for NN = 1:num
    clear matrix;
    matrix = [ linspace(currentX,desiredX,N)', linspace(currentY,desiredY,N)'];
    
    II = 1;
    while II < N+1
        tmp1 = abs(dy - matrix(II,1));
        tmp2 = abs(dx - matrix(II,2));
        
        Atmp = sqrt((tmp1.^2+tmp2.^2));
        
        [value, index] = min(Atmp(:));
        [i,j] = ind2sub(size(Atmp),index);
        
        
        % Get the Height value
        BC3(II) = BC(i,j);
        DE3(II) = DE(i,j);
        
        II = II + 1;
    end

    BC3 = smooth(BC3,135,'moving');
    DE3 = smooth(DE3,135,'moving');
end
t2 = toc;


disp(['Time: ' num2str(t3)]);
disp(['Old Method: ' num2str(t1/num)]);
disp(['New Method: ' num2str(t2/num)]);
disp(['Speed Increase: ' num2str(round(t1/t2*100)) '%']);

figure;
x = 1:length(BC2);
plot(x,[BC2',BC3,DE2',DE3]);
legend('Old','New');

tmp = BC2' - BC3;
mean(tmp)
std(tmp)



>>>>>>> origin/TL-Tetsing
