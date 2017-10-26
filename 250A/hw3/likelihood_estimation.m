clear all;
close all;
clc;

n = 10;
a = 0.1; %%
Z = 128;
B = zeros(1,n);

figure;

ip = [2,5,8,10];

for p = 1:4
  i=ip(p);  
    tic;
    nSamp = 10;
    for ns = 1:nSamp
        iter = ns*100000;
        numer = 0;
        denom = 0;
        for k = 1:iter
            B = randi(2,1,n) - ones(1,n);
            pr = probZgivenB(Z,B,n,a);
            if(B(i) == 1)
                numer = numer + pr;
            end
            denom = denom + pr;
        end
        probBgivenZ(ns) = numer/denom;
    end
    toc;

    disp(i);
    disp(probBgivenZ(nSamp));
    hold on;
    plot(1:nSamp,probBgivenZ);
    xlabel('Number of samples in millions');
    ylabel('P(Bi = 1 | Z = 128)');
    title(['Convergence plot for i = ' num2str(i)]);
    ylim([0 1]);
end
hold off;
legend('2','5','8','10');

function prob = probZgivenB(Z,B,n,a)
    fB = 0;
    for i = 1:n
        fB = fB + (2^(i-1))*B(i);
    end
    prob = ((1-a)/(1+a))*a^(abs((Z-fB)));
end