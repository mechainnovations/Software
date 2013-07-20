clc;
clear;
close all;

% Matlab Solving Intersection Equation
I = [4 5];
AF = 3;
FI = 4;
% Rotate one Circle to lie on x-plane.
theta = atan2d(I(2),I(1));
theta = -theta; % reverse direction
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)]; % Rotation Matrix

Irot = R*[I(1),I(2)]';

% Solve for x
d = Irot(1); % Displacement from origin;
x = ( d^2 - FI^2 + AF^2 ) / ( 2 * d );
y = sqrt( AF^2 - x^2 );

Frot = [x,y]; % Intersection Point

% Unrotate
theta = -theta;
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)]; % Rotation Matrix

% Final point
F = R*Frot';
