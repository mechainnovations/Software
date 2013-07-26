clc;
clear variables;
close all;

% Tetsing!
boomAngle = 36;
stickAngle = -14;
bucketAngle = -14;
slewAngle = 0;
ctheta1 = boomAngle + 7.9124 + 29.2404;
ctheta2 = stickAngle;
ctheta3 = bucketAngle;
ctheta4 = slewAngle;


% Initialisation Functions
%initCAN();           % CAN Initilisation
[joyID] = initJOY();   % Joystick Initilisation
initVARS();            % Certain Variables needed within code
initDISP();            % Setup figure handles for the GUI

% Testing Code Set simulator to this value
% ctheta1 = 103;
% ctheta2 = -63.5;
TT = 0;


% Main Program Loop
while 1
    % Timing stuff
    tic;
    [a b c d] = getMove(joyID,'xbox');
    % Read the current Angle from the Sensors
    boomAngle = a+boomAngle;
    stickAngle = b+stickAngle;
    bucketAngle = c+bucketAngle;
    slewAngle = d+slewAngle;
    T1 = toc; tic;
    ctheta1 = boomAngle + 7.9124 + 29.2404;
    ctheta2 = stickAngle;
    ctheta3 = bucketAngle;
    ctheta4 = slewAngle;
    

    
    T2 = toc; tic;
    % Calculate the Current IC,D,E,F,I,H,G,J,K,L
    [C_cur,D_cur,E_cur,F_cur,I_cur,H_cur,G_cur,J_cur,K_cur,L_cur] = ...
        calcPositionFromAngles(ctheta1,ctheta2,ctheta3);
     
    % Paces loop for constant cycle time
    displayInfo;
    while toc < tCycle
        TT = toc;
    end   

end
    
    