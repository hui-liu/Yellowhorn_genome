cd /mnt/crick/data/yellow_horn/Enrichment
# pfam
sed '1,1d' xso_Pfam.annot | awk '{print $2"\t"$1}' | \
awk '{a[$1]=($1 in a ? a[$1]"|"$2: $0)} END{for (k in a) print a[k]}' | \
sort -k1,1 > gene_to_pfam.tsv

# go
grep "^id: GO" /mnt/crick/www/enrichment/go-basic.obo | awk '{print $2}' > go_DB.txt
awk 'NR==FNR{a[$1]=$1;next}($1 in a){print $0}' go_DB.txt xso_bg_GO.txt | \
awk '{print $2"\t"$1}' | \
awk '{a[$1]=($1 in a ? a[$1]"|"$2: $0)} END{for (k in a) print a[k]}'| \
sort -k 1,1 > gene_to_go.tsv

# kegg
sed '1,1d' kegg_annotation.xls | awk -F "\t" '{print $1"\t"$5}' | \
awk '$2!="-"' | sed 's/EC://;s/ /|/g' | awk '!a[$0]++' | sort -k1,1 > gene_to_kegg.tsv

#
cp *tsv /mnt/crick/www/enrichment/yellowhorn
