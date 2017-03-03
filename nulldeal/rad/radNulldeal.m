%% ˵��
%�����ɷ������ݵ�ģ��
%ȱ�⴦���ȼ����վÿ����ļ��������ҵ�ȱ�����ݽ��д���
%%����
clc;clear;
selectStationId=54527;
inputFilePath='..\..\..\stationsData\RADI\DAY\';
outputFilePath='..\..\..\stationsData\RADI\DAY\nullDeal\';
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
data1=dlmread(inputFileName);
data1=data1(data1(:,5)>=1961,:);
data1hs=length(data1(:,1));
%ȱ��ģ��
disp('ȱ�⴦��....');
nullmuban=dlmread('muban.txt');
nullmuban(:,1)=selectStationId;
mubanhs=length(nullmuban(:,1));
for i=1:mubanhs
    for j=1:data1hs
        if nullmuban(i,5)==data1(j,5)&nullmuban(i,6)==data1(j,6)&nullmuban(i,7)==data1(j,7)
            nullmuban(i,8:end)=data1(j,8:end);
            nullmuban(i,1:4)=data1(j,1:4);
        end
    end
end
data=nullmuban;

%read the txt file and calculate file rows of every year
for y=startYear:endYear
    yearhs(y-startYear+1)=length(find(data(:,5)==y));
end
    out=[[startYear:endYear]' yearhs'];
   disp('ȱ����־����...');
 %find the 32766 data and deal with it 
    [r,c]=find(data==32766);
    nullNums=length(r);
    nulllog=data(data(:,8)==32766,5:7);
    dlmwrite([num2str(selectStationId) '-ȱ����־.txt'],nulllog,'delimiter',' ','newline','pc');
    for i=1:nullNums
        nullMonth=data(r(i),6);
        nullDay=data(r(i),7);
        data(r(i),c(i))=mean(data(data(:,6)==nullMonth&data(:,7)==nullDay&data(:,c(i))~=32766,c(i)));
    end
    
    dlmwrite(outputFileName,data,'delimiter',' ','-append','newline','pc');