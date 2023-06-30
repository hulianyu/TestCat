TestCat <- function(x) {
  
  # Get attribute number of data set
  M <- ncol(x)
  
  # Initializing degrees of freedom and chi-square statistic
  dfs <- 0 # Degrees of freedom
  chis <- 0 
  for (m1 in 1:(M-1)) {
    x1 <- x[,m1]
    for (m2 in (m1+1):M) {
      x2 <- x[,m2]
      df <- (length(unique(x1))-1)*(length(unique(x2))-1)
      contingency_table <- table(x1, x2)
      chi_test <- chisq.test(contingency_table, correct = FALSE)
      chi_squared <- unname(chi_test$statistic)
      dfs <- dfs + df
      chis <- chis + chi_squared
    }
  }
  pval <- unname(pchisq(chis, dfs, lower.tail = FALSE))
  return(pval)
}