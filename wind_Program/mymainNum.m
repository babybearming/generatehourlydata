clear;clc;
%%  初始化
stationId='58606';
inputDataPath='..\..\stationsData\';
windSpeedResultPath=['..\..\result\windSpeed\' stationId '\'];
if exist(windSpeedResultPath,'dir')==0
    mkdir(windSpeedResultPath);
end
windDirResultPath=['..\..\result\windDir\' stationId '\'];
if exist(windDirResultPath,'dir')==0
    mkdir(windDirResultPath);
end

inputH4Name=[inputDataPath 'WIN\' stationId '.txt'];
% 读入一日四次风向风速
stationH4Data=dlmread(inputH4Name,' ');

%数组初始化
startYear=1961;
endYear=2012;
numofYears=endYear-startYear+1;

%% 逐日to逐时
windSpeed=zeros(24,365,numofYears);
windDir=zeros(24,365,numofYears);
windDir24Times=zeros(365,24);
windSpeed24Times=zeros(365,24);
%风向风速每时刻赋值
for i=1:numofYears
    windDir4Times=stationH4Data(stationH4Data(:,5)==i+startYear-1,8:2:14);
    windSpeed4Times=stationH4Data(stationH4Data(:,5)==i+startYear-1,9:2:15);
    %缺测处理，缺测的话都采用下1个观测值
    [hs1,ls1]=find(windDir4Times==32766);
    numOfwindDirMissData=length(hs1);
    for j=1:numOfwindDirMissData
        if ls1(j)<=3
            windDir4Times(hs1(j),ls1(j))=windDir4Times(hs1(j),ls1(j)+1);
        else
            windDir4Times(hs1(j),ls1(j))=windDir4Times(hs1(j)+1,1);
        end
    end
    [hs2,ls2]=find(windSpeed4Times==32766);
     numOfwindSpeedMissData=length(hs2);
    for j=1:numOfwindSpeedMissData
        if ls2<=3
            windSpeed4Times(hs2(j),ls2(j))=windSpeed4Times(hs2(j),ls2(j)+1);
        else
            windSpeed4Times(hs2(j),ls2(j))=windSpeed4Times(hs2(j)+1,1);
        end
    end
    
    sta=runnian(i+startYear-1); %闰年判断
    if sta==1
        n=0;
    for k=1:6:24
        n=n+1;
    windDir24Times(1:59,k)=windDir4Times(1:59,n);
    windDir24Times(60:end,k)=windDir4Times(61:end,n);
    windDir24Times(1:59,k+1)=windDir4Times(1:59,n);
    windDir24Times(60:end,k+1)=windDir4Times(61:end,n);
    windDir24Times(1:59,k+2)=windDir4Times(1:59,n);
    windDir24Times(60:end,k+2)=windDir4Times(61:end,n);
    windDir24Times(1:59,k+3)=windDir4Times(1:59,n);
    windDir24Times(60:end,k+3)=windDir4Times(61:end,n);
    windDir24Times(1:59,k+4)=windDir4Times(1:59,n);
    windDir24Times(60:end,k+4)=windDir4Times(61:end,n);
    windDir24Times(1:59,k+5)=windDir4Times(1:59,n);
    windDir24Times(60:end,k+5)=windDir4Times(61:end,n);
    
    windSpeed24Times(1:59,k)=windSpeed4Times(1:59,n);
    windSpeed24Times(60:end,k)=windSpeed4Times(61:end,n);
    windSpeed24Times(1:59,k+1)=windSpeed4Times(1:59,n);
    windSpeed24Times(60:end,k+1)=windSpeed4Times(61:end,n);
    windSpeed24Times(1:59,k+2)=windSpeed4Times(1:59,n);
    windSpeed24Times(60:end,k+2)=windSpeed4Times(61:end,n);
    windSpeed24Times(1:59,k+3)=windSpeed4Times(1:59,n);
    windSpeed24Times(60:end,k+3)=windSpeed4Times(61:end,n);
    windSpeed24Times(1:59,k+4)=windSpeed4Times(1:59,n);
    windSpeed24Times(60:end,k+4)=windSpeed4Times(61:end,n);
    windSpeed24Times(1:59,k+5)=windSpeed4Times(1:59,n);
    windSpeed24Times(60:end,k+5)=windSpeed4Times(61:end,n);
    end
    else
        n=0;
    for k=1:6:24
        n=n+1;
    windDir24Times(:,k)=windDir4Times(:,n);
    windDir24Times(:,k+1)=windDir4Times(:,n);
    windDir24Times(:,k+2)=windDir4Times(:,n);
    windDir24Times(:,k+3)=windDir4Times(:,n);
    windDir24Times(:,k+4)=windDir4Times(:,n);
    windDir24Times(:,k+5)=windDir4Times(:,n);
    
    windSpeed24Times(:,k)=windSpeed4Times(:,n);
    windSpeed24Times(:,k+1)=windSpeed4Times(:,n);
    windSpeed24Times(:,k+2)=windSpeed4Times(:,n);
    windSpeed24Times(:,k+3)=windSpeed4Times(:,n);
    windSpeed24Times(:,k+4)=windSpeed4Times(:,n);
    windSpeed24Times(:,k+5)=windSpeed4Times(:,n);
    end
    end
        
%% Data output
    year=i+startYear-1
    f=num2str(year);
    file1=[windSpeedResultPath f '.txt'];
    fid1=fopen(file1,'wt');
    file2=[windDirResultPath f '.txt'];
    fid2=fopen(file2,'wt');
    for ii=1:365
    fprintf(fid1,'%f\n',windSpeed24Times(ii,:)/10.0);
    fprintf(fid2,'%d\n',windDir24Times(ii,:));
        
    end
    
    end    
    

    