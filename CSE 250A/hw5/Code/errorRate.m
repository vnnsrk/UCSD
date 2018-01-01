function pError = errorRate(x,y,w)
    pred = sigmoid(x*w)>0.5;
    incorrectlyClassified = length(find(pred~=y));
    pError = (incorrectlyClassified/size(x,1))*100;
end