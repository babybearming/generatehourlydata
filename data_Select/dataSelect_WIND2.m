%%
%�ó���������ȡȫ��̨վ��ָ��վ�ŵ�����
%%
clc;clear;
%var initialization
selectStationId=54517
inputFilePath='..\..\originalData\SURF_CLI_CHN_MUL_FTM_H4-dvd-5\datasets\WIN\';
inputFileNameHead='SURF_CLI_CHN_MUL_FTM_H4-WIN-11002-';
outputFilePath=['..\..\stationsData\WIN\' ];
if exist(outputFilePath,'dir')==0
  mkdir(outputFilePath);
end
outputFileName=[outputFilePath num2str(selectStationId) '.txt'];
startYear=1986;
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