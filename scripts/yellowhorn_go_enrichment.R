# Libs
suppressPackageStartupMessages(library(clusterProfiler))

# read the input file
argv <- commandArgs(TRUE)
infile <- argv[1]

# background GO databases
godir <- "/Pinus1/Liuhui/Xsorbifolium/functional_annotation/Xso_GO_database/"
GO2gene <- read.csv(paste0(godir, "xso_bg_GO.csv"))
GO2des <- read.csv(paste0(godir, "xso_GO_des.csv"))
GO2des <- GO2des[,1:2]

# target gene list
target_genes <- read.table(infile)
target_genes <- as.character((target_genes[[1]]))
target_genes <- gsub("\\.1$", "", target_genes)

# GO enrichment
prefix <- unlist(strsplit(infile, split='.', fixed=TRUE))[1]
out <- paste0(prefix,"_GO.","csv")
target_genes_enrich_res <- enricher(target_genes, TERM2GENE = GO2gene, TERM2NAME = GO2des, pvalueCutoff = 0.05)
write.csv(target_genes_enrich_res, out, row.names = F)
