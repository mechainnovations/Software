% Initialise the PID Handlers

boomPID  = createCtrlHandle('boomGainsExt.xlsx','boomGainsRet.xlsx',150, 220,1,170);
stickPID = createCtrlHandle('stickGainsExt.xlsx','stickGainsRet.xlsx',170, 250,1,185);
bucketPID = createCtrlHandle('stickGainsExt.xlsx','stickGainsRet.xlsx',190, 250,1,200);

bucketPID.kp = 0.9; 
bucketPID.kd = 0;
bucketPID.ki = 0;

boomPID.kp = 3000; 
boomPID.kd = 1000;
boomPID.ki = 400;

stickPID.kp = 4000; 
stickPID.kd = 1500;
stickPID.ki = 300;

% boomPID.kp = 0.9; 
% boomPID.kd = 0;
% boomPID.ki = 0.05;
% 
% stickPID.kp = 0.9; 
% stickPID.kd = 0;
% stickPID.ki = 0;

% Gains based on extending/retracting
boomGainsExt = [4000 2000 200];
stickGainsExt = [1500 0 300];

boomGainsRet = [4000 2000 300];
stickGainsRet = [1000 1800 200];