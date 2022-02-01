%幅度调制
clear;
clc;
f1=1e3;f2=4e3;
fs=6*f2;%fs为采样频率，要大于最大频率的2倍（奈奎斯特定理）采样变成离散的
dt=1/fs;%dt为采样间隔
T=50/f1;%10/f1表示十个周期.50/f1表示采样了五十个周期
t=0:dt:T;
y1=sin(2*pi*f1*t);
y2=2*sin(2*pi*f2*t);
y=y1.*y2;
y3=y.*y2;

lpFilt = designfilt('lowpassiir','FilterOrder',28, ...
         'PassbandFrequency',4e3,'PassbandRipple',0.5, ...
         'SampleRate',fs);  %低通滤波器，阶数为28，通带频率4e3，波动0.5，采样频率
fvtool(lpFilt);         %画出滤波器的幅频响应
Out = filter(lpFilt,y3);

%原信号
subplot(3,2,1);
plot(t,y1)%时域图
xlim([0 10/f1]);
f=0:1/T:fs;%频谱时间间隔，当T无限大时便是连续谱
Y1=abs(fft(y1));%幅频响应 fft(y1)结果是复频域上的图
subplot(3,2,2);
plot(f,Y1);xlabel('f(Hz)');%y轴没有绝对的物理意义
xlim([0 fs/2]);%正轴的幅频响应，变成单边谱

%载波后
subplot(3,2,3);
plot(t,y)%时域图
xlim([0 10/f1]);
f=0:1/T:fs;%频谱时间间隔，当T无限大时便是连续谱
Y2=abs(fft(y));%幅频响应 fft(y1)结果是复频域上的图
subplot(3,2,4);
plot(f,Y2);xlabel('f(Hz)');%y轴没有绝对的物理意义
xlim([0 fs/2]);%正轴的幅频响应，变成单边谱

%滤波后
subplot(3,2,5);
plot(t,Out)%时域图
xlim([0 10/f1]);
f=0:1/T:fs;%频谱时间间隔，当T无限大时便是连续谱
Y3=abs(fft(Out));%幅频响应 fft(y1)结果是复频域上的图
subplot(3,2,6);
plot(f,Y3);xlabel('f(Hz)');%y轴没有绝对的物理意义
xlim([0 fs/2]);%正轴的幅频响应，变成单边谱