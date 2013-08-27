% Display initialisation
displayTimer   = 0;
displayTimeOut = 5;
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

%Set ctheta3 to zero
ctheta3 = 0;

points = bucketPoints(ctheta3,(I_cur+K_cur)/2);
h7 = fill(points(:,1),points(:,2),[0.1 0.1 0.1]);
axis equal;
subplot(2,3,1);
h8 = plot(xVector,yVector,'.b');
subplot(2,3,3)
h9 = plot(x,[boomK', stickK']);
subplot(2,3,2);
h10 = plot(x,[setPointBCVect', setPointDEVect',curPointBCVect', curPointDEVect']);

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

