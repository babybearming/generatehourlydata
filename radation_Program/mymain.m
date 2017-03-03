clear;clc;
%初始化
stationId='50953';
inputDataPath='..\..\stationsData\RADI\DAY\nullDeal\';
resultPath=['..\..\result\Rad\totalRad\' stationId '\'];
if exist(resultPath,'dir')==0
    mkdir(resultPath);
end
inputDayName=[inputDataPath stationId '.txt'];
stationDayData=dlmread(inputDayName,' ');
sy=1961; %计算始末年
ey=2012;
ny=ey-sy+1;
%站点经纬度
lon1=stationDayData(end,3);
lat1=stationDayData(end,2);
lon=floor(lon1/100)+(lon1-100*floor(lon1/100))/60; 
lat=floor(lat1/100)+(lat1-100*floor(lat1/100))/60;

pi=3.1415926;
rad=zeros(366,ny);

for i=1:ny
    tt=stationDayData(stationDayData(:,5)==i+sy-1,8);
    sta=runnian(i+sy-1);
    if sta==1
    rad(:,i)=tt;
    else
    rad(1:end-1,i)=tt;
    end
end
clear stationDayData tt sta;
rad=rad/100.0;
w=mysunw(lon);  %太阳时角
[deta,ws,qn]=mysundeta_wsqn(lon,lat,sy,ey); %太阳赤纬deta、日落时角ws和日太阳总辐射qn
a=0.409+0.5016*sin(ws-pi/3.0);
b=0.6609+0.4767*sin(ws-pi/3.0);
%tqzt=mytqzt(rad,qn,ny);
for i=1:ny
    for j=1:366
        for k=1:24 %0:00-23:00
            w1=w(k,j);
            w2=ws(j,i);
        rt=pi/24.0*(cos(w1)-cos(w2))/(sin(w2)-w2*cos(w2));
        Rcpt(k,j,i)=rad(j,i)*rt*(a(j,i)+b(j,i)*cos(w1));  %每个时刻的总辐射
        end
    end
end
Rcpt(Rcpt<0)=0;
Rcpt(1:5,:,:)=0;
Rcpt(20:end,:,:)=0;
for i=1:ny
    for j=1:366
        radjs=sum(Rcpt(:,j,i));
        if radjs~=0
              Rcpt(:,j,i)=Rcpt(:,j,i)*rad(j,i)/radjs;
        end
    end
end
%Rcptxz=myrcptxz(rad,Rcpt,tqzt,ny);
[zjfs,ssfs]=myzsfl1(Rcpt,rad,qn,ny);
Rcpt=Rcpt*10000/36;
Rcpt365=zeros(24,365,ny);
for i=sy:ey
    sta=runnian(i);
    if sta==1
    Rcpt365(:,1:59,:)=Rcpt(:,1:59,:);
    Rcpt365(:,60:end,:)=Rcpt(:,61:end,:);
    else
        Rcpt365=Rcpt(:,1:end-1,:);
    end
end

%% 数据输出
for y=1:ny
    year=y+sy-1;
    f=num2str(year);
    file=[resultPath f '.txt'];
    fid=fopen(file,'wt');
    for i=1:365
        fprintf(fid,'%f\n',Rcpt365(:,i,y));
    end
end

