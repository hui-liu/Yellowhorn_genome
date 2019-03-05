cd /Pinus1/Liuhui/Xsorbifolium/gene_expression/seider
docker run --cpus="8" -v ${PWD}:/Pinus1 -it a7874e3f4476 /bin/bash
cd /Pinus1/roc

# seidr view -H xso_irp_aggregated.sf | grep "aggregate" | sed 's/ /\n/g' | tail -n 12 | sed 's/_/\t/g'| cut -f 3 | xargs
mkdir aggregated backbone_eight_percent backbone_five_percent backbone_four_percent backbone_nine_percent backbone_one_percent backbone_seven_percent backbone_six_percent backbone_ten_percent backbone_three_percent backbone_two_percent aggregated_28

for m in aggregated backbone_eight_percent backbone_five_percent backbone_four_percent backbone_nine_percent backbone_one_percent backbone_seven_percent backbone_six_percent backbone_ten_percent backbone_three_percent backbone_two_percent aggregated_28
do
  num=0
  # the algorithms order should be the same as the order in "xso_irp_aggregated.sf"
  for i in ARACNE CLR elnet genie3 llr narromi pcor pearson plsnet spearman svm tigress irp
  do
  num=$(($num+1))
  echo $m, $i
  seidr roc -g ../data/gold_standard_edges_for_seidr.tsv -i $num -p 1000 -E 1 -n ../seidr_results/xso_irp_$m.sf > $m/seidr_roc_$i.tsv
  done
done
