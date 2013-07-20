function [theta1, theta2] = calcAnglesFromPosition(I)
% Determine the theta1 and theta2 angles from the given I position;
% Required Lengths
AD = 2.8421;
AC = 2.0132;
AF = 4.6534;
CD = 0.8922;
FI = 2.4988;

% Need to get intersection Point F from I.
% Calculate the intersection of the two circles
% Radii of both boom and stick
r1 = AF;
r2 = FI;

% Calculate the intersection of the two circles
dx = I(1);                   % Horiz difference between centres
dy = I(2);                   % Verti difference between centres
sr = r2 + r1;                   % Maximum distance for circs to intersect
dr = r2 - r1;                   % 

d2 = dx^2 + dy^2;               % Square of the distance between centres            
t  = (sr^2 - d2) * (d2 - dr^2); % Check distance between squares is small
t   = sqrt(t)/(2*d2);        
dx0 = -dy * t; dy0 = dx * t;
t   = -dr * sr / d2;
x0  = (I(1) + dx*t)/2;
y0  = (I(2) + dy*t)/2;
x3  = x0 + dx0; 
y3 = y0 + dy0;


F = [x3 y3]; % Solution of F

% Alpha1 is the angle between AC and AD
% Calculated using the Cosine Rule
alpha1 = acosd((CD^2 - AC^2 - AD^2)/(-2 * AC * AD));

% Theta 1
theta1 = atan2d(F(2),F(1)) + alpha1;

% Theta 2
theta2 = atan2d(I(2) - F(2), I(1) - F(1));

%% Test to ensure correct;
figure;
theta1 = theta1 - alpha1;
plot([0 AF*cosd(theta1)],[0 AF*sind(theta1)]); hold on;
plot([AF*cosd(theta1), AF*cosd(theta1)+FI*cosd(theta2)]...
    ,[AF*sind(theta1), AF*sind(theta1)+FI*sind(theta2)]);
plot(I(1),I(2),'sr');





