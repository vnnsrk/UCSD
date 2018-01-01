close all;
clear all;

dd = 64;

temp3 = textread('../Data/train3.txt','%d');
for t = 1:length(temp3)/(dd)
    train3(t,:) = temp3(dd*(t-1)+1:dd*t);
end

temp5 = textread('../Data/train5.txt','%d');
for t = 1:length(temp5)/(dd)
    train5(t,:) = temp5(dd*(t-1)+1:dd*t);
end

x = [train3; train5];
y= [zeros(size(train3,1),1); ones(size(train5,1),1)];
T=length(y);

clear temp3 temp5 t

%% Gradient ascent

w = randn(dd,1);
iter = 20000;
eta = 0.02/T;

for i = 1:iter
    p=sigmoid(x*w);
    grad = x'*(y-p);
    w=w+(eta*grad);
    L(i) = sum((y.*log(p))+((1-y).*log(1-p)));
end

w_opt = reshape(w,[8 8]);

figure;
set(gcf,'color','w');
plot(1:iter,L);
grid on;
xlabel('Iteration');
ylabel('Log-likelihood');
title('Convergence of log-likelihood');

clear eta grad i iter L p T

%% Testing

temp3 = textread('../Data/test3.txt','%d');
for t = 1:length(temp3)/(dd)
    test3(t,:) = temp3(dd*(t-1)+1:dd*t);
end

temp5 = textread('../Data/test5.txt','%d');
for t = 1:length(temp5)/(dd)
    test5(t,:) = temp5(dd*(t-1)+1:dd*t);
end

xt = [test3;test5];
yt = [zeros(size(test3,1),1); ones(size(test5,1),1)];
clear temp3 temp5 t

%% Error rates

% Train errors
trainError3 = errorRate(train3, zeros(size(train3, 1), 1), w);
trainError5 = errorRate(train5, ones(size(train5, 1), 1), w);
overallTrainError = errorRate(x, y, w);

% Test errors
testError3 = errorRate(test3, zeros(size(test3, 1), 1), w);
testError5 = errorRate(test5, ones(size(test5, 1), 1), w);
overallTestError = errorRate(xt, yt, w);