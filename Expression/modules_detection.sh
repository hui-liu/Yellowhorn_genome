cd /Pinus1/Liuhui/Xsorbifolium/gene_expression/seider
docker run --cpus="8" -v ${PWD}:/Pinus1 -it a7874e3f4476 /bin/bash

#####
# backbone network
####
## Drop disconnected nodes
cd modules/irp_backbone_three_percent
cp ../../backbone/xso_irp_backbone_three_percent.sf .
seidr reheader xso_irp_backbone_three_percent.sf
 
## Create infomap data file (should be end with ".txt")
seidr view -d $'\t' -N xso_irp_backbone_three_percent.sf | cut -f 1,2,28 > xso_irp_backbone_three_percent.txt

## Create Gephi edges file data (should be end with ".tsv")
echo -e "Source\tTarget\tWeight" > xso_irp_backbone_three_percent_edges.tsv
seidr view -d $'\t' xso_irp_backbone_three_percent.sf | cut -f 1,2,28 >> xso_irp_backbone_three_percent_edges.tsv

## Run Infomap
Infomap xso_irp_backbone_three_percent.txt ./ --markov-time 0.5 -z &> xso_irp_backbone_three_percent.log

## Remap numerical node IDs to gene names
echo -e "path\tC1\tC2\tC3\tC4\tC5\tC6\tC7\tflow\tIndex\tId" > xso_irp_backbone_three_percent_nodes.tsv
seidr resolve -s xso_irp_backbone_three_percent.sf \
xso_irp_backbone_three_percent.tree >> xso_irp_backbone_three_percent_nodes.tsv


# level2
#^(([0-9]+:)[0-9]+)
# level3
#^((([0-9]+:)[0-9]+):[0-9]+)

# generate modules at level 3
cd /Pinus1/Liuhui/Xsorbifolium/gene_expression/seider/modules/irp_backbone_three_percent
python ../bin/split_modules.py xso_irp_backbone_three_percent_nodes.tsv 3 GO_enrichment

# GO enrichment analysis
cd GO_enrichment
for i in $(ls *txt)
do
Rscript ../../bin/yellowhorn_go_enrichment.R $i
done

# revigo
for i in $(ls *GO.csv)
do
x=${i/_GO.csv/}
sed 's/,\("[^"]*"\)*/\t\1/g' $i | awk -F "\t" '{print $1","$5}' > $x\_revigo.csv 
done

for i in $(ls *R)
do
x=${i/.R/}
sed  -i "s/pdf.*/png\('$x.png',width=10,height=8,units='in',res=500\)/;s/REVIGO Gene Ontology treemap/$x/" $i
Rscript $i
done

# for i in $(ls *txt)
# do
# x=${i/.txt/}
# mkdir $x
# mv $x.* $x
# mv $x\_* $x
# done
