###############
# build index
###############
cd /Pinus1/Liuhui/Xsorbifolium/gene_expression/index
RefGene=final.protein_gene.gtf
RefGenome=genome2.fasta

extract_splice_sites.py $RefGene > $RefGene.ss
extract_exons.py $RefGene > $RefGene.exon
hisat2-build --ss $RefGene.ss --exon $RefGene.exon $RefGenome $RefGenome


###############
# mapping and estimate the abundance
###############
cd /Pinus1/Liuhui/Xsorbifolium/gene_expression
Index=/Pinus1/Liuhui/Xsorbifolium/gene_expression/index/genome2.fasta
RefGene=/Pinus1/Liuhui/Xsorbifolium/gene_expression/index/final.protein_gene.gtf

htoutdir=ht_out && mkdir -p $htoutdir
stoutdir=st_out && mkdir -p $stoutdir
ncpu=10
ht_opts="-k 1 --new-summary"

#
for SAMPLE in `cat sample_list`
do
	r1=/Pinus1/RNAseq/CleanData/${SAMPLE}_filter_R1.fastq.gz
	r2=/Pinus1/RNAseq/CleanData/${SAMPLE}_filter_R2.fastq.gz
	hisat2 -p $ncpu --dta -x $Index -1 $r1 -2 $r2 --summary-file $htoutdir/${SAMPLE}.summary --rg-id $SAMPLE $ht_opts | samtools sort --threads $ncpu > $htoutdir/${SAMPLE}.bam
	# no assembly
	outdir=$stoutdir/${SAMPLE}
	mkdir -p $outdir
	stringtie -e -B -p $ncpu -G $RefGene -A $outdir/gene_exp.tab -o $outdir/transcript.gtf $htoutdir/${SAMPLE}.bam   
        #featureCounts --donotsort -p -Q 10 -t exon -g gene_id -s 0 -T 10 -a $RefGene -o $outdir/gene_exp.cnt $htoutdir/${SAMPLE}.bam
done
cat sample_list | xargs -n 1 -P 10 ./htseq.sh

# htseq-count results
cp */*count ../htseq_count/
# delete outliers
rm E2_6GP.count  
rm C9_5GR_1.count


# delete outliers
sed '/E2_6GP/d;/C9_5GR_1/d' sample_list > xso_exp_sample

# featureCounts 
#python bin/merge_count.py xso_exp_sample xso_exp_count.xls
# stringtie
python bin/merge_TPM.py xso_exp_sample xso_exp_TPM.xls


###############
# mapping rate
###############
cd /Pinus1/Liuhui/Xsorbifolium/gene_expression/ht_out
grep -E "concordantly 1 time|Overall" *summary | \
awk '{print $1,$NF}' | sed 's/(//;s/)//;s/.summary: /\t/' | \
awk '{a[$1]=($1 in a ? a[$1]"\t"$2: $0)} END{for (k in a) print a[k]}' | \
sed '1isamples\tunique_mappingRate\tmapping_rate' > ../Xso_RNAseq_MappingRate.xls
