function [zjfs,ssfs]=myzsfl1(Rcpt,rad,qn,ny)
zjfs=zeros(24,366,ny);
ssfs=zeros(24,366,ny);
for i=1:ny
    for j=1:366
        kt=rad(j,i)/qn(j,i);
        if kt<0.07
            ssfs(:,j,i)=Rcpt(:,j,i);
        elseif kt<0.35
            xs=1-2.3*(kt-0.07)*(kt-0.07);
            ssfs(:,j,i)=xs*Rcpt(:,j,i);
        elseif kt<0.75
            xs=1.33-1.46*kt;
            ssfs(:,j,i)=xs*Rcpt(:,j,i);
        else
            xs=0.23;
            ssfs(:,j,i)=xs*Rcpt(:,j,i);
        end
        zjfs(:,j,i)=Rcpt(:,j,i)-ssfs(:,j,i);
    end
end