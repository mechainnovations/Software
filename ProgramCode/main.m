clc;
clear variables;
close all;

% Initialisation Functions
initCAN();             % CAN Initilisation
[joyID] = initJOY();   % Joystick Initilisation
initVARS();            % Certain Variables needed within code
initDISP();            % Setup figure handles for the GUI

% Testing Code Set simulator to this value
% ctheta1 = 103;
% ctheta2 = -63.5;
TT = 0;

JJ = 1;


T = 0.01;                      % Seconds to move between points
N = round(T/tCycle);          % Number of steps between A and B
frequency = 4;                % Frequency to accept input [Hz]
maxJJ = round(N/frequency);   % Index at which to up date the predicted path.

updateRams(canChan,0,0,0,0);  % Turn the Rams off
BCPath = zeros(1,N);          % Initialise path 1
DEPath = BCPath;              % Initialise path 2

BCPath2 = zeros(1,maxJJ);     % Actual Ram Path 1
DEPath2 = BCPath2;            % Actual Ram Path 2

% Intial path
getAngles(  );
ctheta1 = boomAngle + 7.9124 + 29.2404;
ctheta2 = stickAngle;
ctheta3 = bucketAngle;
ctheta4 = slewAngle;

[C_cur,D_cur,E_cur,F_cur,I_cur,H_cur,G_cur,J_cur,K_cur,L_cur] = ...
    calcPositionFromAngles(ctheta1,ctheta2,ctheta3);
I_des = I_cur + [-1 0];

% Generate the surface to be used. Takes some time!
dthe   = -pi/2:0.2:pi/2;
drad   = 2.48:0.2:(4.65+2.48);

dx = drad' * sin(dthe);
dy = drad' * cos(dthe);

[n,m] = size(dx);
I = 1;
J = 1;
while J < n+1
    while I < m+1
        [dtheta1, dtheta2]  = calcAnglesFromPosition([dy(J,I),dx(J,I)],[0,0]);
        [Cd, Dd, Ed, Fd, Id]  = calcPositionFromAngles(dtheta1, dtheta2, 0);
        BC(J,I) = norm([.68,-.408] - Cd);
        DE(J,I) = norm(Dd - Ed);
        I = I + 1;
    end
    I = 1;
    J = J + 1;
end

% Find the point of the desired location

x3 = 1:500;
xVector = I_cur(1)*ones(1,length(x3));
yVector = I_cur(2)*ones(1,length(x3));

boomK    = zeros(1,length(x3));
stickK   = zeros(1,length(x3));
bucketK  = zeros(1,length(x3));
slewK    = zeros(1,length(x3));

setPointBC1 = zeros(1,length(x3));
setPointDE1 = zeros(1,length(x3));
curPointBC1 = zeros(1,length(x3));
curPointDE1 = zeros(1,length(x3));



figure
%subplot(1,4,1);
x = 1:N;
% h1 = plot(x,BCPath,'g'); hold all;
% h2 = plot(x,DEPath,'r');
% x2 = 1:maxJJ;
% h3 = plot(x2,BCPath2,'k');
% h4 = plot(x2,DEPath2,'c');
% title('Ram Curves');
subplot(1,2,1);
h5 = plot(x3,xVector,'.b');
% subplot(1,2,1);
% h6 = plot(x3,[boomK', stickK', bucketK', slewK']);
subplot(1,2,2);
h7 = plot(x3,[setPointBC1', setPointDE1',curPointBC1', curPointDE1']);
%legend('Boom','Stick','Bucket','Slew');
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
    ctheta3 = bucketAngle;
    ctheta4 = slewAngle;
    
    [C_cur,D_cur,E_cur,F_cur,I_cur,H_cur,G_cur,J_cur,K_cur,L_cur] = ...
        calcPositionFromAngles(ctheta1,ctheta2,ctheta3);
    
    % New coding for matrix operations
    [dtheta, dr, dz, dslew] = getMove(joyID,'xbox');
    
    
    if JJ > maxJJ
        JJ = 10;
        I_des = I_cur + [dr, dz];
        
        % Set of all points to pass through between start and end.
        matrix = [ linspace(I_cur(1),I_des(1),N)', linspace(I_cur(2),I_des(2),N)'];
        
        BCPath2 = zeros(1,maxJJ);
        DEPath2 = zeros(1,maxJJ);
        % Iterate to get the two tpaths
        II = 1;
        while II < N+1
            tmp1 = abs(dy - matrix(II,1));
            tmp2 = abs(dx - matrix(II,2));
            
            Atmp = sqrt((tmp1.^2+tmp2.^2));
            
            [value, index] = min(Atmp(:));
            [i,j] = ind2sub(size(Atmp),index);
            
            % Get the Height value
            BCPath(II) = BC(i,j);
            DEPath(II) = DE(i,j);
            
            II = II + 1;
        end
        
        BCPath = smooth(BCPath,115,'moving');
        DEPath = smooth(DEPath,115,'moving');
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
        boomK    = zeros(1,length(x3));
        stickK   = zeros(1,length(x3));
        bucketK  = zeros(1,length(x3));
        slewK    = zeros(1,length(x3));
    end
    BCPath2(JJ) = curPointBC;
    DEPath2(JJ) = curPointDE;
    
    [boomRam, stickRam, bucketRam] = getPIDRam([setPointBC,setPointDE,0],...
        [curPointBC,curPointDE,0],[150 85 0],[150 85 0],[1 0 0]);
    
    JJ = JJ + 1;
    slewRam = dslew;          % Velocity based slew movement
    updateRams(canChan,-boomRam,stickRam,bucketRam, slewRam);
    
    boomK   ( KK ) = bucketRam;
    stickK  ( KK ) = stickRam;
    bucketK ( KK ) = slewRam;
    slewK   ( KK ) = boomRam;
    
    setPointBC1 (KK) = setPointBC;
    setPointDE1 (KK) = setPointDE;
    curPointBC1 (KK) = curPointBC;
    curPointDE1 (KK) = curPointDE;
    
    
    % Display useful information in a GUI and on the Command Window
    displayInfo();
    % Paces loop for constant cycle time
    while toc < 0.01
        TT = toc;
    end
    TT= toc;
    
end


