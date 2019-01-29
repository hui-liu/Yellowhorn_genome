# irp
seidr aggregate --force -m irp -o seidr_results/xso_irp_aggregated.sf \
seidr_results/xso_ARACNE_ranks.sf seidr_results/xso_CLR_ranks.sf seidr_results/xso_elnet_ranks.sf seidr_results/xso_genie3_ranks.sf seidr_results/xso_llr_ranks.sf seidr_results/xso_narromi_ranks.sf seidr_results/xso_pcor_ranks.sf seidr_results/xso_pearson_ranks.sf seidr_results/xso_plsnet_ranks.sf seidr_results/xso_spearman_ranks.sf seidr_results/xso_svm_ranks.sf seidr_results/xso_tigress_ranks.sf

# borda
seidr aggregate --force -m borda -o seidr_results/xso_borda_aggregated.sf \
seidr_results/xso_ARACNE_ranks.sf seidr_results/xso_CLR_ranks.sf seidr_results/xso_elnet_ranks.sf seidr_results/xso_genie3_ranks.sf seidr_results/xso_llr_ranks.sf seidr_results/xso_narromi_ranks.sf seidr_results/xso_pcor_ranks.sf seidr_results/xso_pearson_ranks.sf seidr_results/xso_plsnet_ranks.sf seidr_results/xso_spearman_ranks.sf seidr_results/xso_svm_ranks.sf seidr_results/xso_tigress_ranks.sf

# top1
seidr aggregate --force -m top1 -o seidr_results/xso_top1_aggregated.sf \
seidr_results/xso_ARACNE_ranks.sf seidr_results/xso_CLR_ranks.sf seidr_results/xso_elnet_ranks.sf seidr_results/xso_genie3_ranks.sf seidr_results/xso_llr_ranks.sf seidr_results/xso_narromi_ranks.sf seidr_results/xso_pcor_ranks.sf seidr_results/xso_pearson_ranks.sf seidr_results/xso_plsnet_ranks.sf seidr_results/xso_spearman_ranks.sf seidr_results/xso_svm_ranks.sf seidr_results/xso_tigress_ranks.sf

# top2
seidr aggregate --force -m top2 -o seidr_results/xso_top2_aggregated.sf \
seidr_results/xso_ARACNE_ranks.sf seidr_results/xso_CLR_ranks.sf seidr_results/xso_elnet_ranks.sf seidr_results/xso_genie3_ranks.sf seidr_results/xso_llr_ranks.sf seidr_results/xso_narromi_ranks.sf seidr_results/xso_pcor_ranks.sf seidr_results/xso_pearson_ranks.sf seidr_results/xso_plsnet_ranks.sf seidr_results/xso_spearman_ranks.sf seidr_results/xso_svm_ranks.sf seidr_results/xso_tigress_ranks.sf
