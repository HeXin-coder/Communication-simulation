%2ASK调制
clear;clc;close;
%1.数字信号（基带信号）1000bits
L=1e1;
m=round(rand(1,L));
% m=[1 0 1 1];
Rb=100; %bit/s

%2.两个载波
f=2e3;A1=1;A2=0.5;
fs=10e3;dt=1/fs;T=length(m)/Rb; %T=I（信息量）/Rb
N=fs/Rb;
t=dt:dt:T;  %倍数情况，两头去一头
M=reshape((m'*ones(1,N))',1,length(m)*N);    %使M和y1,y2长度相同
y1=A1*sin(2*pi*f*t);
y2=A2*sin(2*pi*f*t);

%3.调制
s=M.*y1+(-M+1).*y2;

%4.解调，低通滤波
r=s.*y1;    %先要乘载波
lpFilt = designfilt('lowpassiir','FilterOrder',18, ...
         'PassbandFrequency',1.2e3,'PassbandRipple',0.5, ...
         'SampleRate',fs);  %低通滤波器，阶数为28，通带频率4e3，波动0.5，采样频率
fvtool(lpFilt);         %画出滤波器的幅频响应
out = filter(lpFilt,r);

%5.抽样、判决
sig=1*(out>0.4);

subplot(4,2,1)
plot(t,s);

subplot(4,2,3)
plot(t,r);

subplot(4,2,5)
plot(t,out);

subplot(4,2,7)
plot(t,sig);

f=1/T:1/T:fs;
subplot(4,2,2)
plot(f,abs(fft(s)));
xlabel('f(Hz)');xlim([0 fs/2]);

subplot(4,2,4)
plot(f,abs(fft(r)));
xlabel('f(Hz)');xlim([0 fs/2]);

subplot(4,2,6)
plot(f,abs(fft(out)));
xlabel('f(Hz)');xlim([0 fs/2]);

subplot(4,2,8)
plot(f,abs(fft(sig)));
xlabel('f(Hz)');xlim([0 fs/2]);