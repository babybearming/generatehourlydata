function [deta,ws,qn]=mysundeta_wsqn(lon,lat,sy,ey)
pi=3.1415926;
pp=180/pi;
d=fix(lon); %����㾭�ȵĶ�ֵ
m=(lon-d)*60.0; %�����ķ�ֵ
fi=lat/pp;  
r=34.0/60.0;
r=r/pp;  
s=12; %����ʱ�̵�ʱֵ��������ȡΪ12
f=0; %����ʱ�̷�ֵ��ȡΪ0
w=s+f/60.0;
l=-(d+m/60.0)/15.0;
dn=(w-l)/24.0; %���ն���ֵ
i0=0.001367;  %̫������
t=24*60*60;
deta=zeros(366,ey-sy+1);  %��ʼ��̫����γ
ws=zeros(366,ey-sy+1);  %��ʼ������ʱ��
qn=zeros(366,ey-sy+1); %��ʼ�������ķ�������
for y=sy:ey
    n0=79.6764+0.2422*(y-1985)-floor(0.25*(y-1985));
    for i=0:365
    x=2*pi*57.3*(i+dn-n0)/365.2422;
    x=x/pp;
    deta(i+1,y-sy+1)=0.3723+23.2567*sin(x)+0.1149*sin(2.0*x)...
        -0.1712*sin(3.0*x)-0.7580*cos(x)+0.3656*cos(2.0*x)+0.0201*cos(3.0*x);
    deta1=deta(i+1,y-sy+1)/pp;
    ws(i+1,y-sy+1)=acos(-tan(fi)*tan(deta1));
    ws1=ws(i+1,y-sy+1);
    p2=1.000423+0.032359*sin(x)+0.000086*sin(2.0*x)-0.008349*cos(x)...
        +0.000115*cos(2.0*x);  %�յ���Ծ���
    
    qn(i+1,y-sy+1)=t*i0*(ws1*sin(fi)*sin(deta1)+cos(fi)*cos(deta1)*sin(ws1))...
        /(pi*p2);
    end
end

    