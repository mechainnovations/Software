% Initialise the PID Handlers

boomPID  = createCtrlHandle(900,500,0,250,1,0);
stickPID = createCtrlHandle(900,500,0,250,1,0);

% Gains based on extending/retracting
boomGainsExt = [4000 2000 200];
stickGainsExt = [1500 0 300];

boomGainsRet = [4000 2000 300];
stickGainsRet = [1000 1800 200];