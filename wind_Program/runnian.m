function sta=runnian(a)
if a>0
   if (mod(a,4)==0&mod(a,100)~=0) || (mod(a,100)==0 && mod(a,400)==0)
   sta=1;
   else
   sta=0;
   end
end
%这是一个函数，a 为输入的年份 