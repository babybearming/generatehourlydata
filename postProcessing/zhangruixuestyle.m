clear;clc;
%初始化
stationId='58606';
elements={'Rad\directRad','Rad\totalRad','TEM','RHU','windSpeed','windDir'};%太阳辐射法向直射辐射强度、水平面总辐射强度、干球温度、相对湿度、风速、风向
elementsNum=length(elements);
inputDataPath1=['..\..\result\'];
resultPath=['..\..\result\张瑞雪格式\' stationId '\'];
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
    