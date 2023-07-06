function X_random = Generate_CRDSs(X)
% Generate a completely randomized data set: randperm(N)
[N,M] = size(X);
X_random = zeros(N,M);
for m=1:M
    X_random(:,m) =  randsample(X(:,m), N, false);
end
end