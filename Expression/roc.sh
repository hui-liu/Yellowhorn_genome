cd /Pinus1/Liuhui/Xsorbifolium/gene_expression/seider
docker run --cpus="8" -v ${PWD}:/Pinus1 -it a7874e3f4476 /bin/bash
cd /Pinus1/roc
#
for m in All backbone_eight backbone_five backbone_four backbone_nine backbone_one backbone_seven backbone_six backbone_ten backbone_three backbone_two threshold_28
do
  num=0
  for i in ARACNE CLR elnet genie3 llr narromi pcor pearson plsnet spearman svm tigress irp
  do
  num=$(($num+1))
  seidr roc -g ../data/gold_standard_edges_for_seidr.tsv -i $num -p 1000 -E 1 -n ../seidr_results/xso_irp_aggregated.sf > $m/seidr_roc_$i.tsv
  done
done
