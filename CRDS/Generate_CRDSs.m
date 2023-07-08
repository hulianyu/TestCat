addpath('..\ODS');
filename = char('lenses','lung_cancer','soybean_small','zoo','dna_promoter','hayes_roth',...
    'lymphography','heart_disease','solar_flare','primary_tumor','dermatology','house_votes',...
    'balance_scale','credit_approval','breast_cancer_wisconsin','mammographic_mass','tic_tac_toe','car');

I = 3; % Choose I-th ODS
ODS_X = load(['ODS_', strtrim(filename(I,:)), '.txt']); %Load I-th ODS
CRDS_X =  Generate_CRDS(ODS_X);


function X_random = Generate_CRDS(X) % X is a ODS
[N,M] = size(X);
X_random = zeros(N,M);
for m=1:M
    % Generate a completely randomized data set by using m-th permutation
    X_random(:,m) =  randsample(X(:,m), N, false);
end
end