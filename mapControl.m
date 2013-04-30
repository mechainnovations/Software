function [ theta ] = mapControl( bucketPosX, bucketPosY, stickLength, boomLength )
% Maps a bucket x-y movement to the rotations needed from each section of
% the digger arm.

% REVERSE KNIEMATICS

distToBucket = sqrt(bucketPosX(1)^2 + bucketPosY(1)^2);

% Cosine Rule
cosAngle  = acos( (stickLength^2 - distToBucket^2 - boomLength^2)...
    / (-2 * boomLength * distToBucket) );

% Sine Rule
sinAngle  = asin(bucketPosY(1)/distToBucket);

% Use together to get the proper angle.
theta = pi/2 - cosAngle - sinAngle;

end

