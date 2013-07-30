% Plot points for digger to reach
clc;
clear variables;
close all;

%Initialise Functions
initVARS();
initDISP();
joyID = initJOY();

% Points to be located
pt = [5,0; 4,0; 4,-2; 5.5,-1; 3,-1; 2,1; 6,1; 5,-2; 4,-3; 3,0; ...
    5,0; 4,0; 4,-2; 5.5,-1; 3,-1; 2,1; 6,1; 5,-2; 4,-3; 3,0];
I_cur = [4,0];
L_cur = [0,0];

for i = 1:20
    
    % Point to find (ith set of points)
    find_pt = [pt(i,1), pt(i,2)];
    
    tic;
    
    while norm(L_cur - find_pt) > 0.1
        % Timing stuff
        [c a b] = getMove(joyID,'xbox');
        
        [ctheta1, ctheta2] = calcAnglesFromPosition(I_cur, [a,b]);
        ctheta3 = ctheta3 + c;
        
        % Check angles
        [flag_b,flag_s,flag_bk] = Limit_Angles(ctheta1,ctheta2,ctheta3);
        
        % Check if any of the flags are on
        flag = 0;
        
        if flag_b == 1;
            flag = 1;
        end
        if flag_s == 1;
            flag = 1;
        end
        if flag_bk == 1;
            flag = 1;
        end
                
        if flag == 0         % angles are fine
            % Calculate the Current C,D,E,F,I,H,G,J,K,L
            [C_cur,D_cur,E_cur,F_cur,I_cur,H_cur,G_cur,J_cur,K_cur,L_cur] = ...
                calcPositionFromAngles(ctheta1,ctheta2,ctheta3);
            points = bucketPoints(ctheta3,(I_cur+K_cur)/2);
            L_cur = points(4,:);
        end
        
        % Paces loop for constant cycle time
        if flag_bk == 1
            ctheta3 = ctheta3 - c;
        end
        displayInfo();
        
    end
    
    T(i) = toc;
    
end
