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

JJ = 1;


T = 0.5;                      % Seconds to move between points
N = round(T/tCycle);          % Number of steps between A and B
frequency = 1;                % Frequency to accept input [Hz]
maxJJ = round(N/frequency);   % Index at which to up date the predicted path.

updateRams(canChan,0,0,0);    % Turn the Rams off
BCPath = zeros(1,N);          % Initialise path 1
DEPath = BCPath;              % Initialise path 2

BCPath2 = zeros(1,maxJJ);
DEPath2 = BCPath2;


% Intial path
getAngles(  );
ctheta1 = boomAngle + 7.9124 + 29.2404;
ctheta2 = stickAngle;
ctheta3 = bucketAngle;
ctheta4 = slewAngle;

[C_cur,D_cur,E_cur,F_cur,I_cur] = calcPositionFromAngles(ctheta1,ctheta2);
I_des = I_cur;


% Set of all points to pass through between start and end.
matrix = [ linspace(I_cur(1),I_des(1),N)', linspace(I_cur(2),I_des(2),N)'];

% Iterate to get the two tpaths
II = 1;
while II < N+1
    [dtheta1, dtheta2]  = calcAnglesFromPosition([matrix(II,1),matrix(II,2)],[0,0]);
    [Cd, Dd, Ed, Fd, Id]  = calcPositionFromAngles(dtheta1, dtheta2);
    BCPath(II) = norm([.68,-.408] - Cd);
    DEPath(II) = norm(Dd - Ed);
    II = II + 1;
end

x3 = 1:500;
xVector = I_cur(1)*ones(1,length(x3));
yVector = I_cur(2)*ones(1,length(x3));
figure
subplot(1,2,1);
x = 1:N;
h1 = plot(x,BCPath,'g'); hold on;
h2 = plot(x,DEPath,'r');
x2 = 1:maxJJ;
h3 = plot(x2,BCPath2,'k');
h4 = plot(x2,DEPath2,'c');
title('Ram Curves');
subplot(1,2,2);
h5 = plot(x3,xVector,'.b');
% figure;
% x = 1:N;
% plot(x,[BCPath',DEPath']);
% close all;

% Position Index
KK = 1;
% Main Program Loop
while 1
    % Timing stuff
    tic;
    getAngles(  );
    ctheta1 = boomAngle + 7.9124 + 29.2404;
    ctheta2 = stickAngle;
    
    [C_cur,D_cur,E_cur,F_cur,I_cur] = calcPositionFromAngles(ctheta1,ctheta2);
    
    % New coding for matrix operations
    [dtheta, dr, dz] = getMove(joyID,'xbox');
    
    
    if JJ > maxJJ
        JJ = 1;
        I_des = I_cur + [dr, dz];
        
        % Set of all points to pass through between start and end.
        matrix = [ linspace(I_cur(1),I_des(1),N)', linspace(I_cur(2),I_des(2),N)'];
        
        BCPath2 = zeros(1,maxJJ);
        DEPath2 = zeros(1,maxJJ);
        
        % Iterate to get the two tpaths
        II = 1;
        while II < N+1
            [dtheta1, dtheta2]  = calcAnglesFromPosition([matrix(II,1),matrix(II,2)],[0,0]);
            [Cd, Dd, Ed, Fd, Id]  = calcPositionFromAngles(dtheta1, dtheta2);
            BCPath(II) = norm([.68,-.408] - Cd);
            DEPath(II) = norm(Dd - Ed);
            II = II + 1;
        end
    end
    
    
    setPointBC = BCPath(JJ);
    setPointDE = DEPath(JJ);
    curPointBC = norm([0.68 -.408] - C_cur);
    curPointDE = norm(D_cur - E_cur);
    xVector(KK) = I_cur(1);
    yVector(KK) = I_cur(2);
    KK = KK + 1;
    if KK > length(x3)
        KK = 1;
    end
    BCPath2(JJ) = curPointBC;
    DEPath2(JJ) = curPointDE;
    
    [boomRam, stickRam, bucketRam] = getPIDRam([setPointBC,setPointDE,0],...
        [curPointBC,curPointDE,0],[5000 1000 0],[5000 1000 0],[0 0 0]);
    
    JJ = JJ + 1;
    
    updateRams(canChan,-boomRam,stickRam,0, slewRam);
    
    % Display useful information in a GUI and on the Command Window
    displayInfo();
    % Paces loop for constant cycle time
    while toc < tCycle
        TT = toc;
    end
    
end

