% SETUP Script

%Joystick Setup
joy = vrjoystick(1);

c = caps(joy);
buttonassign = char('trig', 't2', 't3', 't4', 't5', 'b6', 'b7', 'b8', 'b9', 'b10', 'b11');
joystickaxis = char('x_axis', 'y_axis', 'z_axis');

% Setup lengths
boomLength   = 10;
stickLength  = 6;
bucketLength = 1;

% Setup angles
boomOffset  = degtorad(30);
stickOffset = degtorad(75);
bucketOffset = degtorad(30);

% Intialise the 
% Stick calculations
boomTheta = boomOffset;
xBoom = [0 boomLength*sin(boomTheta)];
yBoom = [0 boomLength*cos(boomTheta)];

% Boom calaculations
stickTheta = stickOffset + boomTheta;
xStick  = [xBoom(2) xBoom(2)+stickLength*sin(stickTheta)];
yStick  = [yBoom(2) yBoom(2)+stickLength*cos(stickTheta)];

% Bucket calaculations
bucketTheta = bucketOffset + stickTheta;
xBucket = [xStick(2) xStick(2)+bucketLength*sin(bucketTheta)];
yBucket = [yStick(2) yStick(2)+bucketLength*cos(bucketTheta)];

% Image drawing
stickHandle   = plot(xStick  , yStick  , 'r');
boomHandle    = plot(xBoom   , yBoom   , 'g');
bucketHandle  = plot(xBucket , yBucket , 'b');