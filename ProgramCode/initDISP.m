% Display initialisation



% Figure handle setup
%figure;


% PID Ram Tracking Graph


% Intial Position Setup
C_cur = [0, 0];
D_cur = [0, 0];
E_cur = [0, 0];
F_cur = [0, 0];
I_cur = [0, 0];
C_des = C_cur;
D_des = D_cur;
E_des = E_cur;
F_des = F_cur;
I_des = I_cur;



% Draw the initial digger to speed up the process
% actualPos = subplot(1,2,1);
% h1 = plot([0        D_cur(1)], [0        D_cur(2)], '-ob'); hold on;  %AD
% h2 = plot([C_cur(1) F_cur(1)], [C_cur(2) F_cur(2)], '-ob'); hold on;  %CF
% h3 = plot([C_cur(1) D_cur(1)], [C_cur(2) D_cur(2)], '-ob'); hold on;  %CD
% h4 = plot([D_cur(1) F_cur(1)], [D_cur(2) F_cur(2)], '-ob'); hold on;  %DF
% h5 = plot([F_cur(1) E_cur(1)], [F_cur(2) E_cur(2)], '-og'); hold on;  %FE
% h6 = plot([F_cur(1) I_cur(1)], [F_cur(2) I_cur(2)], '-og'); hold on;  %FI
% h7 = plot([D_cur(1) E_cur(1)], [D_cur(2) E_cur(2)], '-or'); hold on;  %DE
% h8 = plot([0.5      C_cur(1)], [-0.3     C_cur(2)], '-or'); hold on;  %BC
% h9 = plot([0        C_cur(1)], [0        C_cur(2)], '-ob'); hold on;  %AC
% h10 = plot([E_cur(1) I_cur(1)], [E_cur(2) I_cur(2)], '-og'); hold on;  %EI
% h11 = plot([I_cur(1)], [I_cur(2)], 'sk '); hold on;                    %I
% axis([-1 8 -5 5]);
% title('Current Digger');
% 
% % Plot Actual Position
% currentPos = subplot(1,2,2);
% h12 = plot([0        D_des(1)], [0        D_des(2)], '-ob'); hold on;  %AD
% h13 = plot([C_des(1) F_des(1)], [C_des(2) F_des(2)], '-ob'); hold on;  %CF
% h14 = plot([C_des(1) D_des(1)], [C_des(2) D_des(2)], '-ob'); hold on;  %CD
% h15 = plot([D_des(1) F_des(1)], [D_des(2) F_des(2)], '-ob'); hold on;  %DF
% h16 = plot([F_des(1) E_des(1)], [F_des(2) E_des(2)], '-og'); hold on;  %FE
% h17 = plot([F_des(1) I_des(1)], [F_des(2) I_des(2)], '-og'); hold on;  %FI
% h18 = plot([D_des(1) E_des(1)], [D_des(2) E_des(2)], '-or'); hold on;  %DE
% h19 = plot([0.5      C_des(1)], [-0.3     C_des(2)], '-or'); hold on;  %BC
% h20 = plot([0        C_des(1)], [0        C_des(2)], '-ob'); hold on;  %AC
% h21 = plot([E_des(1) I_des(1)], [E_des(2) I_des(2)], '-og'); hold on;  %EI
% h22 = plot([I_des(1)], [I_des(2)], 'sk '); hold on;                    %I
% axis([-1 8 -5 5]);
% title('Desired Digger');