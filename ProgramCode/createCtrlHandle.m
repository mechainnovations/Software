function [ ctrlHandle ] = createCtrlHandle( filenameExt,filenameRet, minE, maxE, maxWindUp, offset )
% Create a PID controller Handle

ctrlHandle = struct();

ctrlHandle.kp = 0;
ctrlHandle.kd = 0;
ctrlHandle.ki = 0;

ctrlHandle.prevdedt = 0;

ctrlHandle.Contrib.P = 0; % Proportional Contribution
ctrlHandle.Contrib.I = 0; % Proportional Contribution
ctrlHandle.Contrib.D = 0; % Proportional Contribution
 
ctrlHandle.SP = 0;   % Set Point
ctrlHandle.PSP = 0;   % Previous Set Point
ctrlHandle.CV = 0;   % Current Value

ctrlHandle.PE = 0;   % Previous Error
ctrlHandle.CE = 0;   % Current Error

ctrlHandle.IntE = 0; % Integral summing error
ctrlHandle.PID  = 0; % PID value

ctrlHandle.T      = cputime;   % Previous time the PID was run
ctrlHandle.MIN    = minE;      % Min PID value
ctrlHandle.MAX    = maxE;      % Max return values
ctrlHandle.Windup = maxWindUp; % Integral windup maximum

ctrlHandle.Offset = offset;   % Offset for the PID controller


% Create a matrix that contains all of the for each variable set of gains:
% Extend
% gainsMatrixP = xlsread(filenameExt,'proportional');
% ctrlHandle.xVal = gainsMatrixP(1,2:end);
% ctrlHandle.yVal = gainsMatrixP(2:end,1);
% ctrlHandle.ExtGains.Kp = gainsMatrixP(2:end,2:end);
% 
% gainsMatrixD = xlsread(filenameExt,'derivative');
% ctrlHandle.ExtGains.Kd = gainsMatrixD(2:end,2:end);
% 
% gainsMatrixI = xlsread(filenameExt,'integral');
% ctrlHandle.ExtGains.Ki = gainsMatrixI(2:end,2:end);
% 
% % Extend
% gainsMatrixP = xlsread(filenameRet,'proportional');
% ctrlHandle.xVal = gainsMatrixP(1,2:end);
% ctrlHandle.yVal = gainsMatrixP(2:end,1);
% ctrlHandle.RetGains.Kp = gainsMatrixP(2:end,2:end);
% 
% gainsMatrixD = xlsread(filenameRet,'derivative');
% ctrlHandle.RetGains.Kd = gainsMatrixD(2:end,2:end);
% 
% gainsMatrixI = xlsread(filenameRet,'integral');
% ctrlHandle.RetGains.Ki = gainsMatrixI(2:end,2:end);
