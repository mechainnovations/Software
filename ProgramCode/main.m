clc;
clear;
close all;

% Initialisation Functions
% initCAN();           % CAN Initilisation
[joyID] = initJOY(); % Joystick Initilisation
initVARS();          % Certain Variables needed within code
initDISP();        % Setup figure handles for the GUI


% Main Program Loop
while 1

    % Read the current Angle from the Sensors
    % getAngles(  );
    
    % Calculate the Changed Position from the Joystick
    [dTheta, dRadius, dZ] = getMove(joyID, 'xbox');
    rotAngle = rotAngle + dTheta/5;    % Chassis Rotation
    
    % Calculate the Current Position
    boomAngle = 115 - 90;
    stickAngle = 54 - 90;
    I = calcCurrentPos(boomAngle, stickAngle+90);
    
    % Calculate RAM Extensions from Desired/Current Position
    [ DesBoR, CurBoR, DesStR, CurStR ] = getRamExt(dTheta, dRadius, dZ, I);
    
    % Run the P(I)D Controller
    desExt = [DesBoR, DesStR, 0]; % Desired Ram Extensions
    curExt = [CurBoR, CurStR, 0]; % Current Ram Extensions
    
    boGains = [ 10 1 1];                % Boom Gains
    stGains = [ 10 1 1];                % Stick Gains
    buGains = [ 1 1 1];                % Bucket Gains
    
    
    [boomRam, stickRam, bucketRam] = getPIDRam(desExt,curExt, ... 
        boGains,stGains,buGains);      % Return the velocities of the rams.
    
    % Transmit the RAM Values
    % updateRams(canChan, boomRam, stickRam, bucketRam);

    
	% Display useful information in a GUI and on the Command Window
    displayInfo();
    
    % Wait to ensure sytem does not run too fast.
    pause(0.1);    
end
    
    