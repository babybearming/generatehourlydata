function maxqj=mytmaxqj(t,tmax)
%t=[23 17 21 29 24];
%tmax=29.2;
global maxqj
maxqj=0;%日最高温度所在区间标记
if tmax<=t(1)
   maxqj=1;
else 
wz=find(t==max(t(2:end)));
dz=wz(end);
if dz<=4 && dz>=2
     if t(dz+1)-t(dz-1)>0
            maxqj=dz;
        else
            maxqj=dz-1;
     end
end
if dz==5
        maxqj=4;
end
end
%disp(t);
%disp(tmax);