% Initialise the angle variables/code needed for this calculation

% Sensor Angles
% global boomAngle;
boomAngle   = 0;
% global stickAngle;
stickAngle  = 0;
% global bucketAngle;
bucketAngle = 0;
slewAngle   = 0;
% Global Slew Angle

% Displacements
dTheta  = 0;
dRadius = 0;
dZ      = 0;
dslew   = 0;
I       = [0, 0, 0];

% Positions
Vradius = 0;
Vz      = 0;

% Ram Extensions
boomExt   = 0;
stickExt  = 0;
bucketExt = 0;

% Time for one complete cycle
tCycle = 0.001;

% Ram velocities
boomRam   = 0;
stickRam  = 0;
bucketRam = 0;

% Path Points
curPointBC = 0;
curPointDE = 0;
setPointBC = 0;
setPointDE = 0;

% Testing Varaibles
timerPID = 0;
testing  = 0;
record   = 0;
TT       = 0;
Lpos     = 0;

