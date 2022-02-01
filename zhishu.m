clear;
clc;
%第一个是C语言的做法
% s=[2];
% for n=1:100
%     for m=2:n-1
%         if mod(n,m)==0
%             break;
%         elseif m==n-1
%             s=[s n];
%         end
%     end
% end
% s

%下面这个是matlab中的做法(用向量来操作）
s=[2];
for n=1:100
    m=mod(n,2:n-1);
    if min(m)~=0 %或是 if sum(m~=0)==n-2,即 if m==ones(1,n-2)
        s=[s,n];
    end
end
s