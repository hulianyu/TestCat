source("dipsilverman.R")
# if (!require("smacof", quietly = TRUE))
#   install.packages("smacof")
# if (!require("Rtsne", quietly = TRUE))
#   install.packages("Rtsne")
# if (!require("uwot", quietly = TRUE))
#   install.packages("uwot")
library(nomclust) # Hamming/Lin1
library(smacof)# MDS
library(Rtsne) # tSNE
library(uwot)  # UMAP
################### Default parameters ################
# "DIP"
d_simulatepvalue = FALSE
d_reps = 2000
# "SILVERMAN"
s_k = 1
s_m = 999
s_adjust = TRUE
s_digits = 0
s_setseed = 123
RunningTimes = 100
############ Load Load ODS and CRDS files ############
# Get the path of the current working directory's parent directory
parent_dir <- dirname(getwd())
# Get the paths of the subdirectories
sub_dirs <- file.path(parent_dir, c("ODS", "CRDS"))
# Get the paths of TXT files in the subdirectories
txt_paths <- unlist(lapply(sub_dirs, function(x) list.files(x, pattern = "\\.txt$", full.names = TRUE)))
# Read all TXT files
for (txt_path in txt_paths) {
  file_name <- gsub(".txt$", "", basename(txt_path))
  assign(file_name, read.csv(txt_path, header = FALSE, colClasses = "numeric"))}
######################################################

# [1]lenses [2]lung_cancer [3]soybean_small [4]zoo [5]dna_promoter [6]hayes_roth [7]lymphography [8]heart_disease [9]solar_flare
# [10]primary_tumor [11]dermatology [12]house_votes [13]balance_scale [14]credit_approval 
# [15]breast_cancer_wisconsin [16]mammographic_mass [17]tic_tac_toe [18]car
data_obj_list <-c("lenses", "lung_cancer", "soybean_small", "zoo", "dna_promoter", "hayes_roth",
                  "lymphography", "heart_disease", "solar_flare", "primary_tumor", "dermatology", "house_votes", "balance_scale", "credit_approval",
                  "breast_cancer_wisconsin", "mammographic_mass", "tic_tac_toe", "car")

ODSs <- paste("ODS_", data_obj_list, sep = "")
CRDSs <- paste("CRDS_", data_obj_list, sep = "")

##################################################
# ODS | Hamming Distance
##################################################
Results_ODS_Hamming_tSNE_Dip <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_ODS_Hamming_UMAP_Dip <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_ODS_Hamming_MDS_Dip <- matrix(0, nrow = 18, ncol = RunningTimes)

Results_ODS_Hamming_tSNE_Silv <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_ODS_Hamming_UMAP_Silv <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_ODS_Hamming_MDS_Silv <- matrix(0, nrow = 18, ncol = RunningTimes)
##################################################
for (i in 1:18){
  x <- get(ODSs[i])
  N <- nrow(x)
  pt <- min(floor((nrow(x) - 1) / 3), 30)
  dist_hamming = sm(x)
  
  print("ODSs (Hamming)")
  print(i)
  for (r in 1:RunningTimes){
    
    set.seed(r)
    fit1 <- Rtsne(dist_hamming, dims=1, perplexity = pt, is_distance = TRUE)$Y
    # Scale the data
    fit1 <- scale(fit1)
    Results_ODS_Hamming_tSNE_Dip[i,r] <- dip(fit1, d_simulatepvalue, d_reps)$p.value
    Results_ODS_Hamming_tSNE_Silv[i,r] <- silverman(fit1, s_k, s_m, s_adjust, s_digits, s_setseed)$p_value
    
    set.seed(r)
    fit2 <- umap(dist_hamming, n_components=1)
    # Scale the data
    fit2 <- scale(fit2)
    Results_ODS_Hamming_UMAP_Dip[i,r] <- dip(fit2, d_simulatepvalue, d_reps)$p.value
    Results_ODS_Hamming_UMAP_Silv[i,r] <- silverman(fit2, s_k, s_m, s_adjust, s_digits, s_setseed)$p_value
    
    set.seed(r)
    fit3 <- mds(dist_hamming, ndim = 1, type="ordinal", init = "random", ties="secondary")$conf
    # Scale the data
    fit3 <- scale(fit3)
    Results_ODS_Hamming_MDS_Dip[i,r] <- dip(fit3, d_simulatepvalue, d_reps)$p.value
    Results_ODS_Hamming_MDS_Silv[i,r] <- silverman(fit3, s_k, s_m, s_adjust, s_digits, s_setseed)$p_value
  
    }
  
  # write.table(Results_ODS_Hamming_tSNE_Dip, file="Results_ODS_Hamming_tSNE_Dip.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_ODS_Hamming_tSNE_Silv, file="Results_ODS_Hamming_tSNE_Silv.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_ODS_Hamming_UMAP_Dip, file="Results_ODS_Hamming_UMAP_Dip.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_ODS_Hamming_UMAP_Silv, file="Results_ODS_Hamming_UMAP_Silv.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_ODS_Hamming_MDS_Dip, file="Results_ODS_Hamming_MDS_Dip.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_ODS_Hamming_MDS_Silv, file="Results_ODS_Hamming_MDS_Silv.csv", sep=",", col.names=FALSE, row.names=FALSE)
}


##################################################
# CRDS | Hamming Distance
##################################################
Results_CRDS_Hamming_tSNE_Dip <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_CRDS_Hamming_UMAP_Dip <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_CRDS_Hamming_MDS_Dip <- matrix(0, nrow = 18, ncol = RunningTimes)

Results_CRDS_Hamming_tSNE_Silv <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_CRDS_Hamming_UMAP_Silv <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_CRDS_Hamming_MDS_Silv <- matrix(0, nrow = 18, ncol = RunningTimes)
##################################################
for (i in 1:18){
  x <- get(CRDSs[i])
  N <- nrow(x)
  pt <- min(floor((nrow(x) - 1) / 3), 30)
  dist_hamming = sm(x)
  
  print("CRDSs (Hamming)")
  print(i)
  for (r in 1:RunningTimes){
    
    set.seed(r)
    fit1 <- Rtsne(dist_hamming, dims=1, perplexity = pt, is_distance = TRUE)$Y
    # Scale the data
    fit1 <- scale(fit1)
    Results_CRDS_Hamming_tSNE_Dip[i,r] <- dip(fit1, d_simulatepvalue, d_reps)$p.value
    Results_CRDS_Hamming_tSNE_Silv[i,r] <- silverman(fit1, s_k, s_m, s_adjust, s_digits, s_setseed)$p_value
    
    set.seed(r)
    fit2 <- umap(dist_hamming, n_components=1)
    # Scale the data
    fit2 <- scale(fit2)
    Results_CRDS_Hamming_UMAP_Dip[i,r] <- dip(fit2, d_simulatepvalue, d_reps)$p.value
    Results_CRDS_Hamming_UMAP_Silv[i,r] <- silverman(fit2, s_k, s_m, s_adjust, s_digits, s_setseed)$p_value
    
    set.seed(r)
    fit3 <- mds(dist_hamming, ndim = 1, type="ordinal", init = "random", ties="secondary")$conf
    # Scale the data
    fit3 <- scale(fit3)
    Results_CRDS_Hamming_MDS_Dip[i,r] <- dip(fit3, d_simulatepvalue, d_reps)$p.value
    Results_CRDS_Hamming_MDS_Silv[i,r] <- silverman(fit3, s_k, s_m, s_adjust, s_digits, s_setseed)$p_value
    
  }
  
  # write.table(Results_CRDS_Hamming_tSNE_Dip, file="Results_CRDS_Hamming_tSNE_Dip.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_CRDS_Hamming_tSNE_Silv, file="Results_CRDS_Hamming_tSNE_Silv.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_CRDS_Hamming_UMAP_Dip, file="Results_CRDS_Hamming_UMAP_Dip.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_CRDS_Hamming_UMAP_Silv, file="Results_CRDS_Hamming_UMAP_Silv.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_CRDS_Hamming_MDS_Dip, file="Results_CRDS_Hamming_MDS_Dip.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_CRDS_Hamming_MDS_Silv, file="Results_CRDS_Hamming_MDS_Silv.csv", sep=",", col.names=FALSE, row.names=FALSE)
}


##______________________________________________##
##################################################
# ODS | Lin1 Distance
##################################################
Results_ODS_Lin1_tSNE_Dip <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_ODS_Lin1_UMAP_Dip <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_ODS_Lin1_MDS_Dip <- matrix(0, nrow = 18, ncol = RunningTimes)

Results_ODS_Lin1_tSNE_Silv <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_ODS_Lin1_UMAP_Silv <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_ODS_Lin1_MDS_Silv <- matrix(0, nrow = 18, ncol = RunningTimes)
##################################################
for (i in 1:18){
  x <- get(ODSs[i])
  N <- nrow(x)
  pt <- min(floor((nrow(x) - 1) / 3), 30)
  dist_lin1 = lin1(x)
  
  print("ODSs (Lin1)")
  print(i)
  for (r in 1:RunningTimes){
    
    set.seed(r)
    fit1 <- Rtsne(dist_lin1, dims=1, perplexity = pt, is_distance = TRUE)$Y
    # Scale the data
    fit1 <- scale(fit1)
    Results_ODS_Lin1_tSNE_Dip[i,r] <- dip(fit1, d_simulatepvalue, d_reps)$p.value
    Results_ODS_Lin1_tSNE_Silv[i,r] <- silverman(fit1, s_k, s_m, s_adjust, s_digits, s_setseed)$p_value
    
    set.seed(r)
    fit2 <- umap(dist_lin1, n_components=1)
    # Scale the data
    fit2 <- scale(fit2)
    Results_ODS_Lin1_UMAP_Dip[i,r] <- dip(fit2, d_simulatepvalue, d_reps)$p.value
    Results_ODS_Lin1_UMAP_Silv[i,r] <- silverman(fit2, s_k, s_m, s_adjust, s_digits, s_setseed)$p_value
    
    set.seed(r)
    fit3 <- mds(dist_lin1, ndim = 1, type="ordinal", init = "random", ties="secondary")$conf
    # Scale the data
    fit3 <- scale(fit3)
    Results_ODS_Lin1_MDS_Dip[i,r] <- dip(fit3, d_simulatepvalue, d_reps)$p.value
    Results_ODS_Lin1_MDS_Silv[i,r] <- silverman(fit3, s_k, s_m, s_adjust, s_digits, s_setseed)$p_value
    
  }
  
  # write.table(Results_ODS_Lin1_tSNE_Dip, file="Results_ODS_Lin1_tSNE_Dip.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_ODS_Lin1_tSNE_Silv, file="Results_ODS_Lin1_tSNE_Silv.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_ODS_Lin1_UMAP_Dip, file="Results_ODS_Lin1_UMAP_Dip.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_ODS_Lin1_UMAP_Silv, file="Results_ODS_Lin1_UMAP_Silv.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_ODS_Lin1_MDS_Dip, file="Results_ODS_Lin1_MDS_Dip.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_ODS_Lin1_MDS_Silv, file="Results_ODS_Lin1_MDS_Silv.csv", sep=",", col.names=FALSE, row.names=FALSE)
}


##################################################
# CRDS | Lin1 Distance
##################################################
Results_CRDS_Lin1_tSNE_Dip <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_CRDS_Lin1_UMAP_Dip <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_CRDS_Lin1_MDS_Dip <- matrix(0, nrow = 18, ncol = RunningTimes)

Results_CRDS_Lin1_tSNE_Silv <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_CRDS_Lin1_UMAP_Silv <- matrix(0, nrow = 18, ncol = RunningTimes)
Results_CRDS_Lin1_MDS_Silv <- matrix(0, nrow = 18, ncol = RunningTimes)
##################################################
for (i in 1:18){
  x <- get(CRDSs[i])
  N <- nrow(x)
  pt <- min(floor((nrow(x) - 1) / 3), 30)
  dist_lin1 = lin1(x)
  
  print("CRDSs (Lin1)")
  print(i)
  for (r in 1:RunningTimes){
    
    set.seed(r)
    fit1 <- Rtsne(dist_lin1, dims=1, perplexity = pt, is_distance = TRUE)$Y
    # Scale the data
    fit1 <- scale(fit1)
    Results_CRDS_Lin1_tSNE_Dip[i,r] <- dip(fit1, d_simulatepvalue, d_reps)$p.value
    Results_CRDS_Lin1_tSNE_Silv[i,r] <- silverman(fit1, s_k, s_m, s_adjust, s_digits, s_setseed)$p_value
    
    set.seed(r)
    fit2 <- umap(dist_lin1, n_components=1)
    # Scale the data
    fit2 <- scale(fit2)
    Results_CRDS_Lin1_UMAP_Dip[i,r] <- dip(fit2, d_simulatepvalue, d_reps)$p.value
    Results_CRDS_Lin1_UMAP_Silv[i,r] <- silverman(fit2, s_k, s_m, s_adjust, s_digits, s_setseed)$p_value
    
    set.seed(r)
    fit3 <- mds(dist_lin1, ndim = 1, type="ordinal", init = "random", ties="secondary")$conf
    # Scale the data
    fit3 <- scale(fit3)
    Results_CRDS_Lin1_MDS_Dip[i,r] <- dip(fit3, d_simulatepvalue, d_reps)$p.value
    Results_CRDS_Lin1_MDS_Silv[i,r] <- silverman(fit3, s_k, s_m, s_adjust, s_digits, s_setseed)$p_value
    
  }
  
  # write.table(Results_CRDS_Lin1_tSNE_Dip, file="Results_CRDS_Lin1_tSNE_Dip.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_CRDS_Lin1_tSNE_Silv, file="Results_CRDS_Lin1_tSNE_Silv.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_CRDS_Lin1_UMAP_Dip, file="Results_CRDS_Lin1_UMAP_Dip.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_CRDS_Lin1_UMAP_Silv, file="Results_CRDS_Lin1_UMAP_Silv.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_CRDS_Lin1_MDS_Dip, file="Results_CRDS_Lin1_MDS_Dip.csv", sep=",", col.names=FALSE, row.names=FALSE)
  # 
  # write.table(Results_CRDS_Lin1_MDS_Silv, file="Results_CRDS_Lin1_MDS_Silv.csv", sep=",", col.names=FALSE, row.names=FALSE)
}