clc            ;
clear variables;
close all      ;

% Initialisation Functions
initCAN();             % CAN Initilisation
[joyID] = initJOY();   % Joystick Initilisation
initVARS();            % Certain Variables needed within code
initDISP();            % Setup figure handles for the GUI

% Testing Code Set simulator to this value
% ctheta1 = 103;
% ctheta2 = -63.5;
TT    = 0;
index = 1;
N     = 250;

% updateRams(canChan,0,0,0,0);  % Turn the Rams off
% 
% % Setup
getAngles ( );
ctheta1 = boomAngle + 7.9124 + 29.2404;
ctheta2 = stickAngle;
ctheta3 = bucketAngle;
ctheta4 = slewAngle;

[C_cur,D_cur,E_cur,F_cur,I_cur,H_cur,G_cur,J_cur,K_cur,L_cur] = ...
    calcPositionFromAngles(ctheta1,ctheta2,ctheta3);

% Calculate the paths for the rams to follow;
[BCPath, DEPath, pathLength, len] = calcPaths(I_cur, [0, 0]);

% Needed varaibles (put these in init soon)
prevdz = 0;
prevdr = 0;


% RANDOM PLOTTING NONSENSE TO BE TAKEN OUT
KK = 1;
x  = 1 : N*4;
xVector = I_cur(1)*ones(1,length(x));
yVector = I_cur(2)*ones(1,length(x));

boomK    = zeros(1,length(x));
stickK   = zeros(1,length(x));
bucketK  = zeros(1,length(x));
slewK    = zeros(1,length(x));

setPointBCVect = zeros(1,length(x));
setPointDEVect = zeros(1,length(x));
curPointBCVect = zeros(1,length(x));
curPointDEVect = zeros(1,length(x));


hFig = figure(1);
set(hFig, 'Position', [0 0 1024 768])
subplot(1,3,1);
h3 = plot(xVector,yVector,'.b');
subplot(1,3,2)
h1 = plot(x,[boomK', stickK']);
subplot(1,3,3);
h2 = plot(x,[setPointBCVect', setPointDEVect',curPointBCVect', curPointDEVect']);
% END RANDOM PLOTTING STUFF

posxVector = [0 1 -1 0];
posyVector = [0 0 0 0];

PP = 1;
L = 1;
dr = posxVector(L);
dz = posyVector(L);
HH = 5;
testing = 0;

boomGainsExt = [4000 2000 200];
stickGainsExt = [1500 0 300];

boomGainsRet = [4000 2000 300];
stickGainsRet = [1000 1800 200];
% Main Program Loop
record = 0;
dBC = 0;
dDE = 0;
while 1
    % Timing stuff
    tic;
    
%     if testing == 1
%         PP = PP + 1;
%         if PP > 250 && L < length(posxVector)
%             L = L + 1;
%             dr = posxVector(L);
%             dz = posyVector(L);
%             PP = 1;
%         end
%     end
    
    
    % Read angles from CAN
    getAngles(  );
    %ctheta1 = 180+boomAngle + 7.9124 + 29.2404;
    ctheta1 = boomAngle-218.22+360+29.24+7.9124;
    ctheta2 = stickAngle;
    ctheta3 = 180+bucketAngle;
    ctheta4 = slewAngle;
    
   
    % Calculate the current
    [C_cur,D_cur,E_cur,F_cur,I_cur,H_cur,G_cur,J_cur,K_cur,L_cur] = ...
        calcPositionFromAngles(ctheta1,ctheta2,ctheta3);
    curPointBC = norm([0.68 -.408] - C_cur);
    curPointDE = norm(D_cur - E_cur);
    
    % New coding for matrix operations
    [dtheta, dr, dz, dslew] = getMove(joyID,'xbox');
    
    
    % Check for changes in the joystick (only z-r is important)
    [flagDIR,flagVEL] = calcChangeJoy(dz,dr,prevdz,prevdr);
    
    % If the velocity changes interpolate the path to a new path
    if flagVEL
        % Interpt
        % This is still to be determined how to determine the new
        % pathlength and what to interpolate it too
    end
    
    % If direction has changed dramatically then we can update the
    % direction that we are travelling to! (Still at an infinite point
    if flagDIR && ~testing
        % Calculate the paths for the rams to follow;
        [BCPath, DEPath, pathLength, len] = calcPaths(I_cur, [dr, dz]);
        index = 1;
        
        % Reset the static variables
        setPointBC = BCPath(index);
        setPointDE = DEPath(index);
        [boomRam, stickRam, bucketRam] = getPIDRam([setPointBC,setPointDE,ctheta3],...
        [curPointBC,curPointDE,ctheta3+dtheta],[0 0 0],[0 0 0],[200 0 0],1);
    end
    
    if  (dr == 0 && dz == 0)
        BCPath(1) = curPointBC;
        DEPath(1) = curPointDE;
        pathLength = 1;
        index = 1;
    end
    
    % Check to see if index is the end of the path if so we can just keep
    % the setpoint as the final point along the path (the rams will go to
    % zero)
    if index < pathLength
        index = index + 1;
    else
        index = pathLength;
    end
    
    % Set the value of the joysticks to their previous values
    prevdz = dz;
    prevdr = dr;
    
    % Set the desired point to the program index
    setPointBC = BCPath(index);
    setPointDE = DEPath(index);
    
    % Calculate the desired ram velocities based on the current index
    % set points.
    if testing == 0
        HH = HH + 1;
        ll = 10;
        if HH > ll && (dr ~= 0 || dz ~= 0)
            calcRams();
            HH = 0;
        elseif HH > ll
            boomRam = 0;
            stickRam = 0;
            HH = 0;
        end
    else
        boomRam = 250 * -dz;
        stickRam = 250 * -dr;
    end
    bucketRam = 200 * dtheta;
    % Send the ram values over CAN. The slew ram is currently not working.
    % This needs to be fixed later (probably once we have the digger
    % working correctly)!
    if ~isnan(boomRam) && ~isnan(stickRam) && ~isnan(bucketRam)
       updateRams(canChan,-boomRam,stickRam,bucketRam, dslew);
    else
       updateRams(canChan,0,0,0, dslew);
    end
    
    [a, b] = read(joyID);
    if b(3) == 1
        testing = ~testing;
        while (b(3) == 1)
            [a, b] = read(joyID);
        end
    end
    
    if b(1) == 1
        record = ~record;
        xVector = zeros(size(x));
        yVector = zeros(size(x));
        while (b(1) == 1)
            [a, b] = read(joyID);
        end
    end
    
        
    
    % Display useful information in a GUI and on the Command Window
    displayInfo();
    
    % Paced loop for constant cycle time
    F = 50; % Frequency of loop [Hz]
    while toc < (1/F)
        TT = toc;
    end
    TT = toc;
    
    % RANDOM TESTING
    KK = KK + 1;
    if KK > length(x)
        KK = 1;
        boomK    = zeros(1,length(x));
        stickK   = zeros(1,length(x));
        bucketK  = zeros(1,length(x));
        slewK    = zeros(1,length(x));
    end
    
    setPointBCA = BCPath(index);
    setPointDEA = BCPath(index);
    
    if record
        xVector ( KK ) = I_cur(1);
        yVector ( KK ) = I_cur(2);
    end
    
    boomK   ( KK ) = -boomRam;
    stickK  ( KK ) = stickRam;
    bucketK ( KK ) = dslew;
    slewK   ( KK ) = boomRam;
    
    setPointBCVect (KK) = setPointBC;
    setPointDEVect (KK) = setPointDE;
    curPointBCVect (KK) = curPointBC;
    curPointDEVect (KK) = curPointDE;
    
end


