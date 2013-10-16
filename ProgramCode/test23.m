% Data stripping
close all;
clear all;
clc;

directory_name = 'C:\Users\Lance\Documents\GitHub\Software\ProgramCode\data';
files = dir(fullfile(directory_name, '*.mat'));
fileIndex = find(~[files.isdir]);
data = zeros(length(fileIndex),7);
for i = 1:length(fileIndex)

    fileName = fullfile(directory_name, files(fileIndex(i)).name);
    dataStruct(i) = load(fileName);

end
xx = 12;
yy = 13;
h1 = figure;
NN = 1;
OO = 1;
for i = 1:length(fileIndex)
    
    
    indS = find(dataStruct(i).x > 6.7,1);       
    posS = find(dataStruct(i).x(indS:end) < 6,1)+indS; %xposition at start
    indE = find(dataStruct(i).x < 3.5,1); %xpostion at end
    temp = dataStruct(i).y(posS:indE); %height values from start to finish
    time(i) = dataStruct(i).t(indE) - dataStruct(i).t(posS); %Time values
    

    ydata(i,1:length(temp)) = temp';
    xdata(i,1:length(temp)) = (dataStruct(i).x(posS:indE))';
    
    temp = dataStruct(i).t(posS:indE);
    tdata(i,1:length(temp)) = temp;
    
    if dataStruct(i).original == 0
        NabsAvg(NN) = mean(abs(ydata(i,:)));
        
        standardN(NN) = std(ydata(i,:));
        averageN(NN) = mean(ydata(i,:));
        NN = NN + 1;
    else
        OabsAvg(OO) = mean(abs(ydata(i,:)));
        
        standardO(OO) = std(ydata(i,:));
        averageO(OO) = mean(ydata(i,:));
        OO = OO + 1;
    end
    usercode = dataStruct(i).usercode;
    data(i,1) = 10 * (str2double(usercode(6))) + str2double(usercode(7));  %ID num
    data(i,2) = str2double(usercode(5));            % Group number (1-2)
    data(i,3) = usercode(3) == 'M';                 % 1 = male, 0 = female
    data(i,4) = dataStruct(i).original;             % 1 = original, 0 = xbox
    data(i,5) = mean(abs(temp));                    % Average absoltute y position
    data(i,6) = std(temp);                          % Standard deviation absoltute y position
    data(i,7) = time(i);                            % Average Time
    
    
end
close;


[hAV, pAV] = kstest2(averageN,averageO);
[hSD, pSD] = kstest2(standardN,standardO);
hAV
[hK, pK] = kstest2(NabsAvg,OabsAvg);
[pR, hR] = ranksum(NabsAvg,OabsAvg);
disp('---------------- MEAN OF Y HEIGHT KS-TEST -------------');
if hAV == 0
    disp('Do not reject null hypothesis that they are from the same population');
    disp('NO statistical difference.');
else
    disp('REJECT null hypothesis that they are from the same population');
    disp('Statistical difference.');
end

disp('---------------- STANDARD DEVIATION OF Y HEIGHT KS-TEST -------------');
if hSD == 0
    disp('Do not reject null hypothesis that they are from the same population');
    disp('NO statistical difference.');
else
    disp('REJECT null hypothesis that they are from the same population');
    disp('Statistical difference.');
end

[pAV, hAV] = ranksum(averageN,averageO);
[pSD, hSD] = ranksum(standardN,standardO);
disp('---------------- MEAN OF Y HEIGHT RANK-SUM -------------');
if hAV == 0
    disp('Do not reject null hypothesis that they are from the same population');
    disp('NO statistical difference.');
else
    disp('REJECT null hypothesis that they are from the same population');
    disp('Statistical difference.');
end

disp('---------------- STANDARD DEVIATION OF Y HEIGHT RANK-SUM -------------');
if hSD == 0
    disp('Do not reject null hypothesis that they are from the same population');
    disp('NO statistical difference.');
else
    disp('REJECT null hypothesis that they are from the same population');
    disp('Statistical difference.');
end

%[F1,XI1] = ksdensity(averageN);
%[F2,XI2] = ksdensity(averageO);
[F1,XI1] = ksdensity(NabsAvg);
[F2,XI2] = ksdensity(OabsAvg);
figure;
plot(XI1,F1,'r',XI2,F2,'g');
title('PDF - Means');
legend('New','Original');

[F1,XI1] = ksdensity(standardN);
[F2,XI2] = ksdensity(standardO);
figure;
plot(XI1,F1,'r',XI2,F2,'g');
title('PDF - Standard Deviations');
legend('New','Original');

[x1 y1] = ecdf(standardN);
[x2 y2] = ecdf(standardO);
figure;
plot(x1,y1/max(y1),'g',x2,y2/max(y2),'r')
legend('New','Old');
title('CDF of Standard Deviations');

%% FFT OF DATA set 1 and 2
T = 0.05;
Fs = 1/T;
N = 1;
O = 1;

figure;
hold on;
for i = 1:2
    y1 = ydata(i,:)-mean(ydata(i,:));
    L1 = length(y1);
    NFFT1 = 2^nextpow2(L1); % Next power of 2 from length of y
    Y1 = fft(y1,NFFT1)/L1;
    f1 = Fs/2*linspace(0,1,NFFT1/2+1);
    if dataStruct(i).original == 0
        freqN(N,:) = f1;
        YN(N,:) = Y1;
        subplot(1,2,1)
        plot(freqN(N,:),2*abs(YN(N,1:NFFT1/2+1)),'g'); hold on;
        xlim([-.1 1])
        ylim([0 0.08])
        N = N + 1;
    else
        freqO(O,:) = f1;
        YO(O,:) = Y1;
        subplot(1,2,2)
        plot(freqO(O,:),2*abs(YO(O,1:NFFT1/2+1)),'r'); hold on;
        xlim([-0.1 1])
        ylim([0 0.08])
        O = O + 1;
    end
    drawnow;
end
hold off
title('FFT of the two signal groups')
