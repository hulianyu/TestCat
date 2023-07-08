# library(nomclust)
dist4cate <- function(cd, measure) {
  valid_measure <- c("anderberg", "burnaby", "eskin", "gambaryan", "good1",
                     "good2", "good3", "good4", "goodall1", "goodall2",
                     "goodall3", "goodall4", "iof", "lin", "lin1",
                     "of", "sm", "smirnov", "ve", "vm")
  if (measure %in% valid_measure) {
    switch(measure,
           anderberg = anderberg(cd),
           burnaby = burnaby(cd),
           eskin = eskin(cd),
           gambaryan = gambaryan(cd),
           good1 = good1(cd),
           good2 = good2(cd),
           good3 = good3(cd),
           good4 = good4(cd),
           goodall1 = goodall1(cd),
           goodall2 = goodall2(cd),
           goodall3 = goodall3(cd),
           goodall4 = goodall4(cd),
           iof = iof(cd),
           lin = lin(cd),
           lin1 = lin1(cd),
           of = of(cd),
           sm = sm(cd), # Compute Hamming Distance
           smirnov = smirnov(cd),
           ve = ve(cd),
           vm = vm(cd))
  } else {
    cat("Error: Parameter not within the valid range.\n")
    dist4cate <- NULL
  }
}


test4dist<- function(data, test, measure = "sm", d_simulatepvalue = FALSE,
                     d_reps = 2000, s_m = 999, s_adjust = TRUE, s_digits = 0, s_setseed = 123) {
  s_k <- 1
  # Compute 'measure' Distance
  data <- as.vector(dist4cate(data, measure))
  
  # Scale the data
  data <- scale(data)
  
  # Run the test
  if (identical(test, "DIP")) {
    result <- dip(data, d_simulatepvalue, d_reps)$p.value
  } else {
    if (length(unique(data)) == 1){
      result <- 1} else{
        result <- silverman(as.matrix(data), s_k, s_m, s_adjust, s_digits, s_setseed)$p_value}
  }
  return(result)
}
