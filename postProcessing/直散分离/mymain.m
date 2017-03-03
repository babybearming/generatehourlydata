% �ó�������ͨ��̫���ܷ������̫������ֱ������ɢ�����
% ����8760Сʱ̫���ܷ���Сʱ���ݼ�վ��ľ�γ�ȣ��������ֱ������ɢ�����Сʱ����
clc;clear;
disp('������ʼ��...');

stationId=58367;
startyr=1961;
endyr=2012;
inputDataPath='..\..\..\stationsData\RADI\DAY\nullDeal\';
filepath='..\..\..\result\Rad\';
inputDayName=[inputDataPath num2str(stationId) '.txt'];
stationDayData=dlmread(inputDayName,' ');
%վ�㾭γ��
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
i0=1367; %̫������
w=mysunw(lon); % ̫��ʱ�Ǽ���w(24,365);
disp('̫���߶Ƚǡ�����ֱ����䡢ɢ�����ļ���....');
for yr=startyr:endyr
    disp(['���ڼ���' num2str(yr) '������']);
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
        deta=mydeta(n); %ÿʱ�̳�γ�Ǽ���
        sinh=mysinh(lat,deta,w(tt));    %̫���߶Ƚǵ�����ֵ
        in=mydirectrad(i0,ih,sinh);
        id=ih-in*sinh;
        directrad(tt)=in;
        scatteringrad(tt)=id;
    end
    dlmwrite(directradname,directrad,'newline','pc');
    dlmwrite(scatteringradname,scatteringrad,'newline','pc');
end
 disp('�������!');
        

