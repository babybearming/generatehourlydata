function mtime=mymtime(t,tm,minqj,i)
switch minqj
case 1
        tt=t(2)-tm;
    if tt==0
      tt=0.00001;
    end
m=abs((tm-t(1))/tt);
tempm=round(m/(m+1)*6);
if tempm<=3;
mtime=20+tempm;
else
mtime=tempm-4;
end
if tempm==0
mtime=21;
end

case 2
if i<47
mtime=7;
elseif i<88
mtime=6;
elseif i<133
mtime=5;
elseif i<202
mtime=4;
elseif i<269
mtime=5;
elseif i<326
mtime=6;
else 
mtime=7;
end

case 3
        tt=t(4)-tm;
    if tt==0
      tt=0.00001;
    end
m=abs((tm-t(3))/tt);
tempm=round(m/(m+1)*6);
mtime=8+tempm;

case 4
    tt=t(5)-tm;
    if tt==0
      tt=0.00001;
    end
m=abs((tm-t(4))/tt);
tempm=round(m/(m+1)*6);
mtime=14+tempm;
end