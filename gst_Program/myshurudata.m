function [x,y]=myshurudata(t,tx,tm,maxqj,minqj,xtime,mtime)

x=zeros(1,7);
y=zeros(1,7);
for kk=1:7
y(kk)=999;
x(kk)=999;
end
if maxqj>minqj
    x(minqj+1)=mtime;
    y(minqj+1)=tm;
x(maxqj+2)=xtime;
y(maxqj+2)=tx;
end

if minqj>maxqj
    x(maxqj+1)=xtime;
    y(maxqj+1)=tx;
    x(minqj+2)=mtime;
    y(minqj+2)=tm;
end

if maxqj==minqj && maxqj~=1
    if mtime<xtime
    x(minqj+1)=mtime;
    y(minqj+1)=tm;
    x(maxqj+2)=xtime;
    y(maxqj+2)=tx;
    else
    x(maxqj+1)=xtime;
    y(maxqj+1)=tx;
    x(minqj+2)=mtime;
    y(minqj+2)=tm;   
    end
end

if maxqj==minqj && maxqj==1
    if (mtime>20 && xtime>20) || (mtime<=2 && xtime<=2)
       if mtime<xtime
    x(minqj+1)=mtime;
    y(minqj+1)=tm;
    x(maxqj+2)=xtime;
    y(maxqj+2)=tx;
    else
    x(maxqj+1)=xtime;
    y(maxqj+1)=tx;
    x(minqj+2)=mtime;
    y(minqj+2)=tm;   
    end 
    end
    
    if mtime-xtime>10
     x(minqj+1)=mtime;
    y(minqj+1)=tm;
    x(maxqj+2)=xtime;
    y(maxqj+2)=tx; 
    end
    
    if xtime-mtime>10
    x(maxqj+1)=xtime;
    y(maxqj+1)=tx;
    x(minqj+2)=mtime;
    y(minqj+2)=tm;   
    end
end
          
    x(x==999)=[20 2 8 14 20];
    y(y==999)=t;