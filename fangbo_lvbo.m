%方波信号-借助正弦函数
clear;
clc;
f=1e3;
fs=20*f; %采样频率
dt=1/fs;
T=50/f;
t=0:dt:T;
y=sin(2*pi*f*t);
% 采用循环-条件
% for k=1:length(y)     %k为数组下标
%     if y(k)>0
%         y(k)=1;
%     else 
%         y(k)=0;
%     end
% end

% 方法2-借助向上取整
z=ceil(0.1*y);

% 方法3-借助条件运算
% z=(y>=0);

lpFilt1 = designfilt('lowpassiir','FilterOrder',28, ...
         'PassbandFrequency',4e3,'PassbandRipple',0.5, ...
         'SampleRate',fs);  %低通滤波器，阶数为28，通带频率4e3，波动0.5，采样频率
fvtool(lpFilt1);         %画出滤波器的幅频响应
out1 = filter(lpFilt1,z);

lpFilt2 = designfilt('lowpassiir','FilterOrder',28, ...
         'PassbandFrequency',6e3,'PassbandRipple',0.5, ...
         'SampleRate',fs);  
fvtool(lpFilt2);         %画出滤波器的幅频响应
out2 = filter(lpFilt2,z);

bpFilt = designfilt('bandpassfir','FilterOrder',30, ...
         'CutoffFrequency1',2e3,'CutoffFrequency2',4e3, ...
         'SampleRate',fs);  %带通滤波器
fvtool(bpFilt);
out3 = filter(bpFilt,z);

subplot(5,2,1);%正弦信号时域图
plot(t,y)
xlim([0 5/f]);xlabel('t(s)');

subplot(5,2,3);%方波信号时域图
plot(t,z)
xlim([0 5/f]);xlabel('t(s)');

subplot(5,2,5);%滤波后信号时域图
plot(t,out1)
xlim([0 5/f]);xlabel('t(s)');

subplot(5,2,7);%滤波后信号时域图
plot(t,out2)
xlim([0 5/f]);xlabel('t(s)');

subplot(5,2,9);%滤波后信号时域图
plot(t,out3)
xlim([0 5/f]);xlabel('t(s)');

f1=0:1/T:fs;%与f区分开
Y=abs(fft(y));
subplot(5,2,2);%正弦信号频域图
plot(f1,Y);xlabel('f(Hz)');
xlim([0 fs/2]);%正轴的幅频响应，变成单边谱

Z=abs(fft(z));
subplot(5,2,4);%方波信号频域图
plot(f1,Z);xlabel('f(Hz)');
xlim([0 fs/2]);%正轴的幅频响应，变成单边谱

Out1=abs(fft(out1));
subplot(5,2,6);%方波滤波后信号频域图
plot(f1,Out1);xlabel('f(Hz)');
xlim([0 fs/2]);%正轴的幅频响应，变成单边谱

Out2=abs(fft(out2));
subplot(5,2,8);%方波滤波后信号频域图
plot(f1,Out2);xlabel('f(Hz)');
xlim([0 fs/2]);%正轴的幅频响应，变成单边谱

Out3=abs(fft(out3));
subplot(5,2,10);%方波滤波后信号频域图
plot(f1,Out3);xlabel('f(Hz)');
xlim([0 fs/2]);%正轴的幅频响应，变成单边谱