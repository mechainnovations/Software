function [ theta, radius, zheight ] = getMove( joyID, type )
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

% Value axis must be above to move.
val = 0.15;

[axes1, buttons] = read(joyID); % Read controller inputs

% Xbox Controller
if strcmp(type,'xbox')
    
    % Configurable numbers for different Joystick setups.
    tAxis = 3; maxMoveT = 5;
    rAxis = 2; maxMoveR = -0.1;
    zAxis = 5; maxMoveZ = -0.1;

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
end

% SpaceMousePro requires a differentiator to find the -1 -> 1 value
if strcmp(type,'spacemouse')
    % Configurable numbers for different Joystick setups.
    tAxis = 4; maxMoveT = -2;
    rAxis = 2; maxMoveR = -0.1;
    zAxis = 3; maxMoveZ = -0.1;
    
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

    clc;
    for i = 1:length(axesR)
        disp(['Axes ' num2str(i) ': ' num2str(axesR(i))]);
    end
 
end

