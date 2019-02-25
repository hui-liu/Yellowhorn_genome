# (1)  format the reference sequences for JBrowse
cd /mnt/crick/www/yellowhorn/plugins/jbrowse
mkdir data;mkdir data/expression
bin/prepare-refseqs.pl --fasta /mnt/crick/data/yellow_horn/genome/genome2.fasta --trackConfig '{"category": "Genome"}'

# (2) format the gff file for JBrowse
cd /mnt/crick/www/yellowhorn/plugins/jbrowse
# (2.1) protein genes
bin/flatfile-to-json.pl --gff /mnt/crick/data/yellow_horn/annotation/final.protein_gene.gff3 --trackLabel Gene --trackType CanvasFeatures \
--config '{"labelTranscripts": false, "category": "Annotation"}' --clientConfig '{ "textFont" : "normal 9px Univers,Helvetica,Arial,sans-serif"}'

# (2.2) pseudo genes
bin/flatfile-to-json.pl --gff /mnt/crick/data/yellow_horn/annotation/final.pseudogene.gff3 --trackLabel Pseudogene --trackType CanvasFeatures \
--config '{"labelTranscripts": false, "category": "Annotation"}' --clientConfig '{ "textFont" : "normal 8px Univers,Helvetica,Arial,sans-serif"}'

# (2.3) ncRNA
bin/flatfile-to-json.pl --gff /mnt/crick/data/yellow_horn/annotation/ncRNA.gff3 --trackLabel ncRNA --trackType CanvasFeatures \
--config '{"labelTranscripts": false, "category": "Annotation"}' --clientConfig '{ "textFont" : "normal 8px Univers,Helvetica,Arial,sans-serif"}'

# (2.4) Repeat sequences
cd /mnt/crick/data/yellow_horn
python bin/repeat_seqs.py annotation/final.TE.gff3 jbrowse/final.TE_jbrowse.gff3
cd /mnt/crick/www/yellowhorn/plugins/jbrowse
bin/flatfile-to-json.pl --gff /mnt/crick/data/yellow_horn/jbrowse/final.TE_jbrowse.gff3 --trackLabel RepeatSequence --trackType CanvasFeatures \
--config '{"labelTranscripts": false, "category": "Annotation"}' --clientConfig '{ "textFont" : "normal 8px Univers,Helvetica,Arial,sans-serif"}'

# (2.5) pfam domain
cd /mnt/crick/data/yellow_horn
python bin/pfam_bed.py annotation/final.protein_gene.gff3 functional_annotation/interproscan.tsv jbrowse/pfam_bed.txt
python bin/pfam_bed_to_gff.py jbrowse/pfam_bed.txt > jbrowse/pfam.gff

cd /mnt/crick/www/yellowhorn/plugins/jbrowse
bin/flatfile-to-json.pl --gff /mnt/crick/data/yellow_horn/jbrowse/pfam.gff \
--trackLabel PfamDomain --trackType CanvasFeatures --out data/yellowhorn \
--config '{"labelTranscripts": true, "category": "Annotation"}' --clientConfig '{ "textFont" : "normal 8px Univers,Helvetica,Arial,sans-serif"}'

#bin/remove-track.pl --dir data/yellowhorn --trackLabel pfam -D

# (3) SNPs
cd data
ln -s /mnt/crick/data/yellow_horn/vcf .
cd /mnt/crick/www/yellowhorn/plugins/jbrowse
# add the following track by manual

      {
         "storeClass" : "JBrowse/Store/SeqFeature/VCFTabix",
         "key" : "Yellowhorn 189 samples",
         "category" : "SNPs",
         "type" : "JBrowse/View/Track/HTMLVariants",
         "label" : "Yellowhorn_189_samples",
         "urlTemplate" : "vcf/xso.DP5.GQ20.MAF5.MR20.masked.vcf.gz"
      }
      
# (4)  Expression
cd /mnt/crick/www/yellowhorn/plugins/jbrowse/data/expression
ln -s /mnt/crick/data/yellow_horn/Expression/BWs_merged/* .

# flower bud
cd /mnt/crick/www/yellowhorn/plugins/jbrowse
for i in $(grep "flower_bud" /mnt/crick/data/yellow_horn/Data_Preparation/rnaseq_sample_design.txt | cut -f 1)
do
bin/add-bw-track.pl --bw_url expression/$i.bw \
--label $i --key "$i" --category "RNA-seq coverage (flower bud)" --plot \
--min_score 0 --max_score 100 --pos_color "#937d62" --neg_color "#005EFF" --clip_marker_color "red" --height 100
done

# inflorescence
cd /mnt/crick/www/yellowhorn/plugins/jbrowse
for i in $(grep "inflorescence" /mnt/crick/data/yellow_horn/Data_Preparation/rnaseq_sample_design.txt | cut -f 1)
do
bin/add-bw-track.pl --bw_url expression/$i.bw \
--label $i --key "$i" --category "RNA-seq coverage (inflorescence)" --plot \
--min_score 0 --max_score 100 --pos_color "#937d62" --neg_color "#005EFF" --clip_marker_color "red" --height 100
done

# flower
cd /mnt/crick/www/yellowhorn/plugins/jbrowse
for i in $(grep -w "flower" /mnt/crick/data/yellow_horn/Data_Preparation/rnaseq_sample_design.txt | cut -f 1)
do
bin/add-bw-track.pl --bw_url expression/$i.bw \
--label $i --key "$i" --category "RNA-seq coverage (flower)" --plot \
--min_score 0 --max_score 100 --pos_color "#937d62" --neg_color "#005EFF" --clip_marker_color "red" --height 100
done

# leaf
cd /mnt/crick/www/yellowhorn/plugins/jbrowse
for i in $(grep "leaf" /mnt/crick/data/yellow_horn/Data_Preparation/rnaseq_sample_design.txt | cut -f 1)
do
bin/add-bw-track.pl --bw_url expression/$i.bw \
--label $i --key "$i" --category "RNA-seq coverage (leaf)" --plot \
--min_score 0 --max_score 100 --pos_color "#937d62" --neg_color "#005EFF" --clip_marker_color "red" --height 100
done

# fruit
cd /mnt/crick/www/yellowhorn/plugins/jbrowse
for i in $(grep "fruit" /mnt/crick/data/yellow_horn/Data_Preparation/rnaseq_sample_design.txt | cut -f 1)
do
bin/add-bw-track.pl --bw_url expression/$i.bw \
--label $i --key "$i" --category "RNA-seq coverage (fruit)" --plot \
--min_score 0 --max_score 100 --pos_color "#937d62" --neg_color "#005EFF" --clip_marker_color "red" --height 100
done

# (5) Index Names
bin/generate-names.pl --hashBits 16
