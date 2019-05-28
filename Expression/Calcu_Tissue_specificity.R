################
# (0) function
################

tau <- function(x){
  if(any(is.na(x))) stop('NA\'s need to be 0.')
  if(any(x<0)) stop('Negative input values not permitted.')
  t <- sum(1-x/max(x)) / (length(x)-1)
  return(round(t, 2))
}


################
# (1) load data
################
rm(list = ls())
argv <- commandArgs(TRUE)
infile <- argv[1]
outfile <- argv[2]

Expr0 <- read.delim(infile, row.names = 1)

# convert data.frame to matrix
Expr0 <- as.matrix(Expr0)

################
# (2) convert VST to log2(VST)
################
# VST < 1 was set to log2(VST) = 0 and convert VST to log2(VST)
Expr1 <- ifelse(Expr0 < 1, 0, log2(Expr0))

################
# (3) genes with log2(VST) = 0 in all samples were removed.
################
samples_number <- dim(Expr1)[2]
Expr1 <- Expr1[rowSums(Expr1 == 0) < samples_number,]

################
# (4) Tissue specificity index
################

tau_value <- apply(Expr1, 1, tau)

################
# (5) save the results
################
tau_value <- data.frame(tau = tau_value)
write.table(tau_value, outfile, quote = FALSE, col.names = FALSE, sep = "\t")
