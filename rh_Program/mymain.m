clear;clc;
%% ����Ԥ����
%·���ȳ�ʼ��
stationId='59431';
inputDataPath='..\..\stationsData\';
resultPath=['..\..\result\RHU\' stationId '\'];
if exist(resultPath,'dir')==0
    mkdir(resultPath);
end
inputH4Name=[inputDataPath 'RHU_H4\' stationId '.txt'];
inputMinName=[inputDataPath 'RUH_DAY_MIN\' stationId '.txt'];

%����һ���Ĵ����ʪ������
stationH4Data=dlmread(inputH4Name,' ');
stationMinData=dlmread(inputMinName,' ');

%�����ʼ��
startYear=1960; %���޸ĳ��Զ�ʶ��,����1960�꣬������ݴ�1961�꿪ʼ
endYear=2012;
numofYears=endYear-startYear+1;
shike=[20 2 8 14 20];
zs=zeros(24,366,numofYears-1);
Rh02=zeros(366,endYear-startYear+1);
Rh08=zeros(366,endYear-startYear+1);
Rh14=zeros(366,endYear-startYear+1);
Rh20=zeros(366,endYear-startYear+1);
Rhmin=zeros(366,endYear-startYear+1);

%% ���ʪ�Ȳ�ֵ
% ������������ʪ������
for i=1:numofYears
    i+startYear-1
    temp02=stationH4Data(stationH4Data(:,5)==i+startYear-1,8);
    temp08=stationH4Data(stationH4Data(:,5)==i+startYear-1,9);
    temp14=stationH4Data(stationH4Data(:,5)==i+startYear-1,10);
    temp20=stationH4Data(stationH4Data(:,5)==i+startYear-1,11);
    tempMin=stationMinData(stationMinData(:,5)==i+startYear-1,9);
    hs=length(temp02);
    if hs==366
    Rh02(:,i)=temp02;
    Rh08(:,i)=temp08;
    Rh14(:,i)=temp14;
    Rh20(:,i)=temp20;
    Rhmin(:,i)=tempMin;
    else
    Rh02(1:59,i)=temp02(1:59);
    Rh02(60)=temp02(59); %����������ͷһ�����ݴ���
    Rh02(61:end,i)=temp02(60:end);
       Rh08(1:59,i)=temp08(1:59);
    Rh08(60)=temp08(59); %����������ͷһ�����ݴ���
    Rh08(61:end,i)=temp08(60:end);
       Rh14(1:59,i)=temp14(1:59);
    Rh14(60)=temp14(59); %����������ͷһ�����ݴ���
    Rh14(61:end,i)=temp14(60:end);
        Rh20(1:59,i)=temp20(1:59);
    Rh20(60)=temp20(59); %����������ͷһ�����ݴ���
    Rh20(61:end,i)=temp20(60:end);
        Rhmin(1:59,i)=tempMin(1:59);
    Rhmin(60)=tempMin(59); %����������ͷһ�����ݴ���
    Rhmin(61:end,i)=tempMin(60:end);
    end
    clear temp02 temp08 temp14 temp20 tempMin;
end

%��ʼ��ֵ
for j=2:numofYears 
    t=[Rh20(end,j-1),Rh02(1,j),Rh08(1,j),Rh14(1,j),...
        Rh20(1,j)];  %//��ȡÿ���һ�����������ݣ�������һ��Rh20���ݣ�
    tm=Rhmin(1,j);
	y=t;
    x=shike;
    yi=myspline(x,y,tm);
    zs(:,1,j-1)=yi(2:25);
    
    for i=1:365
        t=[Rh20(i,j),Rh02(i+1,j),Rh08(i+1,j),Rh14(i+1,j),...
            Rh20(i+1,j)];
	tm=Rhmin(i+1,j);
    y=t;
    x=shike;
    yi=myspline(x,y,tm);
         zs(:,i+1,j-1)=yi(2:25);
    end
end 
zss=zeros(24,365,numofYears-1);
zss(:,1:59,:)=zs(:,1:59,:);
zss(:,60:end,:)=zs(:,61:end,:);

%% �������
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
