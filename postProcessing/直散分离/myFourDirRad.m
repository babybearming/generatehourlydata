function [southrad,northrad,eastrad,westrad]=myFourDirRad(directrad,cosh,cosA,scarad,ih)
%���� ֱ�ӷ��䣬̫���߶Ƚ�����ֵ��̫����λ������ֵ��ɢ����䣬̫���ܷ���
%��������ϱ�����̫������

Is=directrad*cosh*cosA+0.63*scarad+0.1*ih;
In=directrad*cosh*cosA+0.37*scarad+0.1*ih;
Ie=directrad*cosh*sin(acos(cosA))+0.5*scarad+0.1*ih;
Iw=directrad*cosh*sin(acos(cosA))+0.5*scarad+0.1*ih;
end
