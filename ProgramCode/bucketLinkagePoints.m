function [ points ] = bucketLinkagePoints( H,I,J,K )
% Get a vector containing all of the points along the boom

points(1,:) = I;     % E
points(2,:) = K;     % F
points(3,:) = J;     % H
points(4,:) = H;     % I

end
