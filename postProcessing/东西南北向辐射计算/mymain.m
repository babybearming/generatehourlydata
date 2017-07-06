clear;clc;

stationInfo=[54517,39.10,117.17]; % 站点信息
stationid=stationInfo(1);
lat=stationInfo(2);
lon=stationInfo(3);
raddata=xlsread('rad.xlsx',num2str(stationid));
totalrad=raddata(:,1);
scarad=raddata(:,2);
directrad=raddata(:,3);

% elements initial
i0=1367; %太阳常数
w=mysunw(lon); %太阳时角计算

southrad=zeros(8760,1);
northrad=zeros(8760,1);
eastrad=zeros(8760,1);
westrad=zeros(8760,1);
for tt=1:8760
    ih=totalrad(tt);
    direct=directrad(tt);
    sca=scarad(tt);
    n=floor((tt-1)/24+1);
    deta=mydeta(n); %每时刻赤纬角计算
    sinh=mysinh(lat,deta,w(tt));    %太阳高度角的正弦值
    cosh=cos(asin(sinh)); %太阳高度角余弦值
    cosA=mycosA(sinh,lat,deta); %太阳方位角余弦值
    [Is,In,Ie,Iw]=myFourDirRad(direct,cosh,cosA,sca,ih);
    southrad(tt)=Is;
    northrad(tt)=In;
    eastrad(tt)=Ie;
    westrad(tt)=Iw;
end


