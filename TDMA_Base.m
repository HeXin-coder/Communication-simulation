% TDMA基础
clear;clc;close all;%关掉所有打开的图
fs=100;%采样频率
dt=1/fs;

% t=0:dt:T;
% y=t;
% z=ceil(y);    利用向上取整

tA=0:dt:1-dt; A=1*(tA>=0);  %常数采样方法
tB=1:dt:2-dt; B=2*(tB>=0);
tC=2:dt:3-dt; C=3*(tC>=0);
%可以尝试看看A=1*t(t>=0)的结果
% t=[tA tB tC];
T=[];
y=[A B C];Y=[];
for k=0:100
    t=3*k:dt:3*(k+1)-dt;
    T=[T t];
    Y=[Y y];
end
plot(T,Y);xlim([0 15])%要保证二者维数相同