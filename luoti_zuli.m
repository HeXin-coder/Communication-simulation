clear;
clc;
H=10;g=10;v0=0;dt=0.001;k=0.05;%k为阻力系数
m=1;v(1)=v0;h(1)=H; a(1)=g;%k是数组/矩阵下标
for t=0:dt:10
    a(m)=g-k*abs(v(m))*v(m);
    %f阻=-k*abs(v)*v，这个公式对v的大小是有限制的,当v很小时,该公式不适用,注意阻力方向始终是与v方向相反的
    v(m+1)=v(m)+a(m)*dt;
    h(m+1)=h(m)-v(m)*dt;
    if h(m+1)<0
        v(m+1)=-v(m); %触地后反弹，此时只有速度方向改变，其他量不变
        h(m+1)=0;
    end
    m=m+1;
end
t=0:dt:10;%因为for语句中t不再是向量，而只是一个数了，所以要再写一遍
figure(1);
plot(t,v(1:length(t)));xlabel('t(s)');ylabel('v(m/s)');
%注意工作区中t与v和h的向量长度不同，所以我们这里需要截断处理
%当阻力系数选取较大时，会观察到图像有一段平线，即当重力与阻力相等时匀速直线运动
figure(2);
plot(t,h(1:length(t)));xlabel('t(s)');ylabel('h(m)');
%xlabel和ylabel给横纵坐标打标签，即所代表物理含义及单位