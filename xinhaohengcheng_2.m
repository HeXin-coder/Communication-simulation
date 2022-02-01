clear;
clc;
f1=1e3;f2=4e3;
fs=6*f2;%fs为采样频率，要大于最大频率的2倍（奈奎斯特定理）采样变成离散的
dt=1/fs;%dt为采样间隔
T=50/f1;%10/f1表示十个周期.50/f1表示采样了五十个周期
t=0:dt:T;
y1=sin(2*pi*f1*t);
y2=2*sin(2*pi*f2*t);
y=y1+y2;%合成信号，先合成后做傅里叶变换
subplot(2,1,1);%画子图，2行一列的第一张图
plot(t,y)%时域图
xlim([0 10/f1]);
f=0:1/T:fs;%频谱时间间隔，当T无限大时便是连续谱
Y=abs(fft(y));%幅频响应 fft(y1)结果是复频域上的图
subplot(2,1,2);
plot(f,Y);xlabel('f(Hz)');%y轴没有绝对的物理意义
xlim([0 fs/2]);%正轴的幅频响应，变成单边谱


%一个系统里采样频率只能有一个！！！