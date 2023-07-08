clearvars
addpath([cd '/']);
addpath([cd '/ODS']);
addpath([cd '/CRDS']);
filename = char('lenses','lung_cancer','soybean_small','zoo','dna_promoter','hayes_roth',...
    'lymphography','heart_disease','solar_flare','primary_tumor','dermatology','house_votes',...
    'balance_scale','credit_approval','breast_cancer_wisconsin','mammographic_mass','tic_tac_toe','car');

%% Choose I-th ODS and its CRDS
I = 3; 
ODS_X = load(['ODS_', strtrim(filename(I,:)), '.txt']); %Load I-th ODS
CRDS_X = load(['CRDS_', strtrim(filename(I,:)), '.txt']); %Load I-th CRDS

%% Run TestCat.m
Clusterability_ODS_X = TestCat(ODS_X);
Clusterability_CRDS_X = TestCat(CRDS_X);

%% Run Count_attribute_pairs.m
[Correlated_pairs_ODS,total,Full_list_ODS] = count_attribute_pairs(ODS_X);
Proportion_ODS = Correlated_pairs_ODS/total;
[Correlated_pairs_CRDS,total,Full_list_CRDS] = count_attribute_pairs(CRDS_X);
Proportion_CRDS = Correlated_pairs_CRDS/total;
