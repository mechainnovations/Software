function [ ram1, ram2, ram3 ] = ramPoints( C, D, E, G, J )
% Get a vector containing all of the points along the boom

ram1(1,:) = [.68, -.408];     % B
ram1(2,:) = C;               % C

ram2(1,:) = D;               % H
ram2(2,:) = E;               % I

ram3(1,:) = G;               % H
ram3(2,:) = J;               % I

end

