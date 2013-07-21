clc;
clear variables;
close all;

% Initialisation Functions
initCAN();           % CAN Initilisation
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
    
    % Read the current Angle from the Sensors
    getAngles(  );
    T1 = toc; tic;
    ctheta1 = boomAngle + 7.9124 + 29.2404;
    ctheta2 = stickAngle;
    
    % Calculate the Changed Position from the Joystick
    [dTheta, dR, dZ] = getMove(joyID, 'xbox');
    rotAngle = rotAngle + dTheta/5;    % Chassis Rotation
    
    T2 = toc; tic;
    % Calculate the Current I
    [C_cur,D_cur,E_cur,F_cur,I_cur] = calcPositionFromAngles(ctheta1,ctheta2);
    T3 = toc; tic;
    % Calculate the Desired Angles    
    [dtheta1, dtheta2] = calcAnglesFromPosition(I_cur,[dR, dZ]);
    T4 = toc; tic;
    % Get the positions of desired/current point (using angles)
    [C_des,D_des,E_des,F_des,I_des] = calcPositionFromAngles(dtheta1,dtheta2);
    
    
    % Loop until at desired location
    
    while norm(I_des - I_cur) > 0.03
        getAngles(  );
        ctheta1 = boomAngle + 7.9124 + 29.2404;
        ctheta2 = stickAngle;
    
        [C_cur,D_cur,E_cur,F_cur,I_cur] = calcPositionFromAngles(ctheta1,ctheta2);

        % Get the RAM extensions
        [DesBoR, DesStR] = calcRamExtension([.68 -.408],C_cur,D_cur,E_cur);
        [CurBoR, CurStR] = calcRamExtension([.68 -.408],C_des,D_des,E_des);
        T5 = toc; tic;
        % Run the P(I)D Controller
        desExt = [DesBoR, DesStR, 0]; % Desired Ram Extensions
        curExt = [CurBoR, CurStR, 0]; % Current Ram Extensions

        boGains = [ 100 100000 1];          % Boom Gains
        stGains = [ 100 100000 1];          % Stick Gains
        buGains = [ 1 1 1];           % Bucket Gains

%         T6 = toc; tic;
%          [boomRam, stickRam, bucketRam] = getPIDRam(desExt,curExt, ... 
%              boGains,stGains,buGains);      % Return the velocities of the rams.

        [boomRam, stickRam] = calcControl(DesBoR,DesStR,CurBoR,CurStR);
%         T7 = toc; tic;
        % Transmit the RAM Values
        updateRams(canChan, boomRam, stickRam, 0);

        T8 = toc; tic;

        % Display useful information in a GUI and on the Command Window
        displayInfo();
    end
    
    if norm(I_des - I_cur) < 0.03
        % Transmit the RAM Values
        updateRams(canChan, 0, 0, 0);
        
    end
    % Get the RAM extensions
    [DesBoR, DesStR] = calcRamExtension([.68 -.408],C_cur,D_cur,E_cur);
    [CurBoR, CurStR] = calcRamExtension([.68 -.408],C_des,D_des,E_des);
    [boomRam, stickRam] = calcControl(DesBoR,DesStR,CurBoR,CurStR);
    % Display useful information in a GUI and on the Command Window
    displayInfo();
    % Paces loop for constant cycle time
    while toc < tCycle
        TT = toc;
    end   
%     TT = toc;
%     clc;
%     disp(['T1 : ' num2str(T1)]);
%     disp(['T2 : ' num2str(T2)]);
%     disp(['T3 : ' num2str(T3)]);
%     disp(['T4 : ' num2str(T4)]);
%     disp(['T5 : ' num2str(T5)]);
%     disp(['T6 : ' num2str(T6)]);
%     disp(['T7 : ' num2str(T7)]);
%     disp(['T8 : ' num2str(T8)]);
%     disp(['Hz : ' num2str(1/TT)]);
%     % Testing without Simulator Code Remove in Real Situation
%     I_cur = I_des;
%     [ctheta1, ctheta2] = calcAnglesFromPosition(I_cur,[0, 0]);
end
    
    