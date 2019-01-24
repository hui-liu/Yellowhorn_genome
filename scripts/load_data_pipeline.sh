############
# Loading data into the MySQL database
############
cd /mnt/spruce/data/yellow_horn
#Load above generated source file into gene_info table
sh bin/load_data.sh gene_info Data_Preparation/xso_gene_info.txt

#Load previously generated source file into transcript_info table
sh bin/load_data.sh transcript_info Data_Preparation/xso_transcript_info.txt

#Load gene description
sh bin/update_descriptions.sh gene_info Data_Preparation/xso_swissprot_gene_description.txt

#Load transcript description
sh bin/update_descriptions.sh transcript_info Data_Preparation/xso_swissprot_transcript_description.txt

#update the gene_i in transcript_info table
sh bin/update_gene_i.sh

#load Best BLAST results to transcript_atg table
sh bin/load_data.sh transcript_atg Data_Preparation/xso_transcript_atg.txt
#update the gene_i in transcript_atg table
sh bin/update_transcript_i.sh transcript_atg

#load Best BLAST results to transcript_potri table
sh bin/load_data.sh transcript_potri Data_Preparation/xso_transcript_potri.txt
#update the gene_i in transcript_potri table
sh bin/update_transcript_i.sh transcript_potri

#load Best BLAST results to transcript_potra table
sh bin/load_data.sh transcript_potra Data_Preparation/xso_transcript_potra.txt
#update the gene_i in transcript_potra table
sh bin/update_transcript_i.sh transcript_potra

#load Best BLAST results to transcript_piabi table
sh bin/load_data.sh transcript_piabi Data_Preparation/xso_transcript_piabi.txt
#update the gene_i in transcript_piabi table
sh bin/update_transcript_i.sh transcript_piabi

#loaded into database sequence_color table
sh bin/sequence_color.sh annotation/final.protein_gene.gff3

#load go annotation results to gene_go table
sh bin/load_data.sh gene_go Data_Preparation/xso_go.txt
#update the gene_i in gene_go table
sh bin/update_annotation_gene_i.sh gene_go

#load kegg annotation results to gene_kegg table
sh bin/load_data.sh gene_kegg Data_Preparation/xso_kegg.txt
#update the gene_i in gene_kegg table
sh bin/update_annotation_gene_i.sh gene_kegg

#load pfam annotation results to gene_pfam table
sh bin/load_data.sh gene_pfam Data_Preparation/xso_pfam.txt
#update the gene_i in gene_pfam table
sh bin/update_annotation_gene_i.sh gene_pfam

# rnaseq_sample
sh bin/load_data.sh rnaseq_sample Data_Preparation/RNAseq_sample_design.txt
#update the sample_i in rnaseq_sample table
sh bin/update_sample_i.sh

#expression_rnaseq_vst
sh bin/load_data.sh expression_rnaseq_vst Data_Preparation/xso_vst_datasetx.txt
#update the gene_i, sample_i and tissue in expression_rnaseq_vst table
sh bin/update_expression_rnaseq_vst.sh
