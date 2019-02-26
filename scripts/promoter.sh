##
# 2k
##
cd /mnt/crick/data/yellow_horn/promoter
# upsteam sequences
python ../bin/extract_upstream_of_gene.py ../genome/genome2.fasta 2000 ../annotation/final.protein_gene.gff3 xso_up_2k.fasta

# TF binding predict
wget http://meme-suite.org/meme-software/Databases/motifs/motif_databases.12.18.tgz
fimo --oc xso_up_2k_results --verbosity 1 --thresh 1e-5 motif_databases/ARABD/ArabidopsisDAPv1.meme xso_up_2k.fasta

##
# 1.5k
##
cd /mnt/crick/data/yellow_horn/promoter
# upsteam sequences
python ../bin/extract_upstream_of_gene.py ../genome/genome2.fasta 1500 ../annotation/final.protein_gene.gff3 xso_up_1.5k.fasta

# TF binding predict
fimo --oc xso_up_1.5k_results --verbosity 1 --thresh 1e-5 motif_databases/ARABD/ArabidopsisDAPv1.meme xso_up_1.5k.fasta
