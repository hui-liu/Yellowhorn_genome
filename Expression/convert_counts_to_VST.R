# working dir
remove(list = ls())
setwd("/mnt/spruce/data/yellow_horn/Expression")

# Load libraries
library("DESeq2")
library("limma")

# dir
directory <- '/mnt/spruce/data/yellow_horn/Expression/htseq_count/'

# Use grep to search for the 'count' part of filename to collect files
sampleFiles <- grep('count',list.files(directory),value=TRUE)
sampleFiles_prefix  <- gsub(".count","",sampleFiles)

# sample design
sample_design <- read.delim("sample_design.txt")

# set sampleConditions and sampleTable for experimental conditions
sampleCondition <- c(sampleFiles)

sampleTable <- data.frame(sampleName = sampleFiles_prefix,
                          fileName = sampleFiles)
sampleTable <- merge(sampleTable, sample_design, by.x = 'sampleName', by.y = 'sample')

#
ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable=sampleTable, directory=directory, design=~condition)
#
dds <- DESeq(ddsHTSeq)

# calculate variance Stabilizing Transformation values from above DESeq results
library(stats)
vst <- varianceStabilizingTransformation(dds)
# vst <- vst(dds)
vst <- assay(vst)

# plot density
pdf(file="xso_exp_VST_density.pdf", height=8, width=8)
plot(density(vst))
dev.off()

#write out -- for construct network
vst_out <- cbind(gene = rownames(vst), vst)
write.table(vst_out, file = 'xso_exp_VST.txt', sep = '\t', quote = FALSE, row.names = FALSE)


# calculate averrage vst of replicates per sample
colnames(vst) <- gsub('_[0-9]$', '', colnames(vst))
vst_mean <- avearrays(vst)

#write out -- for expression tools
vst_mean <- cbind(gene = rownames(vst_mean), vst_mean)
write.table(vst_mean, file = 'xso_exp_VST_mean.txt', sep = '\t', quote = FALSE, row.names = FALSE)
