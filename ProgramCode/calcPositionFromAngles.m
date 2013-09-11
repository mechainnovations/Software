function [ C,D,E,F,I,H,G,J,K,L ] = calcPositionFromAngles( theta1, theta2, theta3 )
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
KI = 0.4014;
HI = 0.3739;
IL = 0.95; 
JK = 0.5144;
EG = 0.9568;
HJ = 0.5457;
IG = 2.2490;
FG = 0.5667;

% Required Lengths

% Required Angles
% Alpha1 = angle between AD and AC
alpha1  = acosd((CD^2 - AC^2 - AD^2)/(-2 * AC * AD));

% Alpha10 = angle between AF and AC
alpha2 = acosd((CF^2 - AF^2 - AC^2)/(-2 * AF * AC));

% Alpha7 = angle between FE and EI
alpha3  = acosd((EI^2 - FE^2 - FI^2)/(-2 * FE * FI));

% Alpha4 = angle between IE and EG
alpha4  = acosd((IG^2 - FG^2 - FI^2)/(-2 * FI * FG));


% Calculate All needed Points

% C Point
C(1) = AC*cosd(theta1);
C(2) = AC*sind(theta1);

% D Point
D(1) = AD*cosd(theta1-alpha1);
D(2) = AD*sind(theta1-alpha1);

% F Point
F(1) = AF*cosd(theta1 - alpha2);
F(2) = AF*sind(theta1 - alpha2);

% E Point
E(1) = F(1) + FE*cosd(alpha3 + theta2);
E(2) = F(2) + FE*sind(alpha3 + theta2);

% I Point
I(1) = F(1) + FI*cosd(theta2);
I(2) = F(2) + FI*sind(theta2);

% G Point
G(1) = F(1) + FG*cosd(alpha4 + theta2);
G(2) = F(2) + FG*sind(alpha4 + theta2);

% H Point
H(1) = I(1) - HI*cosd(theta2);
H(2) = I(2) - HI*sind(theta2);

% K Point
K(1) = I(1) + KI*cosd(theta3);
K(2) = I(2) + KI*sind(theta3);

% L Point
L(1) = I(1) + IL*cosd(theta3 - 75);
L(2) = I(2) + IL*sind(theta3 - 75);

% J Point
J = calcIntersectionPoint2(H,K,JK,HJ);

end