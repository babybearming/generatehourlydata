function Rcptxz=myrcptxz(rad,Rcpt,tqzt,ny)
%���������������Rcptֵ
Rcptxz=zeros(24,366,ny);
for i=1:ny
    for j=1:366
        ra=0.0;
        rb=0.0;
        rc=0.0;
        zt=sort(unique(tqzt(:,j,i)));
        l=length(zt);
        if l==1  %һ��ֻ����һ������״̬
          Rcptxz(:,j,i)=Rcpt(:,j,i);
        end
        if l==2 %һ�������������״̬
            for k=1:24
                if tqzt(k,j,i)==zt(2) %�������״̬
                    ra=ra+Rcpt(k,j,i);
                    Rcptxz(k,j,i)=0.5593*Rcpt(k,j,i);  %̫����������
                end
            end
            rb=rad(j,i)-ra;
            for k=1:24
                if tqzt(k,j,i)==zt(1)   %�����ٵ�״̬
                    Rcptxz(k,j,i)=(rb+(1-0.5593)*ra)*Rcpt(k,j,i)/rb;
                end
            end
        end
        if l==3 %һ�������������״̬
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
                      

        
