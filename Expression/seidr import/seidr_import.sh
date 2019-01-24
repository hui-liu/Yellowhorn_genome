# (1) ARACNE
seidr import --force -u -z -r -A -i seidr_results/xso_edgelist_ARACNE.tsv -g data/xso_genes.txt -F lm -o seidr_results/xso_ARACNE_ranks.sf

# (2) CLR
seidr import --force -u -z -r -A -i seidr_results/xso_edgelist_CLR.tsv -g data/xso_genes.txt -F lm -o seidr_results/xso_CLR_ranks.sf

# (3) pearson
seidr import --force -u -z -r -A -i seidr_results/xso_edgelist_pearson.tsv -g data/xso_genes.txt -F lm -o seidr_results/xso_pearson_ranks.sf

# (4) spearman
seidr import --force -u -z -r -A -i seidr_results/xso_edgelist_spearman.tsv -g data/xso_genes.txt -F lm -o seidr_results/xso_spearman_ranks.sf

# (5) ensemble of Elastic Net regression predictors

# (6) ensemble of Support Vector Machine predictor

# (7) ensemble of Support Vector Machine predictors

# (8) GENIE3 (non-symmetric)
seidr import --force -z -r -A -i seidr_results/xso_edgelist_genie3.tsv -g data/xso_genes.txt -F m -o seidr_results/xso_genie3_ranks.sf

# (9) Narromi (non-symmetric)
seidr import --force -z -r -A -i seidr_results/xso_edgelist_narromi.tsv -g data/xso_genes.txt -F m -o seidr_results/xso_narromi_ranks.sf

# (10) Partial Correlation
seidr import --force -u -z -r -A -i seidr_results/xso_edgelist_pcor.tsv -g data/xso_genes.txt -F lm -o seidr_results/xso_pcor_ranks.sf

# (11) PLSNET

# (12) TIGRESS
