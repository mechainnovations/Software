% Initialise the PID Handlers

boomPID  = createCtrlHandle('boomGainsExt.xlsx','boomGainsRet.xlsx',180, 220,1,185);
stickPID = createCtrlHandle('stickGainsExt.xlsx','stickGainsRet.xlsx',205, 240,1,220);
bucketPID = createCtrlHandle('stickGainsExt.xlsx','stickGainsRet.xlsx',190, 250,1,200);

bucketPID.kp = 0.9; 
bucketPID.kd = 0;
bucketPID.ki = 0;


% Gains based on extending/retracting
boomGainsExt = [4000 2000 200];
stickGainsExt = [1500 0 300];

boomGainsRet = [4000 2000 300];
stickGainsRet = [1000 1800 200];

boomPID.RGains.kp = 4000; 
boomPID.RGains.kd = 300;
boomPID.RGains.ki = 100;

stickPID.EGains.kp = 1500; 
stickPID.EGains.kd = 100;
stickPID.EGains.ki = 800;

stickPID.RGains.kp = 1500; 
stickPID.RGains.kd = 300;
stickPID.RGains.ki = 800;

boomPID.EGains.kp = 4000; 
boomPID.EGains.kd = 300;
boomPID.EGains.ki = 600;

% boomPID.kp = 0.9; 
% boomPID.kd = 0;
% boomPID.ki = 0.05;
% 
% stickPID.kp = 0.9; 
% stickPID.kd = 0;
% stickPID.ki = 0;
