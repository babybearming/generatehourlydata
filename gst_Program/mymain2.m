clear;clc;
inputDataPath=[cd '\inputData\'];
resultPath=[cd '\result\'];
T02=xlsread([inputDataPath 'T02.xls']);T08=xlsread([inputDataPath 'T08.xls']);T14=xlsread([inputDataPath 'T14.xls']);
T20=xlsread([inputDataPath 'T20.xls']);Tmax=xlsread([inputDataPath 'Tmax.xls']);Tmin=xlsread([inputDataPath 'Tmin.xls']); %读入数据
t=zeros(1,5);
ls=length(T02(2,:));%数据列数
hs=length(T02(:,2));%行数
shike=[20 2 8 14 20];
zs=zeros(24,366,51);
for kk=2:ls
    if T02(61,kk)==0
     T02(61,kk)=T02(60,kk);T08(61,kk)=T08(60,kk);T14(61,kk)=T14(60,kk);...
     T20(61,kk)=T20(60,kk);Tmax(61,kk)=Tmax(60,kk);Tmin(61,kk)=Tmin(60,kk);
    end
end

for j=3:ls   %从1960年开始
    t=[T20(hs-1,j-1),T02(2,j),T08(2,j),T14(2,j),...
        T20(2,j)];  %//获取每年第一天气象日数据（包含上一年T20数据）
    tx=Tmax(2,j);  
    tm=Tmin(2,j);
    maxqj=mytmaxqj(t,tx);  %最大气温出现的区间
    minqj=mytminqj(t,tm);
    xtime=myxtime(t,tx,maxqj,hs-1);  %最大气温出现的时刻
    mtime=mymtime(t,tm,minqj,hs-1);  %最小气温出现的时刻
    [x,y]=myshurudata(t,tx,tm,maxqj,minqj,xtime,mtime);%初始化输入数据，使其符合myspline格式
    yi=myspline(x,y,tx,tm);
    zs(:,1,j-2)=yi(2:25);
    
    for i=2:hs-2
        t=[T20(i,j),T02(i+1,j),T08(i+1,j),T14(i+1,j),...
            T20(i+1,j)];
        tx=Tmax(i+1,j);
        tm=Tmin(i+1,j);
        maxqj=mytmaxqj(t,tx);
        minqj=mytminqj(t,tm);
        xtime=myxtime(t,tx,maxqj,i);  %最大气温出现的时刻
        mtime=mymtime(t,tm,minqj,i);  %最小气温出现的时刻
        [x,y]=myshurudata(t,tx,tm,maxqj,minqj,xtime,mtime);
        yi=myspline(x,y,tx,tm);
         zs(:,i,j-2)=yi(2:25);
    end
end 
zss=zeros(24,365,51);
zss(:,1:59,:)=zs(:,1:59,:);
zss(:,60:end,:)=zs(:,61:end,:);

%数据输出
for y=1:51
    year=y+1959;
    f=num2str(year);
    file=[resultPath f '.txt'];
    fid=fopen(file,'wt');
    fprintf(fid,'%f\n',zss(4:end,1,y));
    for i=2:365
        fprintf(fid,'%f\n',zss(:,i,y));
    end
    fprintf(fid,'%f\n',zss(1:3,1,y+1));
end