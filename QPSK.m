%BPSK 2psk 二进制相位调制  QPSK 四进制，即四象限
clear;clc;close all;
%1.数字信号（基带信号） 1000bits
L=1e5;
m=round(rand(1,L));
%2.星座图映射
s=(2*m-1)*1i;
% subplot(1,3,1);plot(s,'o'); xlim([-4 4]);ylim([-4 4]);   %scatterplot(s); 画散点图
%3.加噪声，AWGN 加性高斯白噪声
k=1;
for ebn0=-10:5
    sigma=sqrt(1/(2*10^(ebn0/10)));    %σ
    n=sigma*(randn(1,L)+1i*randn(1,L));
    r=s+n;
% subplot(1,3,2);plot(r,'o');xlim([-4 4]);ylim([-4 4]);
%4.判决
    d=1*(imag(r)>0);
%5.计算BER bit error rate 误比特率/误码率
    rate(k)=log10(sum(abs(m-d))/L);
    k=k+1;
end
ebn0=-10:5;
plot(ebn0,rate);grid on;
xlabel('Eb/N0(dB)');ylabel('BER');