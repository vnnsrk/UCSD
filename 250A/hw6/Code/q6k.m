clc;
clear;
close all;
iter = 70;

% Convergence of update rule
x1(1) = -2;
for n=2:iter
    temp=0;
    for k=1:10
        temp=temp+tanh(x1(n-1)+(2/sqrt(k)));
    end
    x1(n) = x1(n-1) - ((1/10)*temp);
end

% convergence plot
figure;
set(gcf,'color','w');
plot(1:iter,x1);
grid on;
title('Convergence plot for g(x) with x_{0} = -2');
xlabel('iteration n');
ylabel('x_{n}');