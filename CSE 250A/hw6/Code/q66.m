clc;
clear all;
close all;

iter = 10;

% With initial guess x=-2
x1(1) = -2;
for n=2:iter
    x1(n) = x1(n-1) - tanh(x1(n-1));
end

% With initial guess x=3
x2(1) = 3;
for n=2:iter
    x2(n) = x2(n-1) - tanh(x2(n-1));
end

% Convergence plot
figure;
set(gcf,'color','w');
plot(1:iter,x1,1:iter,x2);
grid on;
title('Convergence plot for update rule of f(x)');
xlabel('iteration n');
ylabel('x_{n}');
legend('x_{0} = -2', 'x_{0} = 3');