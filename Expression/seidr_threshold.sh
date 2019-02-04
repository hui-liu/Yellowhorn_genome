# irp
seidr threshold seidr_results/xso_irp_aggregated.sf > seidr_threshold/xso_irp_threshold.txt 2>seidr_threshold/xso_irp_threshold.err
seidr view -t 0.28 seidr_results/xso_irp_aggregated.sf > seidr_results/xso_irp_aggregated_filtered_network.txt

# borda
seidr threshold seidr_results/xso_borda_aggregated.sf > seidr_threshold/xso_borda_threshold.txt 2>seidr_threshold/xso_borda_threshold.err
seidr view -t 0.88 seidr_results/xso_borda_aggregated.sf > seidr_results/xso_borda_aggregated_filtered_network.txt

# top1
seidr threshold seidr_results/xso_top1_aggregated.sf > seidr_threshold/xso_top1_threshold.txt 2>seidr_threshold/xso_top1_threshold.err
seidr view -t 0.88 seidr_results/xso_top1_aggregated.sf > seidr_results/xso_top1_aggregated_filtered_network.txt


# top2
seidr threshold seidr_results/xso_top2_aggregated.sf > seidr_threshold/xso_top2_threshold.txt 2>seidr_threshold/xso_top2_threshold.err
seidr view -t 0.1 seidr_results/xso_top2_aggregated.sf > seidr_results/xso_top2_aggregated_filtered_network.txt
