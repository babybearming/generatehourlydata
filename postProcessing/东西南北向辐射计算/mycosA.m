function mycosA=mycosA(sinh,lat,deta)
%input ̫���߶Ƚ�����ֵ��γ�ȼ�̫����γ
%output ̫����λ������ֵ
pp=180/pi;
mycosA=(sinh*sin(lat/pp)-sin(deta/pp))/(cos(asin(sinh))*cos(lat/pp));
end