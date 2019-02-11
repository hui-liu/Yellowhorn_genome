#######
# backbone
#######
# keep 1% of edges (0.99 2.326348)
seidr backbone -o backbone/xso_irp_backbone_one_percent.sf -f 2.33 seidr_results/xso_irp_aggregated.sf 

# keep 2% of edges (0.98 2.053749)
seidr backbone -o backbone/xso_irp_backbone_two_percent.sf -f 2.05 seidr_results/xso_irp_aggregated.sf 

# keep 3% of edges (0.97 1.880794)
seidr backbone -o backbone/xso_irp_backbone_three_percent.sf -f 1.88 seidr_results/xso_irp_aggregated.sf 

# keep 4% of edges (0.96 1.750686)
seidr backbone -o backbone/xso_irp_backbone_four_percent.sf -f 1.75 seidr_results/xso_irp_aggregated.sf 

# keep 5% of edges (0.95 1.644854 )
seidr backbone -o backbone/xso_irp_backbone_five_percent.sf -f 1.64 seidr_results/xso_irp_aggregated.sf 


#######
# compare
#######

seidr compare -f -o compare/xso_irp_backbone_one_percent_threshold_compare.sf \
backbone/xso_irp_backbone_one_percent.sf threshold/xso_irp_aggregated_28.sf

seidr compare -f -o compare/xso_irp_backbone_two_percent_threshold_compare.sf \
backbone/xso_irp_backbone_two_percent.sf threshold/xso_irp_aggregated_28.sf

seidr compare -f -o compare/xso_irp_backbone_three_percent_threshold_compare.sf \
backbone/xso_irp_backbone_three_percent.sf threshold/xso_irp_aggregated_28.sf

seidr compare -f -o compare/xso_irp_backbone_four_percent_threshold_compare.sf \
backbone/xso_irp_backbone_four_percent.sf threshold/xso_irp_aggregated_28.sf

seidr compare -f -o compare/xso_irp_backbone_five_percent_threshold_compare.sf \
backbone/xso_irp_backbone_five_percent.sf threshold/xso_irp_aggregated_28.sf
