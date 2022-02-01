%CDMA与TDMA的结合
%CDMA基础--直接序列扩频 码(Code)分多址
clear;clc;
%1.产生信号
f1=1e3;f2=2e3;f3=3e3;
fs=24e3;dt=1/fs;T=20/f1;
t=0:dt:T;
x1=sin(2*pi*f1*t);
x2=sin(2*pi*f2*t);
x3=sin(2*pi*f3*t);

subplot(6,3,1);
plot(t,x1);title('信号1的时域图');
subplot(6,3,2);
plot(t,x2);title('信号2的时域图');
subplot(6,3,3);
plot(t,x3);title('信号3的时域图');

%2.伪随机序列 PN码
L=63;
pn1=2*round(rand(1,L))-1;    %round()四舍五入
pn2=2*round(rand(1,L))-1;
pn3=2*round(rand(1,L))-1;

%3.直接序列扩频
s1=reshape(pn1'*x1,1,L*length(x1));    %(1,63*201)
s2=reshape(pn2'*x2,1,L*length(x2));
s3=reshape(pn3'*x3,1,L*length(x3));

f=linspace(0,fs,L*(length(x1)));Y1=abs(fft(s1));
subplot(6,3,4);
plot(f,Y1);title('信号1扩频后');
xlim([0 fs/2]);

%4.加噪声
fn=2e3;tt=linspace(0,T,L*length(x1));
n=sin(2*pi*fn*tt);

f=linspace(0,fs*L,L*(length(x1)));N=abs(fft(n));%这里采样频率也改变了
subplot(6,3,7);
plot(f,N);title('噪声');
xlim([0 fs/2]);xlabel('f(Hz)');

%叠加
r=s1+s2+s3+n;
f=linspace(0,fs*L,L*(length(x1)));R=abs(fft(r));%这里采样频率也改变了
subplot(6,3,10);
plot(f,R);title('叠加');
xlim([0 fs/2]);xlabel('f(Hz)');

%5.恢复信号
%r里的每63个乘PN码，然后求平均，连接在一起就是信号恢复
rr1=reshape(r,L,length(x1))'*pn1'/L;   %把噪声平摊在pn码上了
f=0:1/T:fs;RR1=abs(fft(rr1));
subplot(6,3,13);
plot(f,RR1);title('信号1恢复后频域图');
xlim([0 fs/2]);xlabel('f(Hz)');

rr2=reshape(r,L,length(x2))'*pn2'/L;   %把噪声平摊在pn码上了
f=0:1/T:fs;RR2=abs(fft(rr2));
subplot(6,3,14);
plot(f,RR2);title('信号2恢复后频域图');
xlim([0 fs/2]);xlabel('f(Hz)');

rr3=reshape(r,L,length(x3))'*pn3'/L;   %把噪声平摊在pn码上了
f=0:1/T:fs;RR3=abs(fft(rr3));
subplot(6,3,15);
plot(f,RR3);title('信号3恢复后频域图');
xlim([0 fs/2]);xlabel('f(Hz)');

subplot(6,3,16);
plot(t,rr1);title('信号1恢复后时域图');
subplot(6,3,17);
plot(t,rr2);title('信号2恢复后时域图');
subplot(6,3,18);
plot(t,rr3);title('信号3恢复后时域图');