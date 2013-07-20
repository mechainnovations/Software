function [ acRam, deRam ] = calcRamExtension( A,C,D,E )
% Calculate the Ram extensions

acRam = norm(A-C);
deRam = norm(D-E);


end

