# Libs
suppressPackageStartupMessages(library(readr))
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(devtools))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(VennDiagram))
suppressPackageStartupMessages(library(clusterProfiler))

# read the input file
argv <- commandArgs(TRUE)
infile <- argv[1]
prefix <- gsub(".txt", "", infile)

# File preparation
# Read in the seidr compare file and splitting the combined columns into separate ones.
# This allows for easier selection and processing of specific information.
th1bb <- read_tsv(pipe(paste0("cat ",
                              infile,
                              " | ", 
                              "tr ';' '\t'")),
                  col_names = c("Source", "Target", "Type", "Score", "Rank",
                                "Flag", "Rank_Source", "Rank_Target")
)

# background GO databases
godir <- "/Pinus1/Liuhui/Xsorbifolium/functional_annotation/Xso_GO_database/"
GO2gene <- read.csv(paste0(godir, "xso_bg_GO.csv"))
GO2des <- read.csv(paste0(godir, "xso_GO_des.csv"))
GO2des <- GO2des[,1:2]


# Genes amongst the shared edges of two networks and the unique edges of backbone network
# Same as : unique.genes.th1bb <- unique(unlist(th1bb[th1bb$Flag %in% c(0,1),c("Source", "Target")]))
Gr1_0.edges.genes <- unique(unlist(th1bb[th1bb$Flag != "2",c("Source", "Target")]))

# Extracting unique genes
# Unique genes of unique edges found in the seidr threshold network (Group 2) can be obtained.
Gr2.unique.edges.genes <- unique(unlist(th1bb[th1bb$Flag == "2", c("Source", "Target")]))

# Unique genes of the seidr threshold network (Group 2)
Gr2.unique.genes <- setdiff(Gr2.unique.edges.genes, Gr1_0.edges.genes)

# GO enrichment
Gr2.unique.genes <- gsub("\\.1$", "", Gr2.unique.genes)
out <- paste0(prefix,"_GO.","csv")
Gr2.unique.genes_enrich_res <- enricher(Gr2.unique.genes, TERM2GENE = GO2gene, TERM2NAME = GO2des)
write.csv(Gr2.unique.genes_enrich_res, out, row.names = F)


# Visualisation with a barplot and Venn diagram
# A barplot can be made to better visualize the differences between the different methods.
# table(th1bb$Flag)

out1 <- paste0(prefix,"_bar.","png")
# pdf(out1, 10,7)
png(out1, width=10,height=7,units='in',res=500)
barplot(table(th1bb$Flag))
dev.off()

# Unique genes amongst the commonly shared edges and the edges from the Backbone network were
# compared in a Venn diagram to the unique genes found within the edges of the Seidr threshold network.
# This was done to see if there were genes that the different network methods would exclude.
out2 <- paste0(prefix,"_venn.","png")
# pdf(out2, 8,8)
png(out2, width=8,height=8,units='in',res=500)
grid.newpage()
grid.draw(draw.pairwise.venn(
  area1 = length(Gr2.unique.edges.genes),
  area2 = length(Gr1_0.edges.genes),
  cross.area = length(intersect(Gr2.unique.edges.genes, Gr1_0.edges.genes)),
  category = c( "Threshold network", "Backbone network"),
  fill = c("#E71D36", "#00A8E8"),
  cat.pos = c(200, 25),
  euler.d = TRUE,
  sep.dist = 0.09,
  rotation.degree = 65,
  filename = NULL
))
dev.off()
