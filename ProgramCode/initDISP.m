% Display initialisation



% Figure handle setup
figure;


% PID Ram Tracking Graph


% Intial Position Setup
C_cur = [0, 0];
D_cur = [0, 0];
E_cur = [0, 0];
F_cur = [0, 0];
I_cur = [0, 0];
H_cur = [0, 0];
J_cur = [0, 0];
K_cur = [0, 0];
G_cur = [0, 0];
C_des = C_cur;
D_des = D_cur;
E_des = E_cur;
F_des = F_cur;
I_des = I_cur;


% Draw the initial digger to speed up the process
actualPos = subplot(1,1,1);
h1 = plot([0        D_cur(1)], [0        D_cur(2)], '-ob'); hold on;  %AD
h2 = plot([C_cur(1) F_cur(1)], [C_cur(2) F_cur(2)], '-ob'); hold on;  %CF
h3 = plot([C_cur(1) D_cur(1)], [C_cur(2) D_cur(2)], '-ob'); hold on;  %CD
h4 = plot([D_cur(1) F_cur(1)], [D_cur(2) F_cur(2)], '-ob'); hold on;  %DF
h5 = plot([F_cur(1) E_cur(1)], [F_cur(2) E_cur(2)], '-og'); hold on;  %FE
h6 = plot([F_cur(1) H_cur(1)], [F_cur(2) H_cur(2)], '-og'); hold on;  %FI
h7 = plot([D_cur(1) E_cur(1)], [D_cur(2) E_cur(2)], '-or'); hold on;  %DE
h8 = plot([0.5      C_cur(1)], [-0.3     C_cur(2)], '-or'); hold on;  %BC
h9 = plot([0        C_cur(1)], [0        C_cur(2)], '-ob'); hold on;   %AC
h10 = plot([G_cur(1) H_cur(1)], [G_cur(2) H_cur(2)], '-og'); hold on;  %EI
h11 = plot([I_cur(1)], [I_cur(2)], 'sy '); hold on;                    %I

h12 = plot([H_cur(1) I_cur(1)], [H_cur(2) I_cur(2)], '-oc'); hold on;  %E
h13 = plot([I_cur(1) K_cur(1)], [I_cur(2) K_cur(2)], '-ok'); hold on;  %E
h14 = plot([K_cur(1) J_cur(1)], [K_cur(2) J_cur(2)], '-ok'); hold on;  %E
h15 = plot([J_cur(1) H_cur(1)], [J_cur(2) H_cur(2)], '-ok'); hold on;  %E
h16 = plot([G_cur(1) J_cur(1)], [G_cur(2) J_cur(2)], '-or'); hold on;  %E

h17 = plot([E_cur(1) G_cur(1)], [E_cur(2) G_cur(2)], '-og'); hold on;  %E



axis([-1 8 -5 5]);
title('Current Digger');
