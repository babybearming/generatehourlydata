function minqj=mytminqj(t,tmin)
%t=[23 17 21 29 24];
%tmin=16.9;
global minqj
minqj=0;%������¶�����������
dz1=0;
wz=find(t==min(t));
if length(wz)>1 
    if wz(2)==2
        dz1=wz(2);
    end
end
dz=wz(1);

if dz==1 && t(1)<t(2)
minqj=1;
end

if dz==2 || dz1==2
minqj=2;
end

if dz>=3 && dz<=4
    if t(dz-1)-t(dz+1)<=0
    minqj=dz-1;
    else
    minqj=dz;
    end
end
    
if dz==5
minqj=4;
end
%disp(t);
%disp(tmin);
