function [ theta, radius, zheight, slew, Lpos, record, testing ] = getMove( joyID, Lpos, record, testing, type )
% Calculate the step change due to joystick
persistent prevStep; % Differentiator for mouse pro
dt = 1;

% Clear thepersistent variable
if isempty(prevStep)
    prevStep = zeros(1, 6 );
end

% New Points
theta   = 0;
radius  = 0;
zheight = 0;
slew = 0;

% Value axis must be above to move.
val = 0.15;

if length(joyID) <= 1
    [axes1, buttons] = read(joyID(1)); % Read controller inputs
else
    [axes1, buttons1] = read(joyID(1));
    [axes2, buttons2] = read(joyID(2));
end
    

if strcmp(type,'original')
    % Configurable numbers for different Joystick setups.
    boAxis = 2; maxMoveBo = 0.5;
    buAxis = 1; maxMoveBu = -0.5;
    stAxis = 2; maxMoveSt = -0.5;
    %slewAxis = 3; maxMoveSlew = 250;
    % Calculate the New Steps
    if abs(axes2(buAxis)) > val
        theta   = axes2(buAxis) * maxMoveBu;
    end
    
    if abs(axes2(boAxis)) > val
        zheight  = axes2(boAxis) * maxMoveBo;
    end
    
    tmp = axes1(stAxis)+0.5;
    if abs(tmp) > val
        radius = (tmp) * maxMoveSt;
    end
end

% Xbox Controller
if strcmp(type,'xbox')
    
    % Configurable numbers for different Joystick setups.
    tAxis = 3; maxMoveT = 0.5;
    rAxis = 2; maxMoveR = -0.004;
    zAxis = 5; maxMoveZ = -0.004;
    %slewAxis = 3; maxMoveSlew = 250;

    % Calculate the New Steps
    if abs(axes1(tAxis)) > val
        theta   = axes1(tAxis) * maxMoveT;
    end
    
    if abs(axes1(rAxis)) > val
        radius  = axes1(rAxis) * maxMoveR;
    end
    
    if abs(axes1(zAxis)) > val
        zheight = axes1(zAxis) * maxMoveZ;
    end
    
%     if abs(axes(slewAxis)) > val
%         slew = axes(slewAxis) * maxMoveSlew;
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
        while (b(1) == 1)
            [a, b] = read(joyID);
        end
    end
    
    % Record Position?
    if b(2) == 1
        Lpos = ~Lpos;
        while (b(2) == 1)
            [a, b] = read(joyID);
        end
    end
end

% SpaceMousePro requires a differentiator to find the -1 -> 1 value
if strcmp(type,'spacemouse')
    % Configurable numbers for different Joystick setups.
    tAxis = 6; maxMoveT = 0.5;
    rAxis = 2; maxMoveR = -0.005;
    zAxis = 3; maxMoveZ = -0.005;
    
    % Differentiate to get the velocity
    axesR = ( axes1 - prevStep ) / 0.05;
    prevStep = axes1;
    
    % Limit the values between -1 and 1;
    for i = 1:length(axesR)
        if (axesR(i) < -1)
            axesR(i) = -1;
        elseif axesR(i) > 1
            axesR(i) = 1;
        end
    end
    
    % Limit the values between -1 and 1;
    for i = 1:length(axesR)
        if (abs(axesR(i)) < 0.15)
            axesR(i) = 0;
        end
    end
        

    % Calculate the New Steps
    theta   = axesR(tAxis) * maxMoveT;
    radius  = axesR(rAxis) * maxMoveR;
    zheight = axesR(zAxis) * maxMoveZ;

end

