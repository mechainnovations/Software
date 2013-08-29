% Calculate a given ram extension into angles

Cp1 = calcIntersectionPoint2([0 0],[.68,-.408],curPointBC,2.0132) ;

theta1 = atan2d (Cp1(2),Cp1(1) );
[Cd1, Dd1, ~, Fd1, ~]  = calcPositionFromAngles(theta1, 0,0);

Ep1 = calcIntersectionPoint2(Dd1,Fd1,0.6844,curPointDE) ;

theta2 = atan2d (+Ep1(2) - Fd1(2),+Ep1(1) - Fd1(1) ) - 156.9;
[Cd, Dd, Ed1, Fd, Id]  = calcPositionFromAngles(theta1, theta2,0);

ctheta1 = theta1;
ctheta2 = theta2;