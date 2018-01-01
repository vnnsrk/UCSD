clc;
clear all;
close all;

% Testing the stability of the Newton update rule for different values
iter = 10;

x1(1) = -2;
for n=2:iter
    x1(n) = x1(n-1) - (tanh(x1(n-1))/(sech(x1(n-1)))^2);
end

x2(1) = 3;
for n=2:iter
    x2(n) = x2(n-1) - (tanh(x2(n-1))/(sech(x2(n-1)))^2);
end

% Convergence plot
figure;
set(gcf,'color','w');
plot(1:iter,x1);
hold on;
plot(1:3,x2(1:3));
hold off;
grid on;
title('Convergence plot for the Newton method update of f(x)');
xlabel('iteration n');
ylabel('x_{n}');
legend('x_{0} = -2', 'x_{0} = 3');

% upper boubd ob x0 for convergence of Newton method
x0 = -5:0.001:5;
f = abs(x0 - (tanh(x0)./(sech(x0)).^2));

% Estimate of x0 for convergence of Newton method
figure;
set(gcf,'color','w');
plot(x0,abs(x0),x0,f);
grid on;
ylim([0 1.5]);
xlabel('x_{0}');
legend('|x_{0}|','|x_{0} - tanh(x_{0})/sech^{2}(x_{0})|');
title('Value of x0 for convergence of Newton method');