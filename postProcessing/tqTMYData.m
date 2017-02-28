clc;clear;
stationId='54527';
tmyyr_yr='1981_2010';
TMYyr=[1987	1986	1992	1994	1982	1990	2004	1988	2001	2009	1998	1983];
d=[31,28,31,30,31,30,31,31,30,31,30,31];
dd=zeros(1,13);
for i=1:12
    dd(i+1)=sum(d(1:i))*24;
end

inputPath=['..\..\result\six2one\' stationId '\'];
resultPath=['..\..\result\tmyData\' stationId '\'];
if exist(resultPath,'dir')==0
    mkdir(resultPath);
end

outData=zeros(8760,6);
for i=1:12
    inputFileName=[inputPath num2str(TMYyr(i)) '.txt'];
    M=dlmread(inputFileName);
    outData((dd(i)+1):dd(i+1),:)=M((dd(i)+1):dd(i+1),:);
end

xlswrite([resultPath tmyyr_yr 'tmy.xls'],outData);