function [ C,D,E,F,I ] = calcPositionFromAngles( theta1, theta2 )
% Calculate the bucket position from the two angles;

% Required Lengths
AD = 2.8421;
AC = 2.0132;
AF = 4.6534;
CD = 0.8922;
CF = 3.0591;
FI = 2.4988;
FE = 0.6844;
EI = 3.1398;

% Required Lengths

% Required Angles
% Alpha1 = angle between AD and AC
alpha1  = acosd((CD^2 - AC^2 - AD^2)/(-2 * AC * AD));

% Alpha10 = angle between AF and AC
alpha2 = acosd((CF^2 - AF^2 - AC^2)/(-2 * AF * AC));

% Alpha7 = angle between FE and EI
alpha3  = acosd((EI^2 - FE^2 - FI^2)/(-2 * FE * FI));

% Calculate All needed Points

% C Point
C(1) = AC*cosd(theta1 - alpha1);
C(2) = AC*sind(theta1 - alpha1);

% D Point
D(1) = AD*cosd(theta1);
D(2) = AD*sind(theta1);

% F Point
F(1) = AF*cosd(theta1 - alpha2 - alpha1);
F(2) = AF*sind(theta1 - alpha2 - alpha1);

% E Point
E(1) = F(1) + FE*cosd(alpha3 + theta2);
E(2) = F(2) + FE*sind(alpha3 + theta2);

% I Point
I(1) = F(1) + FI*cosd(theta2);
I(2) = F(2) + FI*sind(theta2);



end

