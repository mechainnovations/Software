% calculate the ram values
dDE = 0;
dBC = 0;

% Calculate the derivative
if (index + 25) < pathLength
    dBC = sign(BCPath(index+25) - setPointBC);
    dDE = sign(DEPath(index+25) - setPointDE);
elseif index > 1
    dBC = sign(BCPath(index) - BCPath(index-1));
    dDE = sign(DEPath(index) - BCPath(index-1));
end
    
% Different PID depending on dBE/dDC
if (dBC) < 0 && (dDE) < 0
    [boomRam, stickRam, b] = getPIDRam([setPointBC,setPointDE,ctheta3],...
        [curPointBC,curPointDE,ctheta3+dtheta],boomGainsRet,stickGainsRet,[200 0 0],0);
end

if (dBC) < 0 && (dDE) >= 0
    [boomRam, stickRam, b] = getPIDRam([setPointBC,setPointDE,ctheta3],...
        [curPointBC,curPointDE,ctheta3+dtheta],boomGainsRet,stickGainsExt,[200 0 0],0);
end

if (dBC) >= 0 && (dDE) < 0
    [boomRam, stickRam, b] = getPIDRam([setPointBC,setPointDE,ctheta3],...
        [curPointBC,curPointDE,ctheta3+dtheta],boomGainsExt,stickGainsRet,[200 0 0],0);
end

if (dBC) >= 0 && (dDE) >= 0
    [boomRam, stickRam, b] = getPIDRam([setPointBC,setPointDE,ctheta3],...
        [curPointBC,curPointDE,ctheta3+dtheta],boomGainsExt,stickGainsExt,[200 0 0],0);
end
   