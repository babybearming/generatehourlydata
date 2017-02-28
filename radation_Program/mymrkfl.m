function ytzt=mymrkfl(kt)
ytzt=zeros(1,24);
if kt>0.5
        a=kt-0.5;
        b=0.74-kt;
        if a<b
            ytzt(1)=3; %0点为阴
        else
            ytzt(1)=1;  %0点为晴
        end
    f1=(kt-0.5)/0.24;
    f2=1.0/(kt+0.206)-1.057;
else
        a=kt-0.28;
        b=0.5-kt;
        if a<b
            ytzt(1)=3;
        else
            ytzt(1)=2;
        end
    f1=0.0;
    f2=1/(kt+0.43)-0.75;
end
f3=1-f1-f2;
M=[f1,f1,0;1-f1,f2,1-f3;0,f3,f3];

for i=2:24
  N=M(:,ytzt(i-1));
   r=unifrnd(0,1);
  sort(N);
   if r>=0 && r<N(1)
       ytzt(i)=1;
   end
   if r>=N(1) && r<N(1)+N(2)
      ytzt(i)=2;
   end
   if r>=N(1)+N(2) && r<=1
       ytzt(i)=3;
   end
end
           
