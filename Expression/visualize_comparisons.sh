# venn plot and go enrichment
cd /Pinus1/Liuhui/Xsorbifolium/gene_expression/seider
for i in one two three four five six seven eight nine ten
do
Rscript bin/backbone_x_percent_threshold_compare.R compare/xso_irp_backbone_$i\_percent_threshold_compare.txt
done
