function[] = test21()
close all;
clear all;
clc;

directory_name = 'C:\Users\Lance\Documents\GitHub\Software\ProgramCode\data';
files = dir(fullfile(directory_name, '*.mat'));
fileIndex = find(~[files.isdir]);

for i = 1:length(fileIndex)

    fileName = fullfile(directory_name, files(fileIndex(i)).name);
    dataStruct(i) = load(fileName);

end

h1 = figure;
for i = 1:length(fileIndex)
    plot(dataStruct(i).x,dataStruct(i).y,'g')
    axis([0 7.5 -1.5 5]);
    title([dataStruct(i).usercode ' Original = ' num2bool(dataStruct(i).original) '-RAW-'])
    
    name = ['images\' dataStruct(i).usercode '-RAW-' '.png'];
    %saveas(h1,name)
    
    indS = find(dataStruct(i).x > 6.7,1);
    posS = find(dataStruct(i).x(indS:end) < 6,1)+indS;

    indE = find(dataStruct(i).x < 3.5,1);
    plot(dataStruct(i).x(posS:indE),dataStruct(i).y(posS:indE),'g')
    axis([0 7.5 -1.5 5]);
    title([dataStruct(i).usercode ' Original = ' num2bool(dataStruct(i).original)])
    
    name = ['images\' dataStruct(i).usercode '.png'];
    print(h1,'-r300',name)
    
end

close;





end

function[str] = num2bool(input)
    if input == 0
        str = 'False';
    else
        str = 'True';
    end
end
