clc;
close all;
clear all;

% Read example datasets
n=23;

% X
tempX = textread('data/spectX.txt','%d');
for t=1:length(tempX)/n
    X(t,:) = tempX(n*(t-1)+1:n*t);
end
clear tempX t

% Y
y=textread('data/spectY.txt','%d');

% Number of examples
T = length(y);

%% EM

iter = 256;
p = 0.05*ones(1,n);

% Number of inputs with xi=1
Tk = zeros(1,n);
for i=1:n
    for t=1:T
        if(X(t,i)==1)
            Tk(i) = Tk(i) + 1;
        end
    end
end

% Iterative EM algorithm from here..
L = zeros(1,iter+1);
M = zeros(1,iter+1);
for k=1:iter
    
    % Log-likelihood
    for t=1:T
        temp1 = 0; temp2 = 1;
        for i =1:n
            % First term in expression
            temp1 = temp1 +(X(t,i)*(log(1-p(i))));
            % Second term
            temp2 = temp2 *((1-p(i))^X(t,i));
        end
        L(k) = L(k) + ((1-y(t))*temp1) +(y(t)*(log(1-temp2)));
    end
    L(k) = L(k)/T;
    
    % Mistakes
    pr = zeros(T,1);
    for t=1:T
        tp=1;
        for i=1:n
            tp=tp*((1-p(i))^X(t,i));
        end
        pr(t)=1-tp;
        if(((y(t)==0)&&(pr(t)>=0.5)) || ((y(t)==1) && (pr(t)<0.5)))
            M(k) = M(k) + 1;
        end
    end
    
    % E-Step
    post = zeros(T,n);
    for t=1:T
        % Computing product term in denominator
        tp=1;
        for j=1:n
            tp=tp*((1-p(j))^X(t,j));
        end
        
        % Compute posterior probability
        for i=1:n
            post(t,i) = (y(t)*X(t,i)*p(i))/(1-tp);
        end
    end
    
    % M-step
    for i = 1:n
        % Compute denominator term
        tDen = 0;
        for t=1:T
            tDen = tDen + post(t,i);
        end
        % update pi's
        p(i) = (1/Tk(i))*(tDen);
    end
    

end

k=k+1;
 % Log-likelihood
for t=1:T
    temp1 = 0; temp2 = 1;
    for i =1:n
        % First term in expression
        temp1 = temp1 +(X(t,i)*(log(1-p(i))));
        % Second term
        temp2 = temp2 *((1-p(i))^X(t,i));
    end
    L(k) = L(k) + ((1-y(t))*temp1) +(y(t)*(log(1-temp2)));
end
L(k) = L(k)/T;

% Mistakes
pr = zeros(T,1);
for t=1:T
    tp=1;
    for i=1:n
        tp=tp*((1-p(i))^X(t,i));
    end
    pr(t)=1-tp;
    if(((y(t)==0)&&(pr(t)>=0.5)) || ((y(t)==1) && (pr(t)<0.5)))
        M(k) = M(k) + 1;
    end
end
        