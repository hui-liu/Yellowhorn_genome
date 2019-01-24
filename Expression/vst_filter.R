# working dir
remove(list = ls())
setwd("/mnt/spruce/data/yellow_horn/Expression")

# load data
Expr0 <- read.delim("xso_exp_VST_mean.txt", row.names = 1)

# remove non-varying genes
# mad: Median Absolute Deviation
m.mad <- apply(Expr0, 1, mad)
Expr1 <- Expr0[m.mad > 0,]

#write out
write.table(t(Expr1), file = 'data/xso_expr_mat.txt', sep = '\t', quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(row.names(Expr1), file = 'data/xso_genes.txt', sep = '\t', quote = FALSE, row.names = FALSE, col.names = FALSE)
