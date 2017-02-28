clear;clc;
inputDataPath=[cd '\inputData\'];
resultPath=[cd '\result\'];
T02=xlsread([inputDataPath 'T02.xls']);T08=xlsread([inputDataPath 'T08.xls']);T14=xlsread([inputDataPath 'T14.xls']);
T20=xlsread([inputDataPath 'T20.xls']);Tmax=xlsread([inputDataPath 'Tmax.xls']);Tmin=xlsread([inputDataPath 'Tmin.xls']); %��������
t=zeros(1,5);
ls=length(T02(2,:));%��������
hs=length(T02(:,2));%����
shike=[20 2 8 14 20];
zs=zeros(24,366,51);
for kk=2:ls
    if T02(61,kk)==0
     T02(61,kk)=T02(60,kk);T08(61,kk)=T08(60,kk);T14(61,kk)=T14(60,kk);...
     T20(61,kk)=T20(60,kk);Tmax(61,kk)=Tmax(60,kk);Tmin(61,kk)=Tmin(60,kk);
    end
end

for j=3:ls   %��1960�꿪ʼ
    t=[T20(hs-1,j-1),T02(2,j),T08(2,j),T14(2,j),...
        T20(2,j)];  %//��ȡÿ���һ�����������ݣ�������һ��T20���ݣ�
    tx=Tmax(2,j);  
    tm=Tmin(2,j);
    maxqj=mytmaxqj(t,tx);  %������³��ֵ�����
    minqj=mytminqj(t,tm);
    xtime=myxtime(t,tx,maxqj,hs-1);  %������³��ֵ�ʱ��
    mtime=mymtime(t,tm,minqj,hs-1);  %��С���³��ֵ�ʱ��
    [x,y]=myshurudata(t,tx,tm,maxqj,minqj,xtime,mtime);%��ʼ���������ݣ�ʹ�����myspline��ʽ
    yi=myspline(x,y,tx,tm);
    zs(:,1,j-2)=yi(2:25);
    
    for i=2:hs-2
        t=[T20(i,j),T02(i+1,j),T08(i+1,j),T14(i+1,j),...
            T20(i+1,j)];
        tx=Tmax(i+1,j);
        tm=Tmin(i+1,j);
        maxqj=mytmaxqj(t,tx);
        minqj=mytminqj(t,tm);
        xtime=myxtime(t,tx,maxqj,i);  %������³��ֵ�ʱ��
        mtime=mymtime(t,tm,minqj,i);  %��С���³��ֵ�ʱ��
        [x,y]=myshurudata(t,tx,tm,maxqj,minqj,xtime,mtime);
        yi=myspline(x,y,tx,tm);
         zs(:,i,j-2)=yi(2:25);
    end
end 
zss=zeros(24,365,51);
zss(:,1:59,:)=zs(:,1:59,:);
zss(:,60:end,:)=zs(:,61:end,:);

%�������
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