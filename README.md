# Yellowhorn genome project

## Best blast hit between yellowhron and other species
`best_blast.sh`

## Expression
- mapping the rnaseq reads to genome using hisat2 and call count using htseq-count

  `xso_gene_expr.sh`

- convert the raw counts generated from htseq-count to vst using DEseq2

  `convert_counts_to_VST.R`

- remove non-varying genes

  `vst_filter.R`

- Calculate co-expression network using Seidr

  - Infer: Independent gene-gene networks are created by a multitude of algorithms
  
    `seidr_algorithms.sh`
    
  - Import: In order to merge these networks, they are first sorted and ranked
  
    `seidr_import.sh`
    
  - Aggregate: Once all methods are ready, seidr can aggregate them to a crowd network
  
    `seidr_aggregate.sh`
    
  - Estimate a hard threshold for a given seidr network
  
    `seidr_threshold.sh`

  - Construct the backbone network
  
    `backbone.sh`
    
  - Compare the backbone network and threshold network
  
    `compare.sh`
    
  - visualize the comparisons
  
    `visualize_comparisons.sh`

## GO, PFAM and KEGG enrichment
`enrichment_files.sh`

## Jbrowse

`configure.sh`
