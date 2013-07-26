function [ theta, radius, zheight, slew ] = getMove( joyID, type )
% Calculate the step change due to joystick
persistent prevStep; % Differentiator for mouse pro
dt = 0.01;

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

[axes, buttons] = read(joyID); % Read controller inputs

% Xbox Controller
if strcmp(type,'xbox')
    
    % Configurable numbers for different Joystick setups.
    tAxis = 4; maxMoveT = 0.5;
    rAxis = 2; maxMoveR = 1;
    zAxis = 5; maxMoveZ = -1;
    slewAxis = 3; maxMoveSlew = 250;

    % Calculate the New Steps
    if abs(axes(tAxis)) > val
        theta   = axes(tAxis) * maxMoveT;
    end
    
    if abs(axes(rAxis)) > val
        radius  = axes(rAxis) * maxMoveR;
    end
    
    if abs(axes(zAxis)) > val
        zheight = axes(zAxis) * maxMoveZ;
    end
    
    if abs(axes(slewAxis)) > val
        slew = axes(slewAxis) * maxMoveSlew;
    end
end

% SpaceMousePro requires a differentiator to find the -1 -> 1 value
if strcmp(type,'spacemouse')
    % Configurable numbers for different Joystick setups.
    tAxis = 1; maxMoveT = 0.5;
    rAxis = 2; maxMoveR = 0.5;
    zAxis = 3; maxMoveZ = -0.5;
    
    % Differentiate to get the velocity
    axes = ( axes - prevStep ) / dt;
    
    % Limit the values between -1 and 1;
    for i = 1:length(axes)
        if (axes(i) < -1)
            axes(i) = -1;
        elseif axes(i) > 1
            axes(i) = 1;
        end
    end
        

    % Calculate the New Steps
    theta   = axes(tAxis) * maxMoveT;
    radius  = axes(rAxis) * maxMoveR;
    zheight = axes(zAxis) * maxMoveZ;


end

