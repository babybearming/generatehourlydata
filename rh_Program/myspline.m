function yi=myspline(x,y,tm)
%x=[20 2 4 8 14 15 20];
xh=zeros(1,5);
xh(1)=1;
if x(2)>20
xh(2)=x(2)-19;
xh(3:end-1)=x(3:end-1)+5;
xh(end)=25;
else
xh(2:end-1)=x(2:end-1)+5;
xh(end)=25;
end
pp=csape(xh,y,'variational');  %�˵������Ȼ�߽�
xi=1:25;
%a=polyfit(xh,y,6);
%yi=polyval(a,xi);
yi=ppval(pp,xi);  %������ʱ����
if tm==32766
    yi(yi>100)=100;
	yi(yi<=0)=1;
else
yi(yi>100)=100;
yi(yi<=tm)=tm;
end
%plot(xh,y,'o',xi,yi);
%axis([1 24 12 36])
%xlswrite('��ʱ����.xls',yi,'A1') %���21��00��20��00��ʱ����
