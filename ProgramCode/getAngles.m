% Reading from the CAN Channel to MATALAB
msg = receive(canChan,Inf);

% CAN identifiers for each of the angle sensors 
boomID   = hex2dec('11600020');
stickID  = hex2dec('11600040');
bucketID = hex2dec('11600080');

% Check to ensure there is a valid message in the can bus
for i = 1:length(msg)   
    if msg(i).ID == boomID
        boomAngle = convertToAngle(msg(i).Data);
    elseif msg(i).ID == stickID
        stickAngle = convertToAngle(msg(i).Data);
    elseif msg(i).ID == bucketID
        bucketAngle = convertToAngle(msg(i).Data);
    end
end





    