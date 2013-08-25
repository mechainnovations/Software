function [ points ] = stickPoints( E,F,G,H,I )
% Get a vector containing all of the points along the boom

points(1,:) = E;     % E
points(2,:) = G;     % F
points(3,:) = H;     % H
points(4,:) = I;     % I
points(5,:) = F;     % F
points(6,:) = E;     % E

end

