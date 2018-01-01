x = -5:0.1:3;
g = 0;

% Find g(x) at various points
for k = 1:10
    g = g + log(cosh(x+(2/sqrt(k))));
end
g=g/10;

% Plot g(x) vs x
figure;
subplot(1,2,1);
plot(x,g);
set(gcf,'color','w');
grid on;
xlabel('x');
ylabel('g(x)');
title('Non-trivial function g(x)');

% Zoom in the minima
subplot(1,2,2);
plot(x,g);
grid on;
xlim([-2.5 0.5]);
xlabel('x');
ylabel('g(x)');
title('Zoomed in plot of g(x)');
