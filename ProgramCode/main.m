clc            ;
clear variables;
close all      ;


%% RANDOM PLOTTING NONSENSE TO BE TAKEN OUT
KK = 1;
x  = 1 : 250*4;
xVector = zeros(1,length(x));
yVector = zeros(1,length(x));

boomK    = zeros(1,length(x));
stickK   = zeros(1,length(x));
bucketK  = zeros(1,length(x));
slewK    = zeros(1,length(x));

setPointBCVect = zeros(1,length(x));
setPointDEVect = zeros(1,length(x));
curPointBCVect = zeros(1,length(x));
curPointDEVect = zeros(1,length(x));


%% Initialisation Functions
%initCAN();             % CAN Initilisation
[joyID] = initJOY();   % Joystick Initilisation
initVARS();            % Certain Variables needed within code
initDISP();            % Setup figure handles for the GUI
initPID ();            % Initialise the PID handlers

% Testing Code Set simulator to this value
ctheta1 = 103;
ctheta2 = -63.5;
ctheta3 = -45;

dtheta = 0;



% Main Program Loop
while 1
    % Timing stuff
    tic;
    
    % Read angles from CAN
    % getAngles(  );
    %ctheta1 = 180+boomAngle + 7.9124 + 29.2404;
    ctheta1 = boomAngle-218.22+360+29.24+7.9124;
    ctheta2 = stickAngle;
    ctheta3 = 180+bucketAngle;
    ctheta4 = slewAngle;
    

    
    % Calculate the current position
    [C_cur,D_cur,E_cur,F_cur,I_cur,H_cur,G_cur,J_cur,K_cur,~] = ...
        calcPositionFromAngles(ctheta1,ctheta2,ctheta3);
    curPointBC = norm([0.68 -.408] - C_cur);
    curPointDE = norm(D_cur - E_cur);
    

    
    
    % New coding for matrix operations
    [dtheta, dr, dz, dslew] = getMove(joyID,'xbox');
    
    % Set a STOP flag to know we need to stop
    % The position we want to move to is the previous position we wanted to
    % be in plus the joystick. If joystick is released then stop
    if (dr == 0) && (dz == 0)
        STOP = true;
    else
        STOP = false;
    end
    
    if STOP == true
        I_des = I_cur;
    else
        I_des = I_des + [dr, dz];
    end
    
    % Calculate the setpoint based on the desired position
    [dtheta1, dtheta2]  = calcAnglesFromPosition(I_des,[0,0]);
    
    % Check to ensure we are still legit
    if (isnan(dtheta1) || isnan(dtheta2))
        I_des = I_cur;
        [dtheta1, dtheta2]  = calcAnglesFromPosition(I_des,[0,0]);
    end
    
    [Cd,Dd,Ed,Fd,Id,Hd,Gd,Jd,Kd,~] = ...
        calcPositionFromAngles(dtheta1,dtheta2,ctheta3);
    setPointBC = norm([.68,-.408] - Cd);
    setPointDE = norm(Dd - Ed);
    
    % Update the PID structures
    boomPID.CV  = curPointBC;
    stickPID.CV = curPointDE;
    
    boomPID.SP  = setPointBC;
    stickPID.SP = setPointDE;
    
    % Calculate the desired ram velocities based on the current index
    % set points.
    if testing == 0
        timerPID    = timerPID + 1;
        timerPIDMax = 1;
        if timerPID > timerPIDMax && STOP == false
            [boomPID, boomRam]   = calcPID ( boomPID );
            [stickPID, stickRam] = calcPID ( stickPID );
            
            timerPID = 0;
        elseif STOP == true
            boomRam  = 0;
            stickRam = 0;
            
            % Reset the integral error
            boomPID.IntE  = 0;
            stickPID.IntE = 0;
        end
    else
        boomRam  = 250 * -dz;
        stickRam = 250 * -dr;
    end
    bucketRam = 200 * dtheta;
    
    
    % Send the ram values over CAN. The slew ram is currently not working.
    % This needs to be fixed later (probably once we have the digger
    % working correctly)!
    %     if ~isnan(boomRam) && ~isnan(stickRam) && ~isnan(bucketRam)
    %         updateRams(canChan,-boomRam,stickRam,bucketRam, dslew);
    %     else
    %         updateRams(canChan,0,0,0, dslew);
    %     end
    
    
    % Turn testing ON/OFF (control the rams normally)
    [a, b] = read(joyID);
    if b(3) == 1
        testing = ~testing;
        while (b(3) == 1)
            [a, b] = read(joyID);
        end
    end
    
    % Record Position?
    if b(1) == 1
        record = ~record;
        xVector = zeros(size(x));
        yVector = zeros(size(x));
        while (b(1) == 1)
            [a, b] = read(joyID);
        end
    end
    
    % Record Position?
    if b(2) == 1
        Lpos = ~Lpos;
        xVector = zeros(size(x));
        yVector = zeros(size(x));
        while (b(2) == 1)
            [a, b] = read(joyID);
        end
    end
    
    % Display useful information in a GUI and on the Command Window
    displayInfo();
    
    % Paced loop for constant cycle time
    F = 20; % Frequency of loop [Hz]
    while toc < (1/F)
        TT = toc;
    end
    TT = toc;
    
    % RANDOM TESTING
    KK = KK + 1;
    if KK > length(x)
        KK = 1;
    end
    
    % Record the bucket tip
    if record
        if Lpos
            xVector ( KK ) = L_cur(1);
            yVector ( KK ) = L_cur(2);
        else
            xVector ( KK ) = I_cur(1);
            yVector ( KK ) = I_cur(2);
        end
    end
    
    boomK   ( KK ) = -boomRam;
    stickK  ( KK ) = stickRam;
    
    % Tracking stuff
    setPointBCVect (KK) = setPointBC;
    setPointDEVect (KK) = setPointDE;
    curPointBCVect (KK) = curPointBC;
    curPointDEVect (KK) = curPointDE;
    
    % Moving bar
    value = -1000;
    if (KK + 10 < length(x))
        boomK   ( KK+1: KK + 10 )        = value;
        stickK  ( KK+1: KK + 10 )        = value;
        setPointBCVect ( KK+1: KK + 10 ) = value;
        setPointDEVect ( KK+1: KK + 10 ) = value;
        curPointBCVect ( KK+1: KK + 10 ) = value;
        curPointDEVect ( KK+1: KK + 10 ) = value;
    end
end


