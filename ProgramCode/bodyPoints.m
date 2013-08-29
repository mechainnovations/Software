function [ points ] = bodyPoints(  )
% Generate all of the points for the body


points(1,:) = [-.0 -.35];
% Tracks
points(2,:) = [-.0 -.5];
points(3,:) = [1.4 -.5];
points(4,:) = [1.5 -.8];
points(5,:) = [1.5 -1];
points(6,:) = [1.4 -1.2];
points(7,:) = [-3.1 -1.2];
points(8,:) = [-3.2 -1];
points(9,:) = [-3.2 -.8];
points(10,:) = [-3.1 -.5];
points(11,:) = [-1.8 -.5];
points(12,:) = [-1.8 -.35];
points(13,:) = [-3.1 -.35];
points(14,:) = [-3.1 0.5];
points(15,:) = [-.8 0.5];
points(16,:) = [-.3 1.3];
points(17,:) = [1 1.3];
points(18,:) = [1 -.35];
points(end+1,:) = points(1,:);

end

