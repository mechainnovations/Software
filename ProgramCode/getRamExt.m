function [CB_new, CB, DE_new, DE] = getRamExt ( dTheta, dr, dZ, I)
% Calculate the needed RAM extensions for the new position

% Current Bucket Position
[theta1, theta2, I, F, E, D, CB, DE] = Bucket_Position(0, 0, 0, I);

% New Bucket Position
[theta1_new, theta2_new, I_new, F_new, E_new, D_new, CB_new, DE_new]...
    = Bucket_Position(dr, dZ, dTheta, I);

% Sanity Check to ensure we can move to the correct location.
if imag(CB_new) ~= 0
    CB_new = CB;
end

if imag(DE_new) ~= 0
    DE_new = DE;
end



end
