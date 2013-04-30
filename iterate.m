% iterate angle colution
pi = 3.1416  ;

A  = 6       ;
B  = 10      ;
C  = 1.0472 ;
D  = 7.91       ;


i  = 0;
x0 = 1;
xn = x0;
phi = zeros(1000);
for i = 1:1000
    xp = xn;
    xn = acos(A/B*cos(C - xp) + D/B);
    phi(i) = xn;
end

plot(phi,'-r')
xn