clear;
clc;
s=[];
for n=1:100
    if mod(n,2)==0
        s=[s n];
    end
end
s