# working dir
remove(list = ls())
setwd("/mnt/spruce/data/yellow_horn/Expression")

# load libraries
library("reshape2")

# load data
vst <- read.delim("xso_exp_VST_mean.txt")

# long to wide
vst_dataset <- melt(vst)
# names(vst_dataset) <- c("gene", "sample", "vst")
write.table(vst_dataset, file = 'xso_vst_dataset.txt', sep = '\t', quote = FALSE, row.names = FALSE, col.names = FALSE)
