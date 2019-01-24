####
# Data Preparation
####
cd /Pinus1/Liuhui/Xsorbifolium/BLAST
wget ftp://plantgenie.org/Data/AtGenIE/Arabidopsis_thaliana/TAIR10/FASTA/Athaliana_167_protein.fa.gz
wget ftp://plantgenie.org/Data/ConGenIE/Picea_abies/v1.0/FASTA/GenePrediction/Pabies1.0-all-pep.faa.gz
wget ftp://plantgenie.org/Data/PopGenIE/Populus_trichocarpa/v3.0/v10.1/FASTA/Ptrichocarpa_210_proteins.fa.gz
wget ftp://plantgenie.org/Data/PopGenIE/Populus_tremula/v1.1/FASTA/Potra01-protein.fa.gz

for i in *gz
do
gunzip $i
x=${i/.gz/}
makeblastdb -in $x -dbtype prot
done

####
# BLAST
####
# (1) Athaliana
blastp -query /Pinus1/Liuhui/Xsorbifolium/annotation/final.gene.pep.faa \
-db Athaliana_167_protein.fa \
-evalue 1e-5 -num_threads 8 -out xso_artha.outfmt6 \
-outfmt "6 qseqid sseqid pident qcovs mismatch gapopen qstart qend sstart send evalue bitscore"

# (2) Pabies
blastp -query /Pinus1/Liuhui/Xsorbifolium/annotation/final.gene.pep.faa \
-db Pabies1.0-all-pep.faa \
-evalue 1e-5 -num_threads 8 -out xso_piabi.outfmt6 \
-outfmt "6 qseqid sseqid pident qcovs mismatch gapopen qstart qend sstart send evalue bitscore"

# (3) Ptrichocarpa
blastp -query /Pinus1/Liuhui/Xsorbifolium/annotation/final.gene.pep.faa \
-db Ptrichocarpa_210_proteins.fa \
-evalue 1e-5 -num_threads 8 -out xso_potri.outfmt6 \
-outfmt "6 qseqid sseqid pident qcovs mismatch gapopen qstart qend sstart send evalue bitscore"

# (4) Potra
blastp -query /Pinus1/Liuhui/Xsorbifolium/annotation/final.gene.pep.faa \
-db Potra01-protein.fa \
-evalue 1e-5 -num_threads 8 -out xso_potra.outfmt6 \
-outfmt "6 qseqid sseqid pident qcovs mismatch gapopen qstart qend sstart send evalue bitscore"


# best BLAST
sort -k1,1 -k12,12nr -k11,11g  xso_artha.outfmt6 | sort -u -k1,1 > xso_artha.besthit
sort -k1,1 -k12,12nr -k11,11g  xso_piabi.outfmt6 | sort -u -k1,1 > xso_piabi.besthit
sort -k1,1 -k12,12nr -k11,11g  xso_potri.outfmt6 | sort -u -k1,1 > xso_potri.besthit
sort -k1,1 -k12,12nr -k11,11g  xso_potra.outfmt6 | sort -u -k1,1 > xso_potra.besthit
