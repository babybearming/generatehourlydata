clear;clc;
%��ʼ��
stationId='58606';
elements={'Rad\directRad','Rad\totalRad','TEM','RHU','windSpeed','windDir'};%̫�����䷨��ֱ�����ǿ�ȡ�ˮƽ���ܷ���ǿ�ȡ������¶ȡ����ʪ�ȡ����١�����
elementsNum=length(elements);
inputDataPath1=['..\..\result\'];
resultPath=['..\..\result\����ѩ��ʽ\' stationId '\'];
if exist(resultPath,'dir')==0
    mkdir(resultPath);
end

sy=1961;
ey=2012;
outData=zeros(8760,elementsNum);
for yr=sy:ey
    yr
    for i=1:elementsNum
    inputFileName=[inputDataPath1 elements{i} '\' stationId '\' num2str(yr) '.txt'];
    inputData=dlmread(inputFileName);
    outData(:,i)=inputData;
    dlmwrite([resultPath num2str(yr) '.txt'],outData,'delimiter',' ','newline','pc','precision','%6.1f');
    end
end
    