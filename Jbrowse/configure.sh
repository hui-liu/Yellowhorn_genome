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
#cd /mnt/crick/data/yellow_horn
#python bin/pfam_bed_v2.py annotation/final.protein_gene.gff3 functional_annotation/interproscan.tsv jbrowse/pfam_bed.tsv
#python bin/pfam_bed_to_gff.py jbrowse/pfam_bed.txt > jbrowse/pfam.gff
awk '$3=="CDS"' ../annotation/final.protein_gene.gff3 | sed 's/=.*;Parent//' > ../annotation/final.protein_gene_CDS.gff3
awk '$4=="Pfam"' interproscan.tsv | cut -f 1,5,7-8 | \
awk '{print $1"\t""interproscan\tpfam\t"$3"\t"$4"\t.\t.\t.\tID=PFAM:"$2}'| \
perl /media/12TB/liuhui/bin/scripts/protein2genome.pl ../annotation/final.protein_gene_CDS.gff3 | \
cut -f 1,4,5,9 | sed 's/ID=PFAM://;s/(.*//' | awk '{print $1"\t"$2-1"\t"$3"\t"$4}' > pfam_bed.tsv


cd /mnt/crick/www/yellowhorn/plugins/jbrowse
bin/flatfile-to-json.pl --bed /mnt/crick/data/yellow_horn/jbrowse/pfam_bed.tsv \
--trackLabel PfamDomain --trackType CanvasFeatures --out data/yellowhorn \
--config '{"labelTranscripts": false, "category": "Annotation"}' --clientConfig '{ "textFont" : "normal 8px Univers,Helvetica,Arial,sans-serif"}'

      # {
         # "onClick" : {
            # "url" : "https://pfam.xfam.org/family/{name}#tabview=tab1",
            # "label" : "search at Pfam"
         # },
        # "compress" : 0,
        # "style" : {
           # "textFont" : "normal 9px Univers,Helvetica,Arial,sans-serif",
           # "className" : "feature",
           # "strandArrow" : false,
           # "color" : "#FF1654"
         # },
        # "trackType" : "CanvasFeatures",
        # "category" : "Annotation",
        # "storeClass" : "JBrowse/Store/SeqFeature/NCList",
        # "type" : "CanvasFeatures",
        # "labelTranscripts" : false,
        # "label" : "PfamDomain",
        # "key" : "PfamDomain",
        # "urlTemplate" : "tracks/PfamDomain/{refseq}/trackData.json"
      # }



#bin/remove-track.pl --dir data/yellowhorn --trackLabel PfamDomain -D

# (2.6) promoter
cd /mnt/crick/data/yellow_horn
python bin/promoter_gff.py promoter/xso_up_2k.fasta /mnt/crick/data/yellow_horn/promoter/xso_up_2k_results/fimo.gff 0.001 jbrowse/promoter_up_2k_jbrowse.gff
python bin/promoter_gff.py promoter/xso_up_1.5k.fasta /mnt/crick/data/yellow_horn/promoter/xso_up_1.5k_results/fimo.gff 0.001 jbrowse/promoter_up_1.5k_jbrowse.gff
cd /mnt/crick/www/yellowhorn/plugins/jbrowse
bin/flatfile-to-json.pl --gff /mnt/crick/data/yellow_horn/jbrowse/promoter_up_2k_jbrowse.gff \
--trackLabel "Promoter (upstream 2k)" --trackType CanvasFeatures --out data/yellowhorn \
--config '{"labelTranscripts": false, "category": "Annotation"}' --clientConfig '{ "textFont" : "normal 8px Univers,Helvetica,Arial,sans-serif"}'
#
bin/flatfile-to-json.pl --gff /mnt/crick/data/yellow_horn/jbrowse/promoter_up_1.5k_jbrowse.gff \
--trackLabel "Promoter (upstream 1.5k)" --trackType CanvasFeatures --out data/yellowhorn \
--config '{"labelTranscripts": false, "category": "Annotation"}' --clientConfig '{ "textFont" : "normal 8px Univers,Helvetica,Arial,sans-serif"}'

# "color" : "#2EC4B6",
# "height" : 0.35,


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
