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
actualPos = subplot(1,2,1);
set(h1,'XData',[0        D_cur(1)],'YData', [0        D_cur(2)]);  %AD
set(h2,'XData',[C_cur(1) F_cur(1)],'YData', [C_cur(2) F_cur(2)]);  %CF
set(h3,'XData',[C_cur(1) D_cur(1)],'YData', [C_cur(2) D_cur(2)]);  %CD
set(h4,'XData',[D_cur(1) F_cur(1)],'YData', [D_cur(2) F_cur(2)]);  %DF
set(h5,'XData',[F_cur(1) E_cur(1)],'YData', [F_cur(2) E_cur(2)]);  %FE
set(h6,'XData',[F_cur(1) I_cur(1)],'YData', [F_cur(2) I_cur(2)]);  %FI
set(h7,'XData',[D_cur(1) E_cur(1)],'YData', [D_cur(2) E_cur(2)]);  %DE
set(h8,'XData',[0.5      C_cur(1)],'YData', [-0.3     C_cur(2)]);  %BC
set(h9,'XData',[0        C_cur(1)],'YData', [0        C_cur(2)]);  %AC
set(h10,'XData',[E_cur(1) I_cur(1)],'YData', [E_cur(2) I_cur(2)]); %EI
set(h11,'XData',[I_cur(1)],'YData', [I_cur(2)]);                   %I
axis([-1 8 -5 5]);
title('Current Digger');

% Plot Actual Position
currentPos = subplot(1,2,2);
set(h12,'XData',[0        D_des(1)],'YData', [0        D_des(2)]);  %AD
set(h13,'XData',[C_des(1) F_des(1)],'YData', [C_des(2) F_des(2)]);  %CF
set(h14,'XData',[C_des(1) D_des(1)],'YData', [C_des(2) D_des(2)]);  %CD
set(h15,'XData',[D_des(1) F_des(1)],'YData', [D_des(2) F_des(2)]);  %DF
set(h16,'XData',[F_des(1) E_des(1)],'YData', [F_des(2) E_des(2)]);  %FE
set(h17,'XData',[F_des(1) I_des(1)],'YData', [F_des(2) I_des(2)]);  %FI
set(h18,'XData',[D_des(1) E_des(1)],'YData', [D_des(2) E_des(2)]);  %DE
set(h19,'XData',[0.5      C_des(1)],'YData', [-0.3     C_des(2)]);  %BC
set(h20,'XData',[0        C_des(1)],'YData', [0        C_des(2)]);  %AC
set(h21,'XData',[E_des(1) I_des(1)],'YData', [E_des(2) I_des(2)]);  %EI
set(h22,'XData',[I_des(1)],'YData', [I_des(2)]); hold on;                    %I
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
disp('...');
EF = norm(E_cur - F_cur);
DF = norm(D_cur - F_cur);
alpha0 = acosd((CurStR^2 - EF^2 - DF^2) / (-2*EF*DF));
disp(['Alpha : ' num2str(alpha0)]);
disp(['EF : ' num2str(EF)]);
disp(['DF : ' num2str(DF)]);
