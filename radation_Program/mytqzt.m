function tqzt=mytqzt(rad,qn,ny)
tqzt=zeros(24,366,ny); %1代表晴，2代表有云，3代表阴

for i=1:ny
    for j=1:366
        kt=rad(j,i)/qn(j,i);
        if kt<=0.28
            tqzt(:,j,i)=3;
        elseif kt<0.74
            ytzt=mymrkfl(kt);
            tqzt(:,j,i)=ytzt;
        else
            tqzt(:,j,i)=1;
        end
    end
end
            
