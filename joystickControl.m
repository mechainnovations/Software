%joystick controller test
% Joystick controls
BucketMoveSize = 0.1;


buttonpress = zeros(1,11);
axispress = zeros(1,3);

[axes, buttons] = read(joy); % read controller inputs

%Joystick and scroll movements
axisvalue1 = axes(1);
axisvalue2 = -axes(2);
axisvalue3 = -axes(3);


if (axisvalue1>abs(0.8))
    xBucket = xBucket + axisvalue1*BucketMoveSize;
end

if (axisvalue2<abs(0.8))
    yBucket = yBucket + axisvalue2*BucketMoveSize;
end

bucketOffset = axisvalue3 * pi + pi;
