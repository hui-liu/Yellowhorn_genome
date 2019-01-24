# https://www.biorxiv.org/content/biorxiv/early/2018/01/19/250696.full.pdf
# (1) ARACNE
mi -m ARACNE --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_ARACNE.tsv

# (2) CLR
mpirun -np 9 --oversubscribe --allow-run-as-root mi -m CLR --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_CLR.tsv

# (3) pearson
correlation --force -m pearson -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_pearson.tsv

# (4) spearman
correlation --force -m spearman -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_spearman.tsv

# (5) ensemble of Elastic Net regression predictors
mpirun -np 9 --oversubscribe --allow-run-as-root el-ensemble --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_elnet.tsv

# (6) ensemble of Support Vector Machine predictor
mpirun -np 16 --oversubscribe --allow-run-as-root svm-ensemble --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_svm.tsv

# (7) ensemble of Support Vector Machine predictors
mpirun -np 16 --oversubscribe --allow-run-as-root llr-ensemble --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_llr.tsv

# (8) GENIE3
genie3 --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_genie3.tsv

# (9) Narromi
mpirun -np 9 --oversubscribe --allow-run-as-root narromi --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_narromi.tsv

# (10) Partial Correlation
pcor --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_pcor.tsv

# (11) PLSNET
mpirun -np 9 --oversubscribe --allow-run-as-root plsnet --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_plsnet.tsv

# (12) TIGRESS
mpirun -np 9 --oversubscribe --allow-run-as-root tigress --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_tigress.tsv
