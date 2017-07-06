function mycosA=mycosA(sinh,lat,deta)
%input 太阳高度角正弦值，纬度及太阳赤纬
%output 太阳方位角余弦值
pp=180/pi;
mycosA=(sinh*sin(lat/pp)-sin(deta/pp))/(cos(asin(sinh))*cos(lat/pp));
end