function [southrad,northrad,eastrad,westrad]=myFourDirRad(directrad,cosh,cosA,scarad,ih)
%输入 直接辐射，太阳高度角余弦值，太阳方位角余弦值，散射辐射，太阳总辐射
%输出东西南北各向太阳辐射

southrad=directrad*cosh*cosA+0.63*scarad+0.1*ih;
northrad=directrad*cosh*cosA+0.37*scarad+0.1*ih;
eastrad=directrad*cosh*sin(acos(cosA))+0.5*scarad+0.1*ih;
westrad=directrad*cosh*sin(acos(cosA))+0.5*scarad+0.1*ih;
end
