function [ ] = updateRams( canChan, boomRam, stickRam, bucketRam )
% Update the RAM Velocities from the outputs of P(I)D Controller

% Note: The extend retrat may be incorrect. Recommend checking this in the
% simulator first. - LH 17/7/2013


% Boom Ram:
%    >=0 : Extend the Ram
%    < 0 : Retract the Ram
if boomRam >= 0
    transmitRams2CAN(canChan,'boom',floor(boomRam),'true');
else
    transmitRams2CAN(canChan,'boom',floor(abs(boomRam)),'false'); 
end

% Stick Ram:
%    >=0 : Extend the Ram
%    < 0 : Retract the Ram
if stickRam >= 0
    transmitRams2CAN(canChan,'stick',floor(stickRam),'true');
else
    transmitRams2CAN(canChan,'stick',floor(abs(stickRam)),'false'); 
end

% Bucket Ram:
%    >=0 : Extend the Ram
%    < 0 : Retract the Ram
if bucketRam >= 0
    transmitRams2CAN(canChan,'bucket',floor(bucketRam),'true');
else
    transmitRams2CAN(canChan,'bucket',floor(abs(bucketRam)),'false'); 
end


end

