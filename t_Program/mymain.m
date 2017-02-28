clear;clc;
%% 数据预处理
%路径等初始化
stationId='58606';
inputDataPath='..\..\stationsData\';
resultPath=['..\..\result\TEM\' stationId '\'];
if exist(resultPath,'dir')==0
    mkdir(resultPath);
end
inputH4Name=[inputDataPath 'TEM_H4\' stationId '.txt'];
inputMaxMinName=[inputDataPath 'TEM_DAY_MAX_MIN\' stationId '.txt'];

%读入一日四次及最高最低气温数据
stationH4Data=dlmread(inputH4Name,' ');
stationMaxMinData=dlmread(inputMaxMinName,' ');
%气温除以10，单位换算成℃
stationH4Data(:,8:11)=stationH4Data(:,8:11)/10.0;
stationMaxMinData(:,8:10)=stationMaxMinData(:,8:10)/10.0;

%数组初始化
startYear=1960; %可修改成自动识别,包含1960年，输出数据从1961年开始
endYear=2012;
numofYears=endYear-startYear+1;
shike=[20 2 8 14 20];
zs=zeros(24,366,numofYears-1);
T02=zeros(366,endYear-startYear+1);
T08=zeros(366,endYear-startYear+1);
T14=zeros(366,endYear-startYear+1);
T20=zeros(366,endYear-startYear+1);
Tmax=zeros(366,endYear-startYear+1);
Tmin=zeros(366,endYear-startYear+1);

%% 气温插值计算

%各数组读入气温数据
for i=1:numofYears
    temp02=stationH4Data(stationH4Data(:,5)==i+startYear-1,8);
    temp08=stationH4Data(stationH4Data(:,5)==i+startYear-1,9);
    temp14=stationH4Data(stationH4Data(:,5)==i+startYear-1,10);
    temp20=stationH4Data(stationH4Data(:,5)==i+startYear-1,11);
    tempMax=stationMaxMinData(stationMaxMinData(:,5)==i+startYear-1,9);
    tempMin=stationMaxMinData(stationMaxMinData(:,5)==i+startYear-1,10);
    hs=length(temp02);
    if hs==366
    T02(:,i)=temp02;
    T08(:,i)=temp08;
    T14(:,i)=temp14;
    T20(:,i)=temp20;
    Tmax(:,i)=tempMax;
    Tmin(:,i)=tempMin;
    else
    T02(1:59,i)=temp02(1:59);
    T02(60)=temp02(59); %闰月那天用头一天数据代替
    T02(61:end,i)=temp02(60:end);
       T08(1:59,i)=temp08(1:59);
    T08(60)=temp08(59); %闰月那天用头一天数据代替
    T08(61:end,i)=temp08(60:end);
       T14(1:59,i)=temp14(1:59);
    T14(60)=temp14(59); %闰月那天用头一天数据代替
    T14(61:end,i)=temp14(60:end);
        T20(1:59,i)=temp20(1:59);
    T20(60)=temp20(59); %闰月那天用头一天数据代替
    T20(61:end,i)=temp20(60:end);
        Tmax(1:59,i)=tempMax(1:59);
    Tmax(60)=tempMax(59); %闰月那天用头一天数据代替
    Tmax(61:end,i)=tempMax(60:end);
        Tmin(1:59,i)=tempMin(1:59);
    Tmin(60)=tempMin(59); %闰月那天用头一天数据代替
    Tmin(61:end,i)=tempMin(60:end);
    end
    clear temp02 temp08 temp14 temp20 tempMax tempMin;
end

% 开始插值
for j=2:numofYears   
    j+startYear-1
    t=[T20(366,j-1),T02(1,j),T08(1,j),T14(1,j),...
        T20(1,j)];  %//获取每年第一天气象日数据（包含上一年T20数据）
    tx=Tmax(1,j);  
    tm=Tmin(1,j);
    if tx==3276.6
        tx=max(t);
    end
    if tm==3276.6
        tm=min(t);
    end
    maxqj=mytmaxqj(t,tx);  %最大气温出现的区间
    minqj=mytminqj(t,tm);
    xtime=myxtime(t,tx,maxqj,366);  %最大气温出现的时刻
    mtime=mymtime(t,tm,minqj,366);  %最小气温出现的时刻
    [x,y]=myshurudata(t,tx,tm,maxqj,minqj,xtime,mtime);%初始化输入数据，使其符合myspline格式
    yi=myspline(x,y,tx,tm);
    zs(:,1,j-1)=yi(2:25);
    
    for i=1:365
        t=[T20(i,j),T02(i+1,j),T08(i+1,j),T14(i+1,j),...
            T20(i+1,j)];
        tx=Tmax(i+1,j);
        tm=Tmin(i+1,j);
        
    if tx==3276.6
        tx=max(t);
        tx
    end
    if tm==3276.6
        tm=min(t);
        tm
    end
        maxqj=mytmaxqj(t,tx);
        minqj=mytminqj(t,tm);
        xtime=myxtime(t,tx,maxqj,i);  %最大气温出现的时刻
        mtime=mymtime(t,tm,minqj,i);  %最小气温出现的时刻
        [x,y]=myshurudata(t,tx,tm,maxqj,minqj,xtime,mtime);
        yi=myspline(x,y,tx,tm);
         zs(:,i+1,j-1)=yi(2:25);
    end
end 
zss=zeros(24,365,numofYears-1);
zss(:,1:59,:)=zs(:,1:59,:);
zss(:,60:end,:)=zs(:,61:end,:);

%% 数据输出
for y=1:numofYears-1
    year=y+startYear;
    f=num2str(year);
    file=[resultPath f '.txt'];
    fid=fopen(file,'wt');
    fprintf(fid,'%f\n',zss(4:end,1,y));
    for i=2:365
        fprintf(fid,'%f\n',zss(:,i,y));
    end
    fprintf(fid,'%f\n',zss(1:3,1,y+1));
end
