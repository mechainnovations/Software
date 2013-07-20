clc;
clear variables;
close all;

% Initialisation Functions
% initCAN();           % CAN Initilisation
[joyID] = initJOY();   % Joystick Initilisation
initVARS();            % Certain Variables needed within code
initDISP();            % Setup figure handles for the GUI

% Testing Code Set simulator to this value
ctheta1 = 103;
ctheta2 = -63.5;
TT = 0;


% Main Program Loop
while 1
    % Timing stuff
    tic;
    
    % Read the current Angle from the Sensors
    % getAngles(  );

    
    % Calculate the Changed Position from the Joystick
    [dTheta, dR, dZ] = getMove(joyID, 'xbox');
    rotAngle = rotAngle + dTheta/5;    % Chassis Rotation
    
    
    % Calculate the Current I
    [C_cur,D_cur,E_cur,F_cur,I_cur] = calcPositionFromAngles(ctheta1,ctheta2);
    
    % Calculate the Desired Angles    
    [dtheta1, dtheta2] = calcAnglesFromPosition(I_cur,[dR, dZ]);

    % Get the positions of desired/current point (using angles)
    [C_des,D_des,E_des,F_des,I_des] = calcPositionFromAngles(dtheta1,dtheta2);

    % Get the RAM extensions
    [DesBoR, DesStR] = calcRamExtension([0 0],C_cur,D_cur,E_cur);
    [CurBoR, CurStR] = calcRamExtension([0 0],C_des,D_des,E_des);
        
    % Run the P(I)D Controller
    desExt = [DesBoR, DesStR, 0]; % Desired Ram Extensions
    curExt = [CurBoR, CurStR, 0]; % Current Ram Extensions
    
    boGains = [ 1000 1000000 1];          % Boom Gains
    stGains = [ 1000 1000000 1];          % Stick Gains
    buGains = [ 1 1 1];           % Bucket Gains
    
    
    [boomRam, stickRam, bucketRam] = getPIDRam(desExt,curExt, ... 
        boGains,stGains,buGains);      % Return the velocities of the rams.
    
    % Transmit the RAM Values
    % updateRams(canChan, boomRam, stickRam, bucketRam);

    
	% Display useful information in a GUI and on the Command Window
    displayInfo();
    
    % Paces loop for constant cycle time
    while toc < tCycle
        ;
    end   

    % Testing without Simulator Code Remove in Real Situation
    I_cur = I_des;
    [ctheta1, ctheta2] = calcAnglesFromPosition(I_cur,[0, 0]);
end
    
    