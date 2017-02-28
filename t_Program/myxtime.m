function xtime=myxtime(t,tx,maxqj,i)

switch maxqj
case 1
    tt=t(2)-tx;
    if tt==0
      tt=0.00001;
    end
n=abs((tx-t(1))/tt);
temp=round(n/(n+1)*6);
if temp<=3;
xtime=20+temp;
else
xtime=temp-4;
end
if temp==0
xtime=21;
end

case 2
    tt=t(3)-tx;
    if tt==0
      tt=0.00001;
    end
n=abs((tx-t(2))/tt);
temp=round(n/(n+1)*6);
xtime=2+temp;
case 3
    tt=t(4)-tx;
    if tt==0
      tt=0.00001;
    end
n=abs((tx-t(3))/tt);
temp=round(n/(n+1)*6);
xtime=8+temp;
case 4
     tt=t(5)-tx;
    if tt==0
      tt=0.00001;
    end
n=abs((tx-t(4))/tt);
temp=round(n/(n+1)*6);
xtime=14+temp;
end

