function [ points ] = windowPoints(  )
% Draw the glass in the window

points(1,:) = [0.9 1.2];
points(2,:) = [0.9 -0.2];
points(3,:) = [-0.3 -0.2];
points(4,:) = [-0.3 0.4];
points(5,:) = [0.15 1.2];

points(end+1,:) = points(1,:);




end

