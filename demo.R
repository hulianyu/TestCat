#### Load ODS and CRDS files ####
# Get the path of the current working directory
my_dir <- getwd()
# Get the paths of the subdirectories
sub_dirs <- c("ODS", "CRDS")
# Get the paths of TXT files in the subdirectories
txt_paths <- list.files(sub_dirs, pattern = "\\.txt$", full.names = TRUE)
# Read all TXT files
for (txt_path in txt_paths) {
  file_name <- gsub(".txt$", "", basename(txt_path))
  assign(file_name,  read.csv(txt_path, header=FALSE, colClasses="numeric"))
}
######################################################

# List all data sets
data_obj_list <-c("lenses", "lung_cancer", "soybean_small", "zoo", "dna_promoter", "hayes_roth",
                  "lymphography", "heart_disease", "solar_flare", "primary_tumor", "dermatology", "house_votes", "balance_scale", "credit_approval",
                  "breast_cancer_wisconsin", "mammographic_mass", "tic_tac_toe", "car")
ODSs <- paste("ODS_", data_obj_list, sep = "")
CRDSs <- paste("CRDS_", data_obj_list, sep = "")

######################################################
## Choose I-th ODS and its CRDS
I <- 3
ODS_x <- get(ODSs[I])
CRDS_x <- get(CRDSs[I])

## Run TestCat
source('TestCat.R')
TestCat(ODS_x)
TestCat(CRDS_x)

## Run Count_attribute_pairs
source('Count_attribute_pairs.R')
Count_attribute_pairs(ODS_x)
Count_attribute_pairs(CRDS_x)