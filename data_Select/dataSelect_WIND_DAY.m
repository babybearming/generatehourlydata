%%
%该程序用来提取全国台站中指定站号的数据
%%
clc;clear;
%var initialization
selectStationId=58367
inputFilePath='..\..\originalData\SURF_CLI_CHN_MUL_DAY-dvd-6\datasets\WIN\';
inputFileNameHead='SURF_CLI_CHN_MUL_DAY-WIN-11002-';
outputFilePath='..\..\stationsData\WIND_DAY\';
if exist(outputFilePath,'dir')==0
  mkdir(outputFilePath);
end
outputFileName=[outputFilePath num2str(selectStationId) '.txt'];
startYear=1951;
endYear=2012;
startMonth=1;
endMonth=12;

%read the txt file
for y=startYear:endYear
    y
    for m=startMonth:endMonth
        m
        if m<10
            m2str=[num2str(0) num2str(m)];
            inputFileName=[inputFilePath inputFileNameHead num2str(y) m2str '.txt'];
        else
            inputFileName=[inputFilePath inputFileNameHead num2str(y) num2str(m) '.txt'];
        end
     data=dlmread(inputFileName);
     selectData=data(data(:,1)==selectStationId,:);
     dlmwrite(outputFileName,selectData,'delimiter',' ','-append','newline','pc');
    end
end