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
actualPos = subplot(1,1,1);
set(h1,'XData',[0        D_cur(1)],'YData', [0        D_cur(2)]);  %AD
set(h2,'XData',[C_cur(1) F_cur(1)],'YData', [C_cur(2) F_cur(2)]);  %CF
set(h3,'XData',[C_cur(1) D_cur(1)],'YData', [C_cur(2) D_cur(2)]);  %CD
set(h4,'XData',[D_cur(1) F_cur(1)],'YData', [D_cur(2) F_cur(2)]);  %DF
set(h5,'XData',[F_cur(1) E_cur(1)],'YData', [F_cur(2) E_cur(2)]);  %FE
set(h6,'XData',[F_cur(1) H_cur(1)],'YData', [F_cur(2) H_cur(2)]);  %FI
set(h7,'XData',[D_cur(1) E_cur(1)],'YData', [D_cur(2) E_cur(2)]);  %DE
set(h8,'XData',[0.5      C_cur(1)],'YData', [-0.3     C_cur(2)]);  %BC
set(h9,'XData',[0        C_cur(1)],'YData', [0        C_cur(2)]);  %AC
set(h10,'XData',[G_cur(1) H_cur(1)],'YData', [G_cur(2) H_cur(2)]); %EI
set(h11,'XData',[K_cur(1)],'YData', [K_cur(2)]);                   %I
set(h12,'XData',[H_cur(1) I_cur(1)],'YData', [H_cur(2) I_cur(2)]); %EI
set(h13,'XData',[I_cur(1) K_cur(1)],'YData', [I_cur(2) K_cur(2)]); %EI
set(h14,'XData',[K_cur(1) J_cur(1)],'YData', [K_cur(2) J_cur(2)]); %EI
set(h15,'XData',[J_cur(1) H_cur(1)],'YData', [J_cur(2) H_cur(2)]); %EI
set(h16,'XData',[G_cur(1) J_cur(1)],'YData', [G_cur(2) J_cur(2)]); %EI
set(h17,'XData',[E_cur(1) G_cur(1)],'YData', [E_cur(2) G_cur(2)]); %EI
axis([-1 8 -5 5]);
title('Current Digger');


drawnow;





