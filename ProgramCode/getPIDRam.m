function [ boomRam, stickRam, bucketRam ] = getPIDRam( desExt, curExt,...
    boomGains, stickGains, bucketGains )
% Inputs
% desExt = 3x1 vector containing the desired extensions for the 3 Rams
% desExt = 3x1 vector containing the current extensions for the 3 Rams
%          [1,1] = Boom
%          [2,1] = Stick
%          [3,1] = Bucket


% Calculate the values to send to the ram
persistent Td;                  % Time step
persistent prevBoomErr;        % Previous Boom Extension
persistent prevStickErr;       % Previous Stick Extension
persistent prevBucketErr;      % Previous Bucket Extension
persistent integralBoomError;  % Integral error accumulator
persistent integralStickError; % Integral error accumulator
persistent integralBucketError;% Integral error accumulator
persistent ramBoom;            % Ram value for the Boom
persistent ramStick;           % Ram value for the Stick
persistent ramBucket;          % Ram value for the Stick

% Max/Min values for the rams
maxBoomValue    = 250;
maxStickValue   = 250;
maxBucketValue  = 250;

% Initialisation of the persistent variables (only need to check one)
if isempty(ramBoom)
    Td                  = 0;
    ramBoom             = 0;
    ramStick            = 0;
    ramBucket           = 0;
    
    integralBoomError   = 0;
    integralStickError  = 0;
    integralBucketError = 0;
    
    prevBoomErr         = 0;
    prevStickErr        = 0;
    prevBucketErr       = 0;
end

% Gains for Each gain
Bok_p = boomGains(1);
Bok_d = boomGains(2);
Bok_i = boomGains(3);

Stk_p = stickGains(1);
Stk_d = stickGains(2);
Stk_i = stickGains(3);

Buk_p = bucketGains(1);
Buk_d = bucketGains(2);
Buk_i = bucketGains(3);


% PID Control 
dt  = cputime - Td; % Delta Time Step
Td  = cputime;

% Error
boomError    = (desExt(1) - curExt(1));
stickError   = (desExt(2) - curExt(2));
bucketError  = (desExt(3) - curExt(3));

integralBoomError   = integralBoomError  + boomError;
integralStickError  = integralStickError + stickError;
integralBucketError = integralBucketError + bucketError;

% Limit the Integral Error
intErrMax = 0.20;   % [m]

if integralBoomError > intErrMax
    integralBoomError = 0.20;
elseif integralBoomError < -intErrMax
    integralBoomError = -0.20;
end

if integralStickError > intErrMax
    integralStickError = 0.20;
elseif integralStickError < -intErrMax
    integralStickError = -0.20;
end

if integralBucketError > intErrMax
    integralBucketError = 0.20;
elseif integralBucketError < -intErrMax
    integralBucketError = -0.20;
end


% Derivative Error
boomDErr   = (boomError   - prevBoomErr);
stickDErr  = (stickError  - prevStickErr);
bucketDErr = (bucketError - prevBucketErr);


% P Gains
pBoom     = Bok_p * boomError;
pStick    = Stk_p * stickError;
pBucket   = Buk_p * bucketError;

% I Gain
iBoom     = Bok_i * integralBoomError;
iStick    = Stk_i * integralStickError;
iBucket   = Buk_i * integralBucketError;

% D Gain
dBoom     = Bok_d * boomDErr ;
dStick    = Stk_d * stickDErr ;
dBucket   = Buk_d * bucketDErr ;


% Get previous values to calculate velocity
prevBoomErr    = boomError;
prevStickErr   = stickError;
prevBucketErr  = bucketError;

% Calculate the adddition to the R;
% ramBoom   = ramBoom + pBoom + dBoom;
% ramStick  = ramStick + pStick + dStick;
% ramBucket = ramBucket + pBucket + dBucket;
if nan(1/dt)
    dt = 0.0001;
end


ramBoom   = pBoom - dBoom*dt + iBoom/dt;
ramStick  = pStick - dStick*dt + iStick/dt;
ramBucket = pBucket - dBucket;



boomRam   = ramBoom; %round(ramBoom);
stickRam  = ramStick; %round(ramStick);
bucketRam = round(ramBucket);





% Need to limit the values to the maximum ram value;

% Limit the boom ram
if boomRam > maxBoomValue
    boomRam = maxBoomValue;
elseif boomRam < -maxBoomValue
    boomRam = -maxBoomValue;
end

% Limit the stick ram
if stickRam > maxStickValue
    stickRam = maxStickValue;
elseif stickRam < -maxStickValue
    stickRam = -maxStickValue;
end

% Limit the bucket ram
if bucketRam > maxBucketValue
    bucketRam = maxBucketValue;
elseif bucketRam < -maxBucketValue
    bucketRam = -maxBucketValue;
end


end


