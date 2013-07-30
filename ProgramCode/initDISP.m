% Display initialisation

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
figure;
points = bucketLinkagePoints(H_cur,I_cur,J_cur,K_cur);
h1 = plot(points(:,1),points(:,2),'-ok'); hold on;

points = boomPoints(C_cur,D_cur,F_cur);
h2 = plot(points(:,1),points(:,2),'-ok');

points = stickPoints(E_cur,F_cur,G_cur,H_cur,I_cur);
h3 = plot(points(:,1),points(:,2),'-ok');

[a, b, c] = ramPoints(C_cur,D_cur,E_cur,G_cur,J_cur);
col = '-og';
h4 = plot(a(:,1),a(:,2),col);
h5 = plot(b(:,1),b(:,2),col);
h6 = plot(c(:,1),c(:,2),col);

% Point to be found
h8 = plot(0,0, 'xk', 'MarkerSize', 10, 'Linewidth', 3);

% Flagging lights
h9 = plot(0.5, 7.5, '.r', 'MarkerSize', 25);
h10 = plot(3.5, 7.5, '.y', 'MarkerSize', 25);
h11 = plot(7.5, 7.5, '.g', 'MarkerSize', 25);

%Set ctheta3 to zero
ctheta3 = 0;

points = bucketPoints(ctheta3,(I_cur+K_cur)/2);
h7 = plot(points(:,1),points(:,2),'-r'); hold off;

axis([-1 8 -5 5]);
title('Current Digger');


