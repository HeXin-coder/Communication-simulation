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

subplot(2,2,1);%正弦信号时域图
plot(t,y)
xlim([0 5/f]);xlabel('t(s)');

subplot(2,2,2);%方波信号时域图
plot(t,z)
xlim([0 5/f]);xlabel('t(s)');

f1=0:1/T:fs;%与f区分开
Y=abs(fft(y));
subplot(2,2,3);%正弦信号频域图
plot(f1,Y);xlabel('f(Hz)');
xlim([0 fs/2]);%正轴的幅频响应，变成单边谱

Z=abs(fft(z));
subplot(2,2,4);%方波信号频域图
plot(f1,Z);xlabel('f(Hz)');
xlim([0 fs/2]);%正轴的幅频响应，变成单边谱