<<<<<<< HEAD
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
points = bucketLinkagePoints(H_cur,I_cur,J_cur,K_cur);
set(h1,'XData',points(:,1),'YData',points(:,2));

points = boomPoints(C_cur,D_cur,F_cur);
set(h2,'XData',points(:,1),'YData',points(:,2));

points = stickPoints(E_cur,F_cur,G_cur,H_cur,I_cur);
set(h3,'XData',points(:,1),'YData',points(:,2));

[a, b, c] = ramPoints(C_cur,D_cur,E_cur,G_cur,J_cur);
col = '-or';
set(h4,'XData',a(:,1),'YData',a(:,2));
set(h5,'XData',b(:,1),'YData',b(:,2));
set(h6,'XData',c(:,1),'YData',c(:,2));

points = bucketPoints(ctheta3,(I_cur+K_cur)/2);
set(h7,'XData',points(:,1),'YData',points(:,2));

% Plot the point to be found
set(h8,'XData',find_pt(1),'YData',find_pt(2));

if flag_b == 1
    set(h9,'XData', -0.5, 'YData', 7.5);
else
    set(h9,'XData', 9, 'YData', 9);
end

if flag_s == 1
    set(h10,'XData', 3.5, 'YData', 7.5);
else
    set(h10,'XData', 9, 'YData', 9);
end

if flag_bk == 1
    set(h11,'XData', 7.5, 'YData', 7.5);
else
    set(h11,'XData', 9, 'YData', 9);
end

axis([-1 8 -5 8]);
title('Current Digger');


drawnow;
=======

clc;
% Potting the digger image
displayTimer   = displayTimer + 1;

if displayTimer > displayTimeOut
    col = [1 1 1];
    displayTimer = 0;
    subplot(2,4,6:8);
    [C_cur,D_cur,E_cur,F_cur,I_cur,H_cur,G_cur,J_cur,K_cur,~] = ...
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
    L_cur = points(4,:);
    axis([-1 6 -2 6]);
    title('Digger','color',col);
    set(gca,'XColor',col);
    set(gca,'YColor',col);
    axis equal;

    
    
    
    subplot(2,3,1);
    set(h8,'XData',xVector,'YData',yVector);
    if Lpos
        set(h8,'MarkerEdgeColor','g');
    else
        set(h8,'MarkerEdgeColor','b');
    end
    if Lpos
        title('L Point Tracking','color',col);
    else
        title('I Point Tracking','color',col);
    end
    axis([0 6.5 -1 4]);
    set(gca,'XColor',col);
    set(gca,'YColor',col);
    
    subplot(2,3,2);
    set(h9,'XData',x,{'YData'},...
        {boomK;stickK});
    axis([0 250*4 1.5 3.0]);
    set(gca,'XColor',col);
    set(gca,'YColor',col);
    title('Ram Curves','color',col);
    
    subplot(2,3,3)
    set(h10,'XData',x,{'YData'},...
        {setPointBCVect;setPointDEVect;curPointBCVect;curPointDEVect});
    title('Ram Velocities','color',col);
    axis([0 250*4 -280 280]);
    set(gca,'XColor',col);
    set(gca,'YColor',col);
    
    subplot(2,4,5);
    plot(-10,-10);

    axis off;
    yy  = 1;
    xx  = -1;
    dyy = 0.5;
    
    text(xx,yy,['dZ      : ' num2str(dz)],'color',col);
    yy = yy - dyy;
    text(xx,yy,['dR      : ' num2str(dr)],'color',col);
    yy = yy - dyy;
    text(xx,yy,['Hz      : ' num2str(1/TT)],'color',col);
    yy = yy - dyy;
    text(xx,yy,['Boom    : ' num2str(-boomRam)],'color',col);
    yy = yy - dyy;
    text(xx,yy,['Stick   : ' num2str(stickRam)],'color',col);
    yy = yy - dyy;
    text(xx,yy,['Bucket  : ' num2str(bucketRam)],'color',col);
    yy = yy - dyy;
    text(xx,yy,['Testing : ' num2str(testing)],'color',col);
    yy = yy - dyy;
    text(xx,yy,['Record  : ' num2str(record)],'color',col);
    yy = yy - dyy;
    ppp = stickPID;
    a = ppp.PID(1);
    t1 = ppp.Contrib.P(1);
    t2 = ppp.Contrib.I(1);
    t3 = ppp.Contrib.D(1);
    
   
    text(xx,yy,['Contrib (P,I,D)  : ' num2str(t1) ',' num2str(t2) ',' num2str(t3) ','],'color',col);
    yy = yy - dyy;
    
    axis([-1 1 yy 1]);
    
    drawnow;
end

% %
% % disp(['Ram Current 1: ' num2str(curPointBC)]);
% % disp(['Ram Current 2: ' num2str(curPointDE)]);
% % disp(['Ram Desired 1: ' num2str(setPointBC)]);
% % disp(['Ram Desired 2: ' num2str(setPointDE)]);
% % disp('...');
% % disp(['Ram 1 Value: ' num2str(boomRam)]);
% % disp(['Ram 2 Value: ' num2str(stickRam)]);
% % disp('...');
% % disp(['Theta 1: ' num2str(ctheta1)]);
% % disp(['Theta 2: ' num2str(ctheta2)]);
% % disp('...');
% % disp(['Radius : ' num2str(I_des(1))]);
% % disp(['zHeight: ' num2str(I_des(2))]);
% % disp('...');
% % EF = norm(E_cur - F_cur);
% % DF = norm(D_cur - F_cur);
% %
% % disp(['EF : ' num2str(EF)]);
% % disp(['DF : ' num2str(DF)]);
% % disp(['...']);
disp(['dZ : ' num2str(dz)]);
disp(['dR : ' num2str(dr)]);
% disp(['...']);
% disp(['DE : ' num2str(norm(D_des-E_des))]);
disp(['Hz : ' num2str(1/TT)]);
% disp(['DE : ' num2str(norm(D_des-E_des))]);


disp(['BoomRam : ' num2str(-boomRam)]);
disp(['StickRam : ' num2str(stickRam)]);
disp(['BucketRam : ' num2str(bucketRam)]);


disp(['Testing : ' num2str(testing)]);

disp(['Record : ' num2str(record)]);

>>>>>>> origin/TL-Tetsing





