function [theta1, theta2] = calcAnglesFromPosition(I, dI)
% This function will find the theta1 and theta2  from a given I and an
% intial movement. Also limits the angle so that the boom will not break.
theta1 = NaN;
theta2 = NaN;
% Contains error checking to help keep consistency


% Required Lengths
AD = 2.8421;
AC = 2.0132;
AF = 4.6534;
CD = 0.8922;
CF = 3.0591;
FI = 2.4988;
FE = 0.6844;
EI = 3.1398;

% Need to get intersection Point F from I.
% Calculate the intersection of the two circles
% Radii of both boom and stick
r1 = AF;
r2 = FI;

% New I = I+dI
I_des = I + dI;

% Calculate the intersection of the two circles
dx = I_des(1);                  % Horiz difference between centres
dy = I_des(2);                  % Verti difference between centres
sr = r2 + r1;                   % Maximum centre distance
dr = r2 - r1;                   % Minimum centre distance
d2 = dx^2 + dy^2;               % Square of the distance between centres            
t  = (sr^2 - d2) * (d2 - dr^2); % Error check to ensure solution exists;



% Alpha1 is the angle between AC and AD
% Calculated using the Cosine Rule
alpha1 = acosd((CD^2 - AC^2 - AD^2)/(-2 * AC * AD));
alpha2 = acosd((CF^2 - AF^2 - AC^2)/(-2 * AF * AC));

% If intersection occurs then return angle to this point if not to the
% current I point;
if t > 0
    % Get the intersection point
    F = calcIntersectionPoint( I_des );
    % Theta 1
    theta1 = atan2d(F(2),F(1)) + alpha2;
    % Theta 2
    theta2 = atan2d(I_des(2) - F(2), I_des(1) - F(1));
    
%     [tC,tD,tE,tF,tI] = calcPositionFromAngles(theta1, theta2);
%     DE = norm(tE - tD);
%     BC = norm([0.68 -0.408] - tC);

end

if t <= 0 
    % Get the intersection point
    F = calcIntersectionPoint( I );
    
    if imag(F) == 0
        % Theta 1
        theta1 = atan2d(F(2),F(1)) + alpha2;
        % Theta 2
        theta2 = atan2d(I(2) - F(2), I(1) - F(1));
    else
        theta1 = NaN;
        theta2 = NaN;
    end
end

% Boom
if theta1 > 115
    theta1 = NaN;
elseif theta1 < -10
    theta1 = NaN;
end

% Stick
if theta2 > -5
    theta2 = NaN;
elseif theta2 < -150
    theta2 = NaN;
end



end




