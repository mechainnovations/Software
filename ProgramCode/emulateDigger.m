function [ output_args ] = emulateDigger( input_args )
% This function is to be used while testing without the simulator. While it
% will not give a true and accurate reflection of what the digger will do
% under certain conditions, it does provide a simple method to check
% fundamental principle of the code.

% Some needed static variables.

persistent pu1;
persistent pu2;

if isempty(pu1)
    pu1 = [0 0];
    pu2 = [0 0];
end

% First RAM
ddu1  = zeros(1,length(finalBC));
du1   = zeros(1,length(finalBC));
u1    = zeros(1,length(finalBC));
u1(:) = finalBC(1);
sp1   = finalBC;

% Second RAM
ddu2  = zeros(1,length(finalDE));
du2   = zeros(1,length(finalDE));
u2    = zeros(1,length(finalDE));
u2(:) = finalDE(1);
sp2   = finalDE;

% Control Parameters
P1  = 5;
D1  = 10;
I1  = 0.5;

P2  = P1;
D2  = D1;
I2  = I1;

N  = length(sp1);

% Now simulate the digger simulation
for III = 3:N
    
    ddu1(III) = P1*(sp1(III - 1) - u1(III - 1))-D1*(u1(III-1) - u1(III-2))...
        + I1*sum( sp1(1:III-1) - u1(1:III-1) );
    du1 (III) = du1(III - 1)  + ddu1(III)  * dt; % v = a*t
    u1  (III) = u1 (III - 1)  + du1 (III) * dt;  % u = v*t
    
    ddu2(III) = P2*(sp2(III - 1) - u2(III - 1))-D2*(u2(III-1) - u2(III-2))...
        + I2*sum( sp2(1:III-1) - u2(1:III-1) );
    du2 (III) = du2(III - 1)  + ddu2(III)  * dt; % v = a*t
    u2  (III) = u2 (III - 1)  + du2 (III)  * dt;  % u = v*t
    
end

end

