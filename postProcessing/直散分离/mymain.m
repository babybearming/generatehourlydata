% 该程序用于通过太阳总辐射计算太阳法向直射辐射和散射辐射
% 输入8760小时太阳总辐射小时数据及站点的经纬度，输出法向直射辐射和散射辐射小时数据
clc;clear;
disp('参数初始化...');

stationId=58367;
startyr=1961;
endyr=2012;
inputDataPath='..\..\..\stationsData\RADI\DAY\nullDeal\';
filepath='..\..\..\result\Rad\';
inputDayName=[inputDataPath num2str(stationId) '.txt'];
stationDayData=dlmread(inputDayName,' ');
%站点经纬度
lon1=stationDayData(end,3);
lat1=stationDayData(end,2);
lon=floor(lon1/100)+(lon1-100*floor(lon1/100))/60; 
lat=floor(lat1/100)+(lat1-100*floor(lat1/100))/60;
clear lon1 lat1 stationDayData

fileinpath=[filepath 'totalRad\' num2str(stationId) '\'];
directradpath=[filepath 'directRad\' num2str(stationId) '\'];
scatteringradpath=[filepath 'scatteringRad\' num2str(stationId) '\'];
if ~exist(directradpath)
    mkdir(directradpath);
end
if ~exist(scatteringradpath)
    mkdir(scatteringradpath);
end
i0=1367; %太阳常数
w=mysunw(lon); % 太阳时角计算w(24,365);
disp('太阳高度角、法向直射辐射、散射辐射的计算....');
for yr=startyr:endyr
    disp(['正在计算' num2str(yr) '的数据']);
    fileinname=[fileinpath num2str(yr) '.txt'];
    directradname=[directradpath num2str(yr) '.txt'];
    scatteringradname=[scatteringradpath num2str(yr) '.txt'];
    raddata=dlmread(fileinname);
    directrad=zeros(8760,1);
    scatteringrad=zeros(8760,1);
    for tt=1:8760
        ih=raddata(tt);
        if ih==0
        directrad(tt)=0;
        scatteringrad(tt)=0;
        continue;
        end
        n=floor((tt-1)/24+1);
        deta=mydeta(n); %每时刻赤纬角计算
        sinh=mysinh(lat,deta,w(tt));    %太阳高度角的正弦值
        in=mydirectrad(i0,ih,sinh);
        id=ih-in*sinh;
        directrad(tt)=in;
        scatteringrad(tt)=id;
    end
    dlmwrite(directradname,directrad,'newline','pc');
    dlmwrite(scatteringradname,scatteringrad,'newline','pc');
end
 disp('计算完毕!');
        

