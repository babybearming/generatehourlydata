function Rcptxz=myrcptxz(rad,Rcpt,tqzt,ny)
%根据天空云量修正Rcpt值
Rcptxz=zeros(24,366,ny);
for i=1:ny
    for j=1:366
        ra=0.0;
        rb=0.0;
        rc=0.0;
        zt=sort(unique(tqzt(:,j,i)));
        l=length(zt);
        if l==1  %一天只出现一种天气状态
          Rcptxz(:,j,i)=Rcpt(:,j,i);
        end
        if l==2 %一天出现两种天气状态
            for k=1:24
                if tqzt(k,j,i)==zt(2) %云量多的状态
                    ra=ra+Rcpt(k,j,i);
                    Rcptxz(k,j,i)=0.5593*Rcpt(k,j,i);  %太阳辐射修正
                end
            end
            rb=rad(j,i)-ra;
            for k=1:24
                if tqzt(k,j,i)==zt(1)   %云量少的状态
                    Rcptxz(k,j,i)=(rb+(1-0.5593)*ra)*Rcpt(k,j,i)/rb;
                end
            end
        end
        if l==3 %一天出现三种天气状态
            for k=1:24
                if tqzt(k,j,i)==zt(3)
                    Rcptxz(k,j,i)=0.5874*Rcpt(k,j,i);
                    ra=ra+Rcpt(k,j,i);
                end
                if tqzt(k,j,i)==zt(2)
                    Rcptxz(k,j,i)=Rcpt(k,j,i);
                    rb=rb+Rcpt(k,j,i);
                end
            end
            rc=rad(j,i)-ra-rb;
            
            for k=1:24
                if tqzt(k,j,i)==zt(1)
                Rcptxz(k,j,i)=(rc+(1-0.5874)*ra)*Rcpt(k,j,i)/rc;
                end
            end
        end
    end
end
                      

        
