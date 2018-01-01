clear all;
close all;

%% Read data from files

% Make a list of tokens in vocabulary
tokens.words = textread('Datasets/vocab.txt','%s');

% Counts of each token in corpus of text
tokens.counts = textread('Datasets/unigram.txt','%d');

% Counts of pairs of adjacent words 
[bigram.ind1, bigram.ind2, bigram.count] = textread('Datasets/bigram.txt','%d %d %d');

% Size of vocabulary
N= length(tokens.words);

%% Part a

% ML estimate of unigram distribution
tokens.priors = tokens.counts / sum(tokens.counts);

% Table of tokens starting with "M" with their probabilities
k = 1;
for i = 1:N
    word = tokens.words{i};
    
    % Check if word starts with "M"
    if(word(1) == 'M')
        Word{k} = word;
        Probability{k} = tokens.priors(i);
        k = k+1;
    end
end

Word = Word'; Probability = Probability';

% Make table of the "M" tokens
tokensFromM = table(Word, Probability);
clear Word Probability word k i

%% Part B

% Probability of word "The" in vocabulary
IndexThe = find(strcmp(tokens.words, 'THE'));
CountThe = tokens.counts(IndexThe);
tmpIndex = find(bigram.ind1 == IndexThe);

% Find index of words following "the"
IndexFollowingThe = bigram.ind2(tmpIndex);

% Store words following "the"
k = 1;
for i = 1:length(IndexFollowingThe)
    WordsFollowingThe{k} = tokens.words{IndexFollowingThe(i)};
    k = k+1;
end
WordsFollowingThe = WordsFollowingThe';

% Store bigram counts of words after "the"
CountsFollowingThe = bigram.count(tmpIndex);

% Compute their bigram probabilities
bigramProbThe = CountsFollowingThe / CountThe;

% Sort probabilities and get most likely words
[Probabilities, tmpInd] = sort(bigramProbThe, 'descend');
Words = WordsFollowingThe(tmpInd);

% Make table of top 10 words
BigramTheTop10 = table(Words(1:10), Probabilities(1:10));
clear IndexThe CountThe tmpIndex tmpInd CountsFollowingThe IndexFollowingThe word Words Probabilities i k

%% Part C

% Convert given sentence to upper case 
sentence = upper('The stock market fell by one hundred points last week');

% Log-likelihood under both models
[uLogC, bLogC] = computeSentenceProbabilities(sentence,tokens, bigram);

%% Part D

% Repeat steps from Part C
sentence = upper('The sixteen officials sold fire insurance');
[uLogD, bLogD, pU, pB] = computeSentenceProbabilities(sentence, tokens, bigram);

%% Part E

% Vary lambda
lambda = 0.0001 : 0.0001 : 1;
for i = 1:length(lambda)
    % Weighted interpolation of unigram and bigram models
    pM = lambda(i)*pU + (1-lambda(i))*pB;
    Lm(i) = log(prod(pM));
end

% Plot of log-likelihood vs lambda
plot(lambda, Lm);
set(gcf, 'color', 'w');
grid on;
xlabel('\lambda');
ylabel('L_{m}');
title('Plot of log-likelihood L_{m} vs \lambda');
[Peak, PeakIdx] = findpeaks(Lm);
hold on;
% text(lambda(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))
plot(lambda(PeakIdx),Peak,'r^','markerfacecolor',[1 0 1])
