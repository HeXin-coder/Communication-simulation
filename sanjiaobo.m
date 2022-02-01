%三角波信号
clear;
clc;
f=1e3;
fs=20*f; %采样频率
dt=1/fs;
T=50/f;
t=0:dt:T;

% subplot(3,2,1);
plot(t,y)%时域图
xlim([0 5/f])