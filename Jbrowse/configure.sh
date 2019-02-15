# (1)  format the reference sequences for JBrowse
bin/prepare-refseqs.pl --fasta /mnt/crick/data/yellow_horn/genome/genome2.fasta --trackConfig '{"category": "Genome"}'

# (2) format the gff file for JBrowse
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
bin/flatfile-to-json.pl --gff /mnt/crick/data/yellow_horn/annotation/final.TE.gff3 --trackLabel RepeatSequence --trackType CanvasFeatures \
--config '{"labelTranscripts": false, "category": "Annotation"}' --clientConfig '{ "textFont" : "normal 8px Univers,Helvetica,Arial,sans-serif"}'

# (3) SNPs
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
bin/add-bw-track.pl --bw_url expression/A0_10Y.bw \
--label A0_10Y --key "A0_10Y" --category "RNA-seq coverage (leaves)" --plot \
--min_score 0 --max_score 100 --pos_color "#937d62" --neg_color "#005EFF" --clip_marker_color "red" --height 100
#bin/remove-track.pl --trackLabel A0_10Y --dir data/

# (5) domains from pfam annotation?

# (6) Index Names
bin/generate-names.pl -v

# (7)  JBrowse configurations
#set JBrowse link for yellowhorn in tool.php
` header('Location: http://yellowhorn.plantgenie.org/jbrowse?data=data%2Fptr');`

