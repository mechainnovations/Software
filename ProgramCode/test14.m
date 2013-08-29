% Test 14 - Simplfying the matrices for calculating the points.

syms theta1 theta2; % Two variables for the system to be in terms of;

% Rotation matrices for the two members
A_I1 = [cosd(dtheta1)  0  -sin(theta1)
        0            1  0
        -sind(theta1) 0  cos(theta1) ];

A_I2 = [cos(theta1)  0  -sin(theta1)
        0            1  0
        -sind(theta1) 0  cos(theta1) ];

[ C,D,E,F,I,H,G,J,K,L ] = calcPositionFromAngles(theta1, theta2,0);

% Psi angles needed for rotation into global coords of cylinders
psi1 = atan2(C(2) + .408, C(1) - .68);
psi2 = atan2(E(2) - D(2), E(1) - D(1));

A_IC1 = [cos(psi1)  0  sin(psi1)
         0          1  0
         -sin(psi1) 0  cos(psi1)];
     
A_IC2 = [cos(psi2)  0  sin(psi2)
         0          1  0
         -sin(psi2) 0  cos(psi2)];