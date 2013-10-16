% drawing script.
clc;
clear all;
close all;
%% initDISP();
% Display initialisation
displayTimer   = 0;
displayTimeOut = 10;

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

x = 1:1000;
setPointBCVect = zeros(1,length(x));
setPointDEVect = zeros(1,length(x));
curPointBCVect = zeros(1,length(x));
curPointDEVect = zeros(1,length(x));


ctheta1 = 40;
ctheta2 = -15.3;
ctheta3 = -45;

[C_cur,D_cur,E_cur,F_cur,I_cur,H_cur,G_cur,J_cur,K_cur,L_cur] = ...
    calcPositionFromAngles(ctheta1,ctheta2,ctheta3);
curPointBC = norm([0.68 -.408] - C_cur);
curPointDE = norm(D_cur - E_cur);

%% Generate some random set points
I_des = I_cur;
IIII = 0;
while IIII < length(x)
    IIII = IIII + 1;
    
    I_des = I_des + [-0.004, 0];
    % Calculate the desired I (I_des) from the desired L
    [dtheta1, dtheta2] = calcAnglesFromPosition(I_des,[0 0]);
    
    [C_cur,D_cur,E_cur,F_cur,I_cur,H_cur,G_cur,J_cur,K_cur,L_cur] = ...
        calcPositionFromAngles(dtheta1,dtheta2,0);
    curPointBC = norm([0.68 -.408] - C_cur);
    curPointDE = norm(D_cur - E_cur);
    error = 0.005*rand + 0.0001*rand*cos(0.5*pi/(length(x)+1)*IIII) + + abs(0.015*cos(10*pi/(length(x)+1)*IIII));
    setPointBCVect(IIII) = curPointBC + error;
    error = 0.005*rand + 0.0001*rand*cos(0.5*pi/(length(x)+1)*IIII) + + abs(0.015*cos(10*pi/(length(x)+1)*IIII));
    setPointDEVect(IIII) = curPointDE + error;
    curPointBCVect(IIII) = curPointBC;
    curPointDEVect(IIII) = curPointDE;
end


colSubplot = 'white';

source = load([pwd '\data\2013.9.18-KPM2205-2.mat']);

range = 400:(400+length(x)-1);
xVector = source.x(range);
yVector = source.y(range);

boomK = source.boomRam(range);
stickK = source.sticRam(range);

% Draw the initial digger to speed up the process
FigHandle = figure('Position', [40, -100, 1648, 768],'color',[1 1 1]);
set(gcf, 'InvertHardCopy', 'off');
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 16.48 7.68])
subplot(2,4,7:8,'Color',colSubplot);

points = bucketLinkagePoints(H_cur,I_cur,J_cur,K_cur);
h1 = plot(points(:,1),points(:,2),'-ok'); hold all;
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
h7 = plot(points(:,1),points(:,2),'-r');

% Drawing the digger Body
col = [225 192 9]./255;
points = bodyPoints;
h12 = fill(points(:,1),points(:,2),col);

points = windowPoints;
h13 = fill(points(:,1),points(:,2),'c');

% Ground
points = [-20 -1.2; 20 -1.2; 20 -10; -20 -10; -20 -1.2];
h14 = fill(points(:,1),points(:,2),[185 122 87]./255);

axis([-1 8 -5 5]);
title('Current Digger');
axis equal;
subplot(2,3,1,'Color',colSubplot);
h8 = plot(xVector,yVector,'-r');
subplot(2,3,3,'Color',colSubplot)
h9 = plot(x,[boomK', stickK']);
subplot(2,3,2,'Color',colSubplot);
h10 = plot(x,[setPointBCVect', setPointDEVect',curPointBCVect', curPointDEVect']);

%% displayInfo();
col = [0 0 0];

subplot(2,4,7:8,'Color',colSubplot);
[C_cur,D_cur,E_cur,F_cur,I_cur,H_cur,G_cur,J_cur,K_cur,L_cur] = ...
    calcPositionFromAngles(ctheta1,ctheta2,ctheta3);
points = bucketLinkagePoints(H_cur,I_cur,J_cur,K_cur);
set(h1,'XData',points(:,1),'YData',points(:,2));


points = boomPoints(C_cur,D_cur,F_cur);
set(h2,'XData',points(:,1),'YData',points(:,2));

points = stickPoints(E_cur,F_cur,G_cur,H_cur,I_cur);
set(h3,'XData',points(:,1),'YData',points(:,2));

[a, b, c] = ramPoints(C_cur,D_cur,E_cur,G_cur,J_cur);

set(h4,'XData',a(:,1),'YData',a(:,2));
set(h5,'XData',b(:,1),'YData',b(:,2));
set(h6,'XData',c(:,1),'YData',c(:,2));

points = bucketPoints(ctheta3,(I_cur+K_cur)/2);
set(h7,'XData',points(:,1),'YData',points(:,2));
axis([-1 6 -2 6]);
title('Digger','color',col);
set(gca,'XColor',col);
set(gca,'YColor',col);
axis equal;

subplot(2,3,1,'Color',colSubplot);
set(gca,'Color',colSubplot)
set(h8,'XData',xVector,'YData',yVector);
title('L Point Tracking','color',col);

axis([0 8 -1.5 4]);
set(gca,'XColor',col);
set(gca,'YColor',col);

subplot(2,3,2,'Colorspec',colSubplot);
set(gca,'Color',colSubplot)
set(h9,'XData',x,{'YData'},...
    {boomK;stickK});
axis([0 250*4 1.5 3.0]);
set(gca,'XColor',col);
set(gca,'YColor',col);
title('Ram Curves','color',col);

subplot(2,3,3,'Color',colSubplot)
set(gca,'Color',colSubplot)
set(h10,'XData',x,{'YData'},...
    {setPointBCVect;setPointDEVect;curPointBCVect;curPointDEVect});
title('Ram Velocities','color',col);
axis([0 250*4 -280 280]);
set(gca,'XColor',col);
set(gca,'YColor',col);



subplot(2,4,5);
plot(-10,-10);



axis off;

dr = -.004;
dz = 0;
dthe = 0;
TT = 0.05;

yy  = 1;
xx  = -1;
dyy = 0.5;

text(xx,yy,['dZ      : ' num2str(dz)],'color',col);
yy = yy - dyy;
text(xx,yy,['dR      : ' num2str(dr)],'color',col);
yy = yy - dyy;
text(xx,yy,['dThe      : ' num2str(dthe)],'color',col);
yy = yy - dyy;
text(xx,yy,['Hz      : ' num2str(1/TT)],'color',col);
yy = yy - dyy;
text(xx,yy,['Boom    : ' num2str(-boomK((end)))],'color',col);
yy = yy - dyy;
text(xx,yy,['Stick   : ' num2str(stickK(end))],'color',col);
yy = yy - dyy;
text(xx,yy,['Positions  : [' num2str(I_cur(1)) ',' num2str(I_cur(2)) ']'],'color',col);
yy = yy - dyy;
axis([-1 1 yy 1]);

drawnow;
print(FigHandle,'-r1200','-dpng','GUI-HD.png')
%saveas(FigHandle,'GUI2.png')