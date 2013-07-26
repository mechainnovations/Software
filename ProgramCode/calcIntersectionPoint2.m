function [J] = calcIntersectionPoint2(H,K,JK,HJ)
% Calculate the Intersection Ppoint

% Set Point H as origin
K = K - H;

% Rotate one Circle to lie on x-plane.
theta = atan2d(K(2),K(1));
theta = -theta; % reverse direction
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)]; % Rotation Matrix

Irot = R*[K(1),K(2)]';

% Solve for x
d = Irot(1); % Displacement from origin;
x = ( d^2 - JK^2 + HJ^2 ) / ( 2 * d );
y = sqrt( HJ^2 - x^2 );

Frot = [x,y]; % Intersection Point

% Unrotate
theta = -theta;
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)]; % Rotation Matrix

% Final point
J = R*Frot';
J = J'+H;


end
