# Yellowhorn genome project

## best blast
best_blast.sh

## Expression
- mapping with hisat2 and call count using htseq-count
xso_gene_expr.sh

- convert the raw counts from htseq-count to vst using DEseq2
convert_counts_to_VST.R

- remove non-varying genes
vst_filter.R

- Calculate co-expression network using Seidr
seidr.sh
