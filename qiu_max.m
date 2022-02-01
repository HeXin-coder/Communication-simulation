clear;
clc;
x=-3:0.1:3;
y=x.^2.*exp(-x.^2);
plot(x,y);
m=max(y);
x(find(y==m))