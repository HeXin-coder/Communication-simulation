clear;
clc;
% x1=-10:0.1:0;
% y1=x1;
% x2=0:0.1:10;
% y2=sin(x2)
% x=[x1 x2]
% y=[y1 y2]
% plot(x,y)
% 第二种思路
x=-10:0.1:10;
y=sin(x);
y(x<0)=x(x<0);
plot(x,y)