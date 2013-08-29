% Display initialisation
<<<<<<< HEAD

=======
displayTimer   = 0;
displayTimeOut = 10;
>>>>>>> origin/TL-Tetsing
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
<<<<<<< HEAD
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
=======
FigHandle = figure('Position', [20, 60, 1648, 768],'color',[0 0 0]);
subplot(2,4,6:8);
points = bucketLinkagePoints(H_cur,I_cur,J_cur,K_cur);
h1 = plot(points(:,1),points(:,2),'-ok'); hold on;
L_cur = points(4,:);
points = boomPoints(C_cur,D_cur,F_cur);
h2 = fill(points(:,1),points(:,2),[0.1 0.1 0.1]);

points = stickPoints(E_cur,F_cur,G_cur,H_cur,I_cur);
h3 = fill(points(:,1),points(:,2),[0.1 0.1 0.1]);

[a, b, c] = ramPoints(C_cur,D_cur,E_cur,G_cur,J_cur);

h4 = plot(a(:,1),a(:,2),'-or','Linewidth',2);
h5 = plot(b(:,1),b(:,2),'-oy','Linewidth',2);
h6 = plot(c(:,1),c(:,2),'-og','Linewidth',2);

% Drawing the digger Body
subplot(2,4,6:8);
col = [225 192 9]./255;
points = bodyPoints;
h12 = fill(points(:,1),points(:,2),col);

points = windowPoints;
h13 = fill(points(:,1),points(:,2),'c');

% Ground
points = [-20 -1.2; 20 -1.2; 20 -10; -20 -10; -20 -1.2];
h14 = fill(points(:,1),points(:,2),[185 122 87]./255);


>>>>>>> origin/TL-Tetsing

%Set ctheta3 to zero
ctheta3 = 0;

points = bucketPoints(ctheta3,(I_cur+K_cur)/2);
<<<<<<< HEAD
h7 = plot(points(:,1),points(:,2),'-r'); hold off;

axis([-1 8 -5 5]);
title('Current Digger');
=======
h7 = fill(points(:,1),points(:,2),[0.1 0.1 0.1]);
axis equal;
subplot(2,3,1);
h8 = plot(xVector,yVector,'.b');
subplot(2,3,3)
h9 = plot(x,[boomK', stickK']);
subplot(2,3,2);
h10 = plot(x,[setPointBCVect', setPointDEVect',curPointBCVect', curPointDEVect']);
>>>>>>> origin/TL-Tetsing


