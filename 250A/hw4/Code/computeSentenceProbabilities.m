%% Function to compute probability of sentence
% Compute probability of words in a sentence using unigram and bigram
% models

function [uLog, bLog, pU, pB] = computeSentenceProbabilities(sentence, tokens, bigram)
    % Make array of words in sentence
    wordsU = strsplit(sentence);
    beginSent = {'<s>'};
    wordsB = [beginSent wordsU];
    
    % Log-likelihood using unigram model
    pWords = 1;
    for i = 1:length(wordsU)
        tmpInd = find(strcmp(tokens.words, wordsU{i}));
        
        % If word not in vocab, assign "unknown" token
        if(isempty(tmpInd))
            tmpInd = 1;
        end
        
        pU(i) = tokens.priors(tmpInd);
        % Compute unigram probability 
        pWords = pWords* pU(i);
    end
    uLog = log(pWords);
    
    % Log-likelihood using bigram model
    pWords = 1;
    for i = 2:length(wordsB)
        w1 = wordsB{i-1};
        w2 = wordsB{i};
        
        % Find index of adjacent words
        ind1 = find(strcmp(tokens.words, w1));
        
        if(isempty(tmpInd))
            ind1 = 1;
        end
        ind2 = find(strcmp(tokens.words, w2));
        if(isempty(tmpInd))
            ind2 = 1;
        end
        
        cnt = 0;
        
        % Find counts of this pair
        for j = 1:length(bigram.count)
            if((bigram.ind1(j) == ind1) && (bigram.ind2(j) == ind2))
                cnt = bigram.count(j);
                break;
            end
        end
        
        % Compute bigram probability
        pB(i-1) = (cnt / tokens.counts(ind1));
        pWords = pWords*pB(i-1);
    end
    bLog = log(pWords);
end