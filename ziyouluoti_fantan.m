clear;
clc;
H=10;g=10;v0=0;dt=0.1;
k=1;v(1)=v0;h(1)=H; %k是数组/矩阵下标
for t=0:dt:10
    v(k+1)=v(k)+g*dt;
    h(k+1)=h(k)-v(k)*dt;
    if h(k+1)<0
        v(k+1)=-v(k); %触地后反弹，此时只有速度方向改变，其他量不变
    end
    k=k+1;
end
t=0:dt:10;%因为for语句中t不再是向量，而只是一个数了，所以要再写一遍
figure(1);
plot(t,v(1:length(t)));xlabel('t(s)');ylabel('v(m/s)');
%注意工作区中t与v和h的向量长度不同，所以我们这里需要截断处理
figure(2);
plot(t,h(1:length(t)));xlabel('t(s)');ylabel('h(m)');
%xlabel和ylabel给横纵坐标打标签，即所代表物理含义及单位