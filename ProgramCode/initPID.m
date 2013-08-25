% Initialise the PID Handlers

boomPID  = createCtrlHandle(4000,2000,300,220,1,160);
stickPID = createCtrlHandle(1000,1800,200,250,1,180);

% Gains based on extending/retracting
boomGainsExt = [4000 2000 200];
stickGainsExt = [1500 0 300];

boomGainsRet = [4000 2000 300];
stickGainsRet = [1000 1800 200];