function [points] = bucketPoints (theta3, I0 )

% Angles for the Bucket
alpha(1) = 80;
alpha(2) = 90;
alpha(3) = 128.7;

theta3 = theta3 + 38.7;

% Lengths for the bucket
length(1) = 0.8;
length(2) = 1.0;
length(3) = 1.28;

% Iterate through to get all of the points
points(1,:) = I0;  % Intial Point = 0
II = 1;
for II = 1:3
    points(II+1,1) = length(II)*cosd(theta3 - alpha(II)) + I0(1);
    points(II+1,2) = length(II)*sind(theta3 - alpha(II)) + I0(2);
end

% Ensure the closed loop
points(II+2,:) = points(1,:);

end