% Tetsing the maximum dispalcement
clear
clc
close all
diff = .05;
res  = diff*2;


ctheta1 = 103;
ctheta2 = -63;
[C, D, E, F, I0]  = calcPositionFromAngles(ctheta1, ctheta2);
i = 1;
j = 1;
for dr = -diff:res:diff
    for dz = -diff:.001:diff
        
        [dtheta1, dtheta2]  = calcAnglesFromPosition(I0,[dr dz]);
        [Cd, Dd, Ed, Fd, Id]  = calcPositionFromAngles(dtheta1, dtheta2);
        BC(i) = norm([.68,-.408] - Cd) - norm([.68,-.408] - C);
        DE(i) = norm(Dd - Ed)-norm(D - E);
        i = i + 1;
    end
    j = j + 1;
end

figure;
plot(BC,'c'); hold on
plot(DE,'r'); hold off
        