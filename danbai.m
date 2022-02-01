%摆角大时不满足单摆运动规律，但可以通过其物理性质来描述
%theta也是有方向的
%因为要画轨迹，所以要建立坐标系
clear;
clc;
k=1;g=10;v(1)=0;theta(1)=pi/2;L=1;dt=0.001;
for t=0:dt:10
    v(k+1)=v(k)+(g*sin(theta(k)))*dt;
    theta(k+1)=theta(k)-v(k)*dt/L;%后一项即dθ
    k=k+1;
end
t=0:dt:10;%因为for语句中t不再是向量，而只是一个数了，所以要再写一遍
figure(1);
plot(t,v(1:length(t)));xlabel('t(s)');ylabel('v(m/s)');
figure(2);
plot(sin(theta),-cos(theta));