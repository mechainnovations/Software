function [flag_b,flag_s,flag_bk] = Limit_Angles( ctheta1,ctheta2,ctheta3 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% if flag is 1 there is an overextended angle
flag_b = 0;
flag_s = 0;
flag_bk = 0;

%Limit angles for theta 1
if ctheta1 < 20
    flag_b = 1;
end

if ctheta1 > 105
    flag_b = 1;
end

% Theta 2
if ctheta2 > -45
    flag_s = 1;
end

if ctheta2 < -90
    flag_s = 1;
end

% Theta 3
% Angle from KI to FI clockwise
KIF = 180 - ctheta2 + ctheta3;

if KIF > 315
    flag_bk = 1;
end

if KIF < 140
    flag_bk = 1;
end

end

