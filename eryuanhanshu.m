clear;
clc;
%C语言的思想
% max=0
% for m=-5:1
%     for n=-5:1
%         s=m^2+n;
%         if s>max
%             max=s;
%             mi=m;ni=n;%记录此时m和n的取值
%         end
%     end
% end
% max
% mi
% ni

%Matalb中的矩阵思想 把m和n做成两个7×7的矩阵
%因为结果会有7×7共49种情况，我们将其放入一个7×7的矩阵中，找最大值
m=-5:1;
n=-5:1;

M=ones(7,1)*m;
N=(ones(7,1)*n)';%也可以写作是n'*ones(1,7)
s=M.^2+N;
max=max(max(s))%需要嵌套一次，因为max求得是每一列的最大值
[x,y]=find(s==max);
mi=m(y)
ni=n(x)