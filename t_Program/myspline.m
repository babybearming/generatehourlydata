function yi=myspline(x,y,tmax,tmin)
%x=[20 2 4 8 14 15 20];
xh=zeros(1,7);
xh(1)=1;
if x(2)>20
xh(2)=x(2)-19;
xh(3:end-1)=x(3:end-1)+5;
xh(end)=25;
else
xh(2:end-1)=x(2:end-1)+5;
xh(end)=25;
end
xh;
pp=csape(xh,y,'variational');  %端点采用自然边界
xi=1:25;
%a=polyfit(xh,y,6);
%yi=polyval(a,xi);
yi=ppval(pp,xi);  %计算逐时数据
yi(yi>tmax)=tmax;  %保证最大值点为极值点
yi(yi<tmin)=tmin;
%plot(xh,y,'o',xi,yi);
%axis([1 24 12 36])
%xlswrite('逐时气温.xls',yi,'A1') %输出21：00至20：00逐时数据
