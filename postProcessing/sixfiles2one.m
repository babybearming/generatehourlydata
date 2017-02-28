clear;clc;
%初始化
stationId='54517';
elements={'TEM','RHU','Rad','windSpeed','windDir','GST'};%气温、相对湿度、太阳总辐射、风速、风向、地表温度
elementsNum=length(elements);
inputDataPath1=['..\..\result\'];
resultPath=['..\..\result\six2one\' stationId '\'];
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
    dlmwrite([resultPath num2str(yr) '.txt'],outData,'newline','pc');
    end
end
    