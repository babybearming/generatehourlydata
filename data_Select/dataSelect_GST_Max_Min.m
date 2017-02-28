%%
%该程序用来提取全国台站中指定站号的数据（地温日值数据）
%%
clc;clear;
%var initialization
selectStationId=54527
inputFilePath='..\..\originalData\SURF_CLI_CHN_MUL_DAY-dvd-8\datasets\GST\';
inputFileNameHead='SURF_CLI_CHN_MUL_DAY-GST-12030-0cm-';
outputFilePath='..\..\stationsData\GST_DAY_MAX_MIN\';
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