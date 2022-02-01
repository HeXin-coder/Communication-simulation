%FDMA
clear;
clc;
f1=100;f2=1e3;f3=200;f4=2e3;f5=300;f6=3e3;
fs=6*f6;%fs为采样频率，要大于最大频率的2倍（奈奎斯特定理）采样变成离散的
dt=1/fs;%dt为采样间隔
T=50/f5;
t=0:dt:T;
y1=sin(2*pi*f1*t);  %100Hz
y2=2*sin(2*pi*f2*t);    %1kHz载波
y3=sin(2*pi*f3*t);  %200Hz
y4=2*sin(2*pi*f4*t);    %2kHz载波
y5=sin(2*pi*f5*t);  %300Hz
y6=2*sin(2*pi*f6*t);    %3kHz载波

y_11=y1.*y2;
y_21=y3.*y4;
y_31=y5.*y6;
y=y_11+y_21+y_31;   %三个信号叠加

lpFilt1 = designfilt('lowpassiir','FilterOrder',40, ...
         'PassbandFrequency',1.2e3,'PassbandRipple',0.5, ...
         'SampleRate',fs); 
fvtool(lpFilt1);         %画出滤波器的幅频响应
out_11 = filter(lpFilt1,y);

y_12=out_11.*y2;    %相干解调

lpFilt2 = designfilt('lowpassiir','FilterOrder',40, ...
         'PassbandFrequency',0.8e3,'PassbandRipple',0.5, ...
         'SampleRate',fs);  
fvtool(lpFilt2);         %画出滤波器的幅频响应
out_12 = filter(lpFilt2,y_12);

%绘制时域图
subplot(4,2,1);
plot(t,y_11)
xlim([0 5/f1]);title('信号1与载波相乘后的时域图');

subplot(4,2,3);
plot(t,y)
xlim([0 5/f1]);title('三信号叠加后的时域图');

subplot(4,2,5);
plot(t,y_12)
xlim([0 5/f1]);title('相干解调后的时域图');

subplot(4,2,7);
plot(t,out_12)
xlim([0 5/f1]);title('信号1恢复后的时域图');

%绘制频域图
f=0:1/T:fs;
Y_11=abs(fft(y_11));
subplot(4,2,2);
plot(f,Y_11);xlabel('f(Hz)');
xlim([0 fs/2]);title('信号1与载波相乘后的频域图');

Y=abs(fft(y));
subplot(4,2,4);
plot(f,Y);xlabel('f(Hz)');
xlim([0 fs/2]);title('三信号叠加后的时域图');

Y_12=abs(fft(y_12));
subplot(4,2,6);
plot(f,Y_12);xlabel('f(Hz)');
xlim([0 fs/2]);title('相干解调后的时域图');

Out_12=abs(fft(out_12));
subplot(4,2,8);
plot(f,Out_12);xlabel('f(Hz)');
xlim([0 1e3]);title('信号1恢复后的时域图');