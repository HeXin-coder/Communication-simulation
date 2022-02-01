%检索题，群举法（不同于我们此前所采用的列方程）
clear;clc;
v=1000;x=1000;y=200;h(1)=0;k=1;g=10;
dtheta=0.0001;
b=[];
T=[];
for theta=0:dtheta:pi/2
    v1=v*sin(theta);
    v2=v*cos(theta);
    t=x/v2;
    h(k+1)=v1*t-0.5*g*t^2;
    if ((h(k+1)-200)*(h(k)-200))<0
        b=[b theta];
        T=[T,t];
    end
    k=k+1;
end
dt=1e-4;
theta=b(1,1);
t=0:dt:T(1,1);
x=v.*cos(theta).*t;
y=v.*sin(theta).*t-0.5.*g.*t.*t;
subplot(1,2,1);plot(x,y);
xlabel('x(m)');ylabel('y(m)');
theta=b(1,2);
t=0:dt:T(1,2);
x=v.*cos(theta).*t;
y=v.*sin(theta).*t-0.5.*g.*t.*t;
subplot(1,2,2);plot(x,y);
xlabel('x(m)');ylabel('y(m)');