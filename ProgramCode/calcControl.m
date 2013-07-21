function [ ramvalue1, ramvalue2 ] = calcControl( dram1, dram2, cram1, cram2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
scale = -75;

dtram1 = dram1 - cram1;
dtram2 = dram2 - cram2;

% ramvalue1 = (dtram1/0.25*150);
% ramvalue2 = (dtram2/0.25*150);

ramvalue1 = 1000 * dtram1/.25;
ramvalue2 = -1000 * dtram2/.25;


if ramvalue1 > 150
    ramvalue1 = 150;
elseif ramvalue1 < -150
    ramvalue1 = -150;
end

if ramvalue2 > 150
    ramvalue2= 150;
elseif ramvalue2 < -150
    ramvalue2 = -150;
end

end

