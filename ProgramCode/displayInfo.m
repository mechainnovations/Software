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





