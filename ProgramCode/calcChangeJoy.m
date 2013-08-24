function [flagDIR,flagVEL] = calcChangeJoy(dz,dr,prevdz,prevdr)

% Default state is no change
flagDIR = 0;
flagVEL = 0;

% Value term for the joystick difference
valV = 0.01;   % Minimum velocity change
valA = 5;      % Minimum change in angle for path recalculate

% Check to see if the direction has changed using atan2d to see if the
% direction has moved.
angleDif  = abs(atan2d(prevdr,-abs(prevdz)) - atan2d(dr,-abs(dz)));


% Difference in joystick
veloDif = max(abs(dz - prevdz),abs(dr - prevdr));

% Check if the changes are bigger than a set value. This is to ensure small
% fluctuations do not cause random movements.
if veloDif > valV
    flagVEL = 1;
end

if angleDif > valA
    flagDIR = 1;
end

end