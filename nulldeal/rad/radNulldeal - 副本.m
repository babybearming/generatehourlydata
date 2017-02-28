%% 说明
%先生成辐射数据的模板
%缺测处理：先计算各站每年的文件行数，找到缺测数据进行处理
%%正文
clc;clear;
selectStationId=58606;
inputFilePath='..\..\stationsData\RADI\DAY\';
outputFilePath='..\..\stationsData\RADI\DAY\nullDeal\';
if exist(outputFilePath,'dir')==0
    mkdir(outputFilePath);
end
inputFileName=[inputFilePath num2str(selectStationId) '.txt'];
outputFileName=[outputFilePath num2str(selectStationId) '.txt'];
startYear=1961;
endYear=2012;
startMonth=1;
endMonth=12;
numofYears=endYear-startYear+1;
data=dlmread(inputFileName);
data=data(data(:,5)>=1961,:);
        
%read the txt file and calculate file rows of every year
for y=startYear:endYear
    yearhs(y-startYear+1)=length(find(data(:,5)==y));
end
    out=[[startYear:endYear]' yearhs'];
    
 %find the 32766 data and deal with it 
    [r,c]=find(data==32766);
    nullNums=length(r)
    for i=1:nullNums
        nullMonth=data(r(i),6);
        nullDay=data(r(i),7);
        data(r(i),c(i))=mean(data(data(:,6)==nullMonth&data(:,7)==nullDay&data(:,c(i))~=32766,c(i)));
    end
    
    dlmwrite(outputFileName,data,'delimiter',' ','-append','newline','pc');