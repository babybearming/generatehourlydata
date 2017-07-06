clear;clc;

stationInfo=[54517,39.10,117.17]; % վ����Ϣ
stationid=stationInfo(1);
lat=stationInfo(2);
lon=stationInfo(3);
raddata=xlsread('rad.xlsx',num2str(stationid));
totalrad=raddata(:,1);
scarad=raddata(:,2);
directrad=raddata(:,3);

% elements initial
i0=1367; %̫������
w=mysunw(lon); %̫��ʱ�Ǽ���

southrad=zeros(8760,1);
northrad=zeros(8760,1);
eastrad=zeros(8760,1);
westrad=zeros(8760,1);
for tt=1:8760
    ih=totalrad(tt);
    direct=directrad(tt);
    sca=scarad(tt);
    n=floor((tt-1)/24+1);
    deta=mydeta(n); %ÿʱ�̳�γ�Ǽ���
    sinh=mysinh(lat,deta,w(tt));    %̫���߶Ƚǵ�����ֵ
    cosh=cos(asin(sinh)); %̫���߶Ƚ�����ֵ
    cosA=mycosA(sinh,lat,deta); %̫����λ������ֵ
    [Is,In,Ie,Iw]=myFourDirRad(direct,cosh,cosA,sca,ih);
    southrad(tt)=Is;
    northrad(tt)=In;
    eastrad(tt)=Ie;
    westrad(tt)=Iw;
end


