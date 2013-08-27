function [ ctrlHandle ] = createCtrlHandle( k_p, k_d, k_i, maxE, maxWindUp, offset )
% Create a PID controller Handle

ctrlHandle = struct();

ctrlHandle.Contrib.P = 0; % Proportional Contribution
ctrlHandle.Contrib.I = 0; % Proportional Contribution
ctrlHandle.Contrib.D = 0; % Proportional Contribution
 
ctrlHandle.SP = 0;   % Set Point
ctrlHandle.CV = 0;   % Current Value

ctrlHandle.PE = 0;   % Previous Error
ctrlHandle.CE = 0;   % Current Error

ctrlHandle.IntE = 0; % Integral summing error
ctrlHandle.PID  = 0; % PID value

ctrlHandle.T      = cputime;   % Previous time the PID was run
ctrlHandle.MAX    = maxE;      % Max return values
ctrlHandle.Windup = maxWindUp; % Integral windup maximum

ctrlHandle.Offset = offset;   % Offset for the PID controller


% Create a matrix that contains all of the for each variable set of gains:
ctrlHandle.res  =  0.1;
ctrlHandle.xVal =  2:ctrlHandle.res:8;
ctrlHandle.yVal = -1:ctrlHandle.res:4;

% Setup the matrix with gains (for now constant gains)
% Proportional
for x = 1:length(ctrlHandle.xVal)
    for y = 1:length(ctrlHandle.yVal)
        ctrlHandle.Gains.Kp(y,x) = k_p;
    end
end

% Derivative
for x = 1:length(ctrlHandle.xVal)
    for y = 1:length(ctrlHandle.yVal)
        ctrlHandle.Gains.Kd(y,x) = k_d;
    end
end

% Integral
for x = 1:length(ctrlHandle.xVal)
    for y = 1:length(ctrlHandle.yVal)
        ctrlHandle.Gains.Ki(y,x) = k_i;
    end
end

end

