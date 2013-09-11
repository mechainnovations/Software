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

[axes1, buttons] = read(joyID); % Read controller inputs

% Xbox Controller
if strcmp(type,'xbox')
    
    % Configurable numbers for different Joystick setups.
    tAxis = 3; maxMoveT = 0.5;
    rAxis = 2; maxMoveR = -0.005;
    zAxis = 5; maxMoveZ = -0.005;
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

