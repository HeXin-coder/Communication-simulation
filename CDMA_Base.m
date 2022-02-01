%CDMA基础--直接序列扩频 码(Code)分多址
clear;clc;
%1.产生信号
f=1e3;fs=10e3;dt=1/fs;T=20/f;
t=0:dt:T;
x=sin(2*pi*f*t);

f=0:1/T:fs;
subplot(3,2,1);
X=abs(fft(x));
plot(f,X);xlabel('f(Hz)');
xlim([0 fs/2]);ylim([0 100]);

%2.伪随机序列 PN码
L=63;
pn=2*round(rand(1,L))-1;    %round()四舍五入
%rand()，只符合0-1的均匀分布 rand(1,100)表示的是100个符合0-1均匀分布的数

subplot(3,2,2);
plot(abs(fft(pn,2048)));
ylim([0 100]);

%3.直接序列扩频
s=reshape(pn'*x,1,L*length(x));    %(1,63*201)  reshape矩阵形状变换

f=linspace(0,fs,L*(length(x)));Y=abs(fft(s));
subplot(3,2,3);
plot(f,Y);
xlim([0 fs/2]);

%串并转换
ss=reshape(s,L,length(x))'*pn'/L;

%4.加噪声
fn=2e3;tt=linspace(0,T,L*length(x));
n=sin(2*pi*fn*tt);

f=linspace(0,fs*L,L*(length(x)));N=abs(fft(n));%这里采样频率也改变了
subplot(3,2,4);
plot(f,N);
xlim([0 fs/2]);xlabel('f(Hz)');

%叠加噪声
r=s+n;
f=linspace(0,fs*L,L*(length(x)));R=abs(fft(r));%这里采样频率也改变了
subplot(3,2,5);
plot(f,R);
xlim([0 fs/2]);xlabel('f(Hz)');

%5.恢复信号
%r里的每63个乘PN码，然后求平均，连接在一起就是信号恢复
rr=reshape(r,L,length(x))'*pn'/L;   %把噪声平摊在pn码上了
f=0:1/T:fs;RR=abs(fft(rr));
subplot(3,2,6);
plot(f,RR);
xlim([0 fs/2]);xlabel('f(Hz)');

%功率低，不易被窃听