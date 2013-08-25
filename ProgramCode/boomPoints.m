function [ points ] = boomPoints( C,D,F )
% Get a vector containing all of the points along the boom

points(1,:) = [0 0];         % A
points(2,:) = C;             % C
points(3,:) = F;             % F
points(4,:) = D;             % D
points(5,:) = C;             % C

end

