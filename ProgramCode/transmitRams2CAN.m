function [ success ] = transmitRams2CAN( canChan,ramID, amount, extend )
% Function to transmit the desired value to the specified VM
% Amount 0-250

if nargin ~= 4
    success = 0;
    return;
end

% Check to see if RAM is extending or retracting;
if strcmp(extend, 'true')
    extnd = '1';
else
    extnd = '2';
end

% Get the correct RAM 
switch ramID
    case 'boom'
        id = '0CFE3110';
    case 'stick'
        id = '0cfe3210';
    case 'bucket'
        id = '0cfe3310';
    case 'slew'
        id = '0cfe3410';
end

% 8-byte data string
data      = zeros(8,1);            % Setup the matrix to handle the data
data(1)   = amount;                % Amount to move the RAM by
data(2)   = hex2dec('FF');
data(3)   = hex2dec(['F' extnd]);  % Sent to extend or retract
data(4)   = hex2dec('FF');
data(5)   = hex2dec('FF');
data(6)   = hex2dec('FF');
data(7)   = hex2dec('FF');
data(8)   = hex2dec('FF');
data      = data';                  % Transpose for correct size


% Send the message via CAN
message      = canMessage(hex2dec(id),true,8); % Create a message structure
message.Data = data;                     % Put the data into the structure

% Transmit the message on the correct channel.

transmit(canChan,message)
success = 1;
end

