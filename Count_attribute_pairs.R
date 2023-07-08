count_attribute_pairs <- function(x) {
  threshold <- 2
  M <- ncol(x) # Get attribute number of data set
  total <- 0
  resid_count <- 0
  for (m1 in 1:(M-1)) {
    x1 <- x[,m1]
    for (m2 in (m1+1):M) {
      x2 <- x[,m2]
      total <- total + length(unique(x1))*length(unique(x2))
      contingency_table <- table(x1, x2)
      chi_test <- chisq.test(contingency_table, correct = FALSE)
      # see https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/chisq.test
      sr <- sum(abs(chi_test$stdres) >= threshold) # strong positive correlation count
      resid_count <- resid_count + sr
    }
  }
  proportion <- resid_count/total
  return(proportion)
}