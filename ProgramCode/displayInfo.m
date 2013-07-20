% Display some information that might be useful


% %% Draw pictures of the body rotating and the location of the bucket;
% % Make a rectangle Points
% x        = [-1 1 1 -1 -1];
% y        = [2 2 -2 -2 2];
% % Rotate Points
% xRot     = x*cos(rotAngle) - y*sin(rotAngle);
% yRot     = x*sin(rotAngle) + y*cos(rotAngle);
% 
% delete(bodyH);
% % Plot the Rotating Digger Frame
% bodyH = subplot(1,2,2); plot(xRot, yRot, '-og'); axis equal
% text(-4.5,-4.5, ['Theta = ' num2str(rotAngle)]);
% axis([-5 5 -5 5]);


% Plot Wanted position
delete(actualPos);
actualPos = subplot(1,2,1);
plot([0        D_cur(1)], [0        D_cur(2)], '-ob'); hold on;  %AD
plot([C_cur(1) F_cur(1)], [C_cur(2) F_cur(2)], '-ob'); hold on;  %CF
plot([C_cur(1) D_cur(1)], [C_cur(2) D_cur(2)], '-ob'); hold on;  %CD
plot([D_cur(1) F_cur(1)], [D_cur(2) F_cur(2)], '-ob'); hold on;  %DF
plot([F_cur(1) E_cur(1)], [F_cur(2) E_cur(2)], '-og'); hold on;  %FE
plot([F_cur(1) I_cur(1)], [F_cur(2) I_cur(2)], '-og'); hold on;  %FI
plot([D_cur(1) E_cur(1)], [D_cur(2) E_cur(2)], '-or'); hold on;  %DE
plot([0.5      C_cur(1)], [-0.3     C_cur(2)], '-or'); hold on;  %BC
plot([0        C_cur(1)], [0        C_cur(2)], '-ob'); hold on;  %AC
plot([E_cur(1) I_cur(1)], [E_cur(2) I_cur(2)], '-og'); hold on;  %EI
plot([I_cur(1)], [I_cur(2)], 'sk '); hold on;                    %I
axis([-1 8 -5 5]);
title('Current Digger');

% Plot Actual Position
delete(currentPos);
currentPos = subplot(1,2,2);
plot([0        D_des(1)], [0        D_des(2)], '-ob'); hold on;  %AD
plot([C_des(1) F_des(1)], [C_des(2) F_des(2)], '-ob'); hold on;  %CF
plot([C_des(1) D_des(1)], [C_des(2) D_des(2)], '-ob'); hold on;  %CD
plot([D_des(1) F_des(1)], [D_des(2) F_des(2)], '-ob'); hold on;  %DF
plot([F_des(1) E_des(1)], [F_des(2) E_des(2)], '-og'); hold on;  %FE
plot([F_des(1) I_des(1)], [F_des(2) I_des(2)], '-og'); hold on;  %FI
plot([D_des(1) E_des(1)], [D_des(2) E_des(2)], '-or'); hold on;  %DE
plot([0.5      C_des(1)], [-0.3     C_des(2)], '-or'); hold on;  %BC
plot([0        C_des(1)], [0        C_des(2)], '-ob'); hold on;  %AC
plot([E_des(1) I_des(1)], [E_des(2) I_des(2)], '-og'); hold on;  %EI
plot([I_des(1)], [I_des(2)], 'sk '); hold on;                    %I
axis([-1 8 -5 5]);
title('Desired Digger');

clc;
drawnow;
disp(['Ram Current 1: ' num2str(CurBoR)]);
disp(['Ram Current 2: ' num2str(CurStR)]);
disp(['Ram Desired 1: ' num2str(DesBoR)]);
disp(['Ram Desired 2: ' num2str(DesStR)]);
disp('...');
disp(['Ram 1 Value: ' num2str(boomRam)]);
disp(['Ram 2 Value: ' num2str(stickRam)]);
disp('...');
disp(['Theta 1: ' num2str(dtheta1)]);
disp(['Theta 2: ' num2str(dtheta2)]);
disp('...');
disp(['Radius : ' num2str(I_des(1))]);
disp(['zHeight: ' num2str(I_des(2))]);
