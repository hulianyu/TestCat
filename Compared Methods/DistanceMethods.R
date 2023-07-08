source("dipsilverman.R")
source("dist4cate.R") # functions: "dist4cate" "test4dist"
library(nomclust)
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
# ODS
##################################################
Results_ODS_Distances <- matrix(0, nrow = 40, ncol = 18)
for (i in 1:18){
  x <- get(ODSs[i])
  print("Results_ODS_Distances:")
  print(i)

  Results_ODS_Distances[1,i] <- test4dist(x, "DIP", measure = "anderberg" ) 
  Results_ODS_Distances[2,i] <- test4dist(x, "DIP", measure = "burnaby" ) 
  Results_ODS_Distances[3,i] <- test4dist(x, "DIP", measure = "eskin") 
  Results_ODS_Distances[4,i] <- test4dist(x, "DIP", measure = "gambaryan") 
  Results_ODS_Distances[5,i] <- test4dist(x, "DIP", measure = "good1") 
  Results_ODS_Distances[6,i] <- test4dist(x, "DIP", measure = "good2") 
  Results_ODS_Distances[7,i] <- test4dist(x, "DIP", measure = "good3") 
  Results_ODS_Distances[8,i] <- test4dist(x, "DIP", measure = "good4") 
  Results_ODS_Distances[9,i] <- test4dist(x, "DIP", measure = "goodall1") 
  Results_ODS_Distances[10,i] <- test4dist(x, "DIP", measure = "goodall2") 
  Results_ODS_Distances[11,i] <- test4dist(x, "DIP", measure = "goodall3") 
  Results_ODS_Distances[12,i] <- test4dist(x, "DIP", measure = "goodall4") 
  Results_ODS_Distances[13,i] <- test4dist(x, "DIP", measure = "iof") 
  Results_ODS_Distances[14,i] <- test4dist(x, "DIP", measure = "lin") 
  Results_ODS_Distances[15,i] <- test4dist(x, "DIP", measure = "lin1") 
  Results_ODS_Distances[16,i] <- test4dist(x, "DIP", measure = "of") 
  Results_ODS_Distances[17,i] <- test4dist(x, "DIP", measure = "sm") 
  Results_ODS_Distances[18,i] <- test4dist(x, "DIP", measure = "smirnov") 
  Results_ODS_Distances[19,i] <- test4dist(x, "DIP", measure = "ve") 
  Results_ODS_Distances[20,i] <- test4dist(x, "DIP", measure = "vm") 
  
  Results_ODS_Distances[21,i] <- test4dist(x, "SILVERMAN", measure = "anderberg")
  Results_ODS_Distances[22,i] <- test4dist(x, "SILVERMAN", measure = "burnaby")
  Results_ODS_Distances[23,i] <- test4dist(x, "SILVERMAN", measure = "eskin")
  Results_ODS_Distances[24,i] <- test4dist(x, "SILVERMAN", measure = "gambaryan")
  Results_ODS_Distances[25,i] <- test4dist(x, "SILVERMAN", measure = "good1")
  Results_ODS_Distances[26,i] <- test4dist(x, "SILVERMAN", measure = "good2")
  Results_ODS_Distances[27,i] <- test4dist(x, "SILVERMAN", measure = "good3")
  Results_ODS_Distances[28,i] <- test4dist(x, "SILVERMAN", measure = "good4")
  Results_ODS_Distances[29,i] <- test4dist(x, "SILVERMAN", measure = "goodall1")
  Results_ODS_Distances[30,i] <- test4dist(x, "SILVERMAN", measure = "goodall2")
  Results_ODS_Distances[31,i] <- test4dist(x, "SILVERMAN", measure = "goodall3")
  Results_ODS_Distances[32,i] <- test4dist(x, "SILVERMAN", measure = "goodall4")
  Results_ODS_Distances[33,i] <- test4dist(x, "SILVERMAN", measure = "iof")
  Results_ODS_Distances[34,i] <- test4dist(x, "SILVERMAN", measure = "lin")
  Results_ODS_Distances[35,i] <- test4dist(x, "SILVERMAN", measure = "lin1")
  Results_ODS_Distances[36,i] <- test4dist(x, "SILVERMAN", measure = "of")
  Results_ODS_Distances[37,i] <- test4dist(x, "SILVERMAN", measure = "sm")
  Results_ODS_Distances[38,i] <- test4dist(x, "SILVERMAN", measure = "smirnov")
  Results_ODS_Distances[39,i] <- test4dist(x, "SILVERMAN", measure = "ve")
  Results_ODS_Distances[40,i] <- test4dist(x, "SILVERMAN", measure = "vm")
}  
  
  # write.table(Results_ODS_Distances, file="Results_ODS_Distances.txt", sep=",", col.names=FALSE, row.names=FALSE)

##################################################
# CRDS
##################################################
Results_CRDS_Distances <- matrix(0, nrow = 40, ncol = 18)
 for (i in 1:18){
    x <- get(CRDSs[i])
    print("Results_CRDS_Distances:")
    print(i)
    
    Results_CRDS_Distances[1,i] <- test4dist(x, "DIP", measure = "anderberg") 
    Results_CRDS_Distances[2,i] <- test4dist(x, "DIP", measure = "burnaby") 
    Results_CRDS_Distances[3,i] <- test4dist(x, "DIP", measure = "eskin") 
    Results_CRDS_Distances[4,i] <- test4dist(x, "DIP", measure = "gambaryan") 
    Results_CRDS_Distances[5,i] <- test4dist(x, "DIP", measure = "good1") 
    Results_CRDS_Distances[6,i] <- test4dist(x, "DIP", measure = "good2") 
    Results_CRDS_Distances[7,i] <- test4dist(x, "DIP", measure = "good3") 
    Results_CRDS_Distances[8,i] <- test4dist(x, "DIP", measure = "good4") 
    Results_CRDS_Distances[9,i] <- test4dist(x, "DIP", measure = "goodall1") 
    Results_CRDS_Distances[10,i] <- test4dist(x, "DIP", measure = "goodall2") 
    Results_CRDS_Distances[11,i] <- test4dist(x, "DIP", measure = "goodall3") 
    Results_CRDS_Distances[12,i] <- test4dist(x, "DIP", measure = "goodall4") 
    Results_CRDS_Distances[13,i] <- test4dist(x, "DIP", measure = "iof") 
    Results_CRDS_Distances[14,i] <- test4dist(x, "DIP", measure = "lin") 
    Results_CRDS_Distances[15,i] <- test4dist(x, "DIP", measure = "lin1") 
    Results_CRDS_Distances[16,i] <- test4dist(x, "DIP", measure = "of") 
    Results_CRDS_Distances[17,i] <- test4dist(x, "DIP", measure = "sm") 
    Results_CRDS_Distances[18,i] <- test4dist(x, "DIP", measure = "smirnov") 
    Results_CRDS_Distances[19,i] <- test4dist(x, "DIP", measure = "ve") 
    Results_CRDS_Distances[20,i] <- test4dist(x, "DIP", measure = "vm") 
    
    Results_CRDS_Distances[21,i] <- test4dist(x, "SILVERMAN", measure = "anderberg")
    Results_CRDS_Distances[22,i] <- test4dist(x, "SILVERMAN", measure = "burnaby")
    Results_CRDS_Distances[23,i] <- test4dist(x, "SILVERMAN", measure = "eskin")
    Results_CRDS_Distances[24,i] <- test4dist(x, "SILVERMAN", measure = "gambaryan")
    Results_CRDS_Distances[25,i] <- test4dist(x, "SILVERMAN", measure = "good1")
    Results_CRDS_Distances[26,i] <- test4dist(x, "SILVERMAN", measure = "good2")
    Results_CRDS_Distances[27,i] <- test4dist(x, "SILVERMAN", measure = "good3")
    Results_CRDS_Distances[28,i] <- test4dist(x, "SILVERMAN", measure = "good4")
    Results_CRDS_Distances[29,i] <- test4dist(x, "SILVERMAN", measure = "goodall1")
    Results_CRDS_Distances[30,i] <- test4dist(x, "SILVERMAN", measure = "goodall2")
    Results_CRDS_Distances[31,i] <- test4dist(x, "SILVERMAN", measure = "goodall3")
    Results_CRDS_Distances[32,i] <- test4dist(x, "SILVERMAN", measure = "goodall4")
    Results_CRDS_Distances[33,i] <- test4dist(x, "SILVERMAN", measure = "iof")
    Results_CRDS_Distances[34,i] <- test4dist(x, "SILVERMAN", measure = "lin")
    Results_CRDS_Distances[35,i] <- test4dist(x, "SILVERMAN", measure = "lin1")
    Results_CRDS_Distances[36,i] <- test4dist(x, "SILVERMAN", measure = "of")
    Results_CRDS_Distances[37,i] <- test4dist(x, "SILVERMAN", measure = "sm")
    Results_CRDS_Distances[38,i] <- test4dist(x, "SILVERMAN", measure = "smirnov")
    Results_CRDS_Distances[39,i] <- test4dist(x, "SILVERMAN", measure = "ve")
    Results_CRDS_Distances[40,i] <- test4dist(x, "SILVERMAN", measure = "vm")
 }  
  
  # write.table(Results_CRDS_Distances, file="Results_CRDS_Distances.txt", sep=",", col.names=FALSE, row.names=FALSE)