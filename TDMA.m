%分时系统
clear;clc;close all;%关掉所有打开的图
fs=60e3;%采样频率
dt=1/fs;T=10;
t=0:dt:T;A=sin(2*pi*1e3*t);
t=0:dt:T;B=1*(sin(2*pi*2e3*t)>=0);
t=0:dt:T;C=-1*(sin(2*pi*3e3*t)>=0);
TT=[];Y=[];
%合成过程
for k=0:5
%   tt=0:dt:1-dt;y=A(1:length(tt));    
%   tt=0:dt:2-dt;y=B(1:length(tt));
%   tt=0:dt:3-dt;y=C(1:length(tt));
    ttA=3*k:dt:3*k+1-dt;yA=A((k*(length(ttA))+1):(k+1)*length(ttA));    
    ttB=3*k+1:dt:3*k+2-dt;yB=B((k*(length(ttB))+1):(k+1)*length(ttB));
    ttC=3*k+2:dt:3*(k+1)-dt;yC=C((k*(length(ttC))+1):(k+1)*length(ttC));
    TT=[TT ttA ttB ttC];Y=[Y yA yB yC];
end

subplot(4,1,1);plot(TT,Y);xlim([0 20]);title('三信号分时合成后的时域图');

%信号恢复,只已知TT和Y
A=[];B=[];C=[];
for k=0:5
%     A=Y(1:length(ttA));
%     B=Y(length(ttA)+1:length(ttA)+length(ttB));
%     C=Y(length(ttA)+length(ttB)+1:length(ttA)+length(ttB)+length(ttC));
    a=Y((3*k)*length(ttA)+1:(3*k+1)*length(ttA));A=[A a];
    b=Y((3*k+1)*length(ttA)+1:(3*k+2)*length(ttA));B=[B b];
    c=Y((3*k+2)*length(ttA)+1:(3*k+3)*length(ttA));C=[C c];
end
t=0:dt:(k+1)-dt;
subplot(4,1,2);plot(t,A);xlim([0 1e-2]);title('信号1恢复后的时域图');
subplot(4,1,3);plot(t,B);xlim([0 1e-2]);title('信号2恢复后的时域图');
subplot(4,1,4);plot(t,C);xlim([0 1e-2]);title('信号3恢复后的时域图');