function [ acRam, deRam ] = calcRamExtension( B,C,D,E )
% Calculate the Ram extensions

acRam = norm(B-C);
deRam = norm(D-E);


end

