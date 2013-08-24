function [ BCPath, DEPath, pathLength, N ] = calcPaths( I_cur, dI )
% Calculate the needed path for the ram extensions to go through in order
% to get from point A -> B.

scaling = norm(dI);

N   = 100*floor(1 / scaling);  % Number of points to create along the path

if N > 150
    N = 150;
elseif N < 3
    N = 3;
end
BC2 = zeros(1,N); % BC Ram path
DE2 = zeros(1,N); % DE Ram path
TTT = 10;

% Adding some dead time
[dtheta10, dtheta20]  = calcAnglesFromPosition(I_cur,[0,0]);
[Cd0, Dd0, Ed0, ~, ~]  = calcPositionFromAngles(dtheta10, dtheta20, 0);
BC20 = norm([.68,-.408] - Cd0);
DE20 = norm(Dd0 - Ed0);
% Level the initial section of path
BC2(1:TTT) = BC20;
DE2(1:TTT) = DE20;

% Find the direction vector of where to go, a long
% direction in terms of r-z so outside the possible range. This
% gives a position to 'aim' for.
I_des = I_cur + dI*7.5;

N2 = 1000;


% Set of all points to pass through between start and end.
matrix = [ linspace(I_cur(1),I_des(1),N2)', linspace(I_cur(2),I_des(2),N2)'];

ang       = atan2d(dI(2),dI(1));
dx        = 2*cosd(ang);
dy        = 2*sind(ang);
mat2      = [ linspace(I_cur(1),(I_cur(1) + dx),N2)', linspace(I_cur(2),(I_cur(2) + dy),N2)'];

matrix = mat2;


% Iterate to get the two paths that the boom and stick must follow.
% It will be important in the future to add the third path in
% regards to the bucket to ensure stable level. However, it will
% currently just track the bucket angle.
II = TTT+1;
while II < N2+1
    [dtheta1, dtheta2]  = calcAnglesFromPosition([matrix(II-TTT,1),matrix(II-TTT,2)],[0,0]);
    [Cd, Dd, Ed, ~, ~]  = calcPositionFromAngles(dtheta1, dtheta2,0);
    BC2(II) = norm([.68,-.408] - Cd);
    DE2(II) = norm(Dd - Ed);
    
    II = II + 1;
end



% Truncate the vectors so there are no NaN along our path. Is smart
% to do because if the bucket could not have got to the desired
% position then the above functions return NaN.
[a, b] = find(isnan(BC2),1);
if isempty(a) == 1
    temp1 = BC2(1:end);
    temp2 = DE2(1:end);
else
    if b > 1
        temp1 = BC2(1:b-1);
        temp2 = DE2(1:b-1);
    else
        temp1 = BC2(1);
        temp2 = DE2(1);
    end
end

[a, b] = find(isnan(temp2),1);
if isempty(a) == 1
    BCPath = temp1(1:end);
    DEPath = temp2(1:end);
else
    if b > 1
        BCPath = temp1(1:b-1);
        DEPath = temp2(1:b-1);
    else
        BCPath = temp1(1);
        DEPath = temp2(1);
    end
end


% N = 500;
% if length(BCPath) > N
%     factor = floor(length(BCPath)/N);
%     BCPath = decimate(BCPath,factor);
%     DEPath = decimate(DEPath,factor);
% elseif length(BCPath) < N && length(BCPath) > 3
%     factor = floor(length(BCPath)/N);
%     BCPath = interp(BCPath,factor);
%     DEPath = interp(DEPath,factor);
% end

pathLength = length(BCPath); % Get the path length ie how long it will take




end

