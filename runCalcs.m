% Calculate new position of the arm
error = 0.2;
% BUCKET IS MOVED REDRAW
% Calculate the angle for the boom
boomTheta = mapControl(xBucket,yBucket,stickLength,boomLength);

% Boom
xBoomN = [0 boomLength*sin(boomTheta)];
yBoomN = [0 boomLength*cos(boomTheta)];
% Stick
xStickN = [xBoomN(2) xBucket(1)];
yStickN = [yBoomN(2) yBucket(1)];

% Sanity checking to make sure we do not break it
% currently not actually working sorry.
boomL  = sqrt((xBoomN(2) - xBoomN(1))^2 + (yBoomN(2) - yBoomN(1))^2)
stickL = sqrt((xStickN(2) - xStickN(1))^2 + (yStickN(2) - yStickN(1))^2)

if stickL > stickLength - error && stickL < stickLength + error
    if boomL > boomLength - error && boomL < boomLength + error
        
        xBoom  = xBoomN;
        yBoom  = yBoomN;

        xStick = xStickN;
        yStick = yStickN;
        
    end
end 

bucketTheta = bucketOffset;
xBucket(2) = xBucket(1)+bucketLength*sin(bucketTheta);
yBucket(2) = yBucket(1)+bucketLength*cos(bucketTheta);