clc;
clear all;
close all;

x=-5:0.1:5;
f1 = fx(x);
Q1 = Qxy(x,-2);
Q2 = Qxy(x,3);

% Auxiliary functions
figure;
set(gcf,'color','w');
plot(x,f1,x,Q1,x,Q2);
grid on;
title('Plot of auxiliary functions');
xlabel('x');
ylabel('Function value');
legend('f (x)','Q (x, -2)','Q (x, 3)');

%% Helper functions

% Given function
function op=fx(x)
op = log(cosh(x));
end

% Auxiliary function
function op = Qxy(x, y)
    op = fx(y) + (tanh(y)*(x-y)) + (0.5*(x-y).^2);
end