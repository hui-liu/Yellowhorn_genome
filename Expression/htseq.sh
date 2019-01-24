SAMPLE=$1
RefGene=/Pinus1/Liuhui/Xsorbifolium/gene_expression/index/final.protein_gene.gtf
htoutdir=ht_out
stoutdir=st_out
outdir=$stoutdir/${SAMPLE}
htseq-count -f bam -r name -s no -a 10 -t exon -i gene_id -m union --nonunique=none $htoutdir/${SAMPLE}.bam $RefGene > $outdir/${SAMPLE}.count
