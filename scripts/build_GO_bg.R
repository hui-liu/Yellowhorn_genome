# dir
rm(list=ls())
setwd("D:/my_research/YQYK20151225A-Xanthoceras_sorbifolium/functional_annotation/Xso_GO_database")

# package
library(clusterProfiler)
library(GO.db)

###############
# build GO backgroud
##############
gomap <- read.delim("xso_go.annot")
#go_accession	gene
#GO:0005739	XS01G0000100
#GO:0008915	XS01G0000100
#GO:0009245	XS01G0000100
#GO:2001289	XS01G0000100
#GO:0003677	XS01G0000400
#GO:0003700	XS01G0000400
#GO:0005634	XS01G0000400

build_GOmap <- buildGOmap(gomap)

# update
goinfo <- select(GO.db, keys(GO.db, "GOID"), c("TERM", "ONTOLOGY"))
bg <- build_GOmap[build_GOmap$GO %in% goinfo$GOID,]
write.csv(bg, "xso_GO_bg.csv", row.names = FALSE)


##############
# add descriptions for GOID
##############
GO_uniq <- as.character(unique(bg$GO))
go_des <- goinfo[GO_uniq %in% goinfo$GOID,]
names(go_des) <- c("GO", "TERM", "ONTOLOGY")
write.csv(go_des, "xso_GO_des.csv", row.names = FALSE)
