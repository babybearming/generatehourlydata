function mysinh=mysinh(lat,deta,w)
    %输入纬度、太阳赤纬、太阳时角
	%计算输出太阳高度角的sin值
	pp=180/pi;
	mysinh=sin(lat/pp)*sin(deta/pp)+cos(lat/pp)*cos(deta/pp)*cos(w/pp);
	end
	