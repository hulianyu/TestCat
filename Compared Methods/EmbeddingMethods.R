source("dipsilverman.R")
# Check if the 'sparsepca' package is already installed
if (!require("sparsepca")) {
  # If not, install the package
  install.packages("sparsepca")
}
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
#### Load Categorical-to-Numerical(CDE+CDCDR) file ####
# Set the path of the specific subdirectory
my_dir <- "Categorical-to-Numerical(CDE+CDCDR)"
# Get the paths of the .txt files in the subdirectory
txt_paths <- list.files(my_dir, pattern = "\\.txt$", recursive = TRUE, full.names = TRUE)
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

ODS_CDE <- paste("ODS_", data_obj_list, "_CDE", sep = "")
CRDS_CDE <- paste("CRDS_", data_obj_list, "_CDE", sep = "")

ODS_CDCDR <- paste("ODS_", data_obj_list, "_CDCDR", sep = "")
CRDS_CDCDR <- paste("CRDS_", data_obj_list, "_CDCDR", sep = "")

################### Results_ODS_CDE ######################
Results_ODS_CDE <- matrix(0, nrow = 18, ncol = 4)
for (i in 1:18){
  print("Results_ODS_CDE:") 
  print(i)
  x <- get(ODS_CDE[i])
  #PCA
  fit1 <- stats::prcomp(x, center = TRUE, scale. = FALSE, retx = TRUE)$x[, 1] 
  Results_ODS_CDE[i,1] <- dip(fit1, d_simulatepvalue, d_reps)$p.value
  Results_ODS_CDE[i,2] <- silverman(fit1, s_k, s_m, s_adjust, s_setseed)$p_value
  #SPCA
  fit2 <- spca(x, k = 1)$scores
  Results_ODS_CDE[i,3] <- dip(fit2, d_simulatepvalue, d_reps)$p.value
  Results_ODS_CDE[i,4] <- silverman(fit2, s_k, s_m, s_adjust, s_setseed)$p_value
}
# write.table(Results_ODS_CDE, file="Results_ODS_CDE.txt", sep=",", col.names=FALSE, row.names=FALSE)
################### Results_CRDS_CDE ######################
Results_CRDS_CDE <- matrix(0, nrow = 18, ncol = 4)
for (i in 1:18){
  print("Results_CRDS_CDE:") 
  print(i)
  x <- get(CRDS_CDE[i])
  #PCA
  fit1 <- stats::prcomp(x, center = TRUE, scale. = FALSE, retx = TRUE)$x[, 1] 
  Results_CRDS_CDE[i,1] <- dip(fit1, d_simulatepvalue, d_reps)$p.value
  Results_CRDS_CDE[i,2] <- silverman(fit1, s_k, s_m, s_adjust, s_setseed)$p_value
  #SPCA
  fit2 <- spca(x, k = 1)$scores
  Results_CRDS_CDE[i,3] <- dip(fit2, d_simulatepvalue, d_reps)$p.value
  Results_CRDS_CDE[i,4] <- silverman(fit2, s_k, s_m, s_adjust, s_setseed)$p_value
}
# write.table(Results_CRDS_CDE, file="Results_CRDS_CDE.txt", sep=",", col.names=FALSE, row.names=FALSE)
################### Results_ODS_CDCDR ######################
Results_ODS_CDCDR <- matrix(0, nrow = 18, ncol = 4)
for (i in 1:18){
  print("Results_ODS_CDCDR:") 
  print(i)
  x <- get(ODS_CDCDR[i])
  #PCA
  fit1 <- stats::prcomp(x, center = TRUE, scale. = FALSE, retx = TRUE)$x[, 1] 
  Results_ODS_CDCDR[i,1] <- dip(fit1, d_simulatepvalue, d_reps)$p.value
  Results_ODS_CDCDR[i,2] <- silverman(fit1, s_k, s_m, s_adjust, s_setseed)$p_value
  #SPCA
  fit2 <- spca(x, k = 1)$scores
  Results_ODS_CDCDR[i,3] <- dip(fit2, d_simulatepvalue, d_reps)$p.value
  Results_ODS_CDCDR[i,4] <- silverman(fit2, s_k, s_m, s_adjust, s_setseed)$p_value
}
# write.table(Results_ODS_CDCDR, file="Results_ODS_CDCDR.txt", sep=",", col.names=FALSE, row.names=FALSE)
################### Results_CRDS_CDCDR ######################
Results_CRDS_CDCDR <- matrix(0, nrow = 18, ncol = 4)
for (i in 1:18){
  print("Results_CRDS_CDCDR:") 
  print(i)
  x <- get(CRDS_CDCDR[i])
  #PCA
  fit1 <- stats::prcomp(x, center = TRUE, scale. = FALSE, retx = TRUE)$x[, 1] 
  Results_CRDS_CDCDR[i,1] <- dip(fit1, d_simulatepvalue, d_reps)$p.value
  Results_CRDS_CDCDR[i,2] <- silverman(fit1, s_k, s_m, s_adjust, s_setseed)$p_value
  #SPCA
  fit2 <- spca(x, k = 1)$scores
  Results_CRDS_CDCDR[i,3] <- dip(fit2, d_simulatepvalue, d_reps)$p.value
  Results_CRDS_CDCDR[i,4] <- silverman(fit2, s_k, s_m, s_adjust, s_setseed)$p_value
}
# write.table(Results_CRDS_CDCDR, file="Results_CRDS_CDCDR.txt", sep=",", col.names=FALSE, row.names=FALSE)