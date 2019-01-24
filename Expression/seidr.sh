# https://www.biorxiv.org/content/biorxiv/early/2018/01/19/250696.full.pdf
# (1) ARACNE (at jolvii server)
mi -m ARACNE --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_ARACNE.tsv

# (2) CLR (at pine)
mpirun -np 9 --oversubscribe --allow-run-as-root mi -m CLR --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_CLR.tsv
seidr import --force -u -z -r -i seidr_results/xso_edgelist_CLR.tsv -g data/xso_genes.txt -F lm -o seidr_results/xso_CLR_ranks.sf

# (3) pearson (at jolvii server)
correlation --force -m pearson -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_pearson.tsv

# (4) spearman (at jolvii server)
correlation --force -m spearman -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_spearman.tsv

# (5) ensemble of Elastic Net regression predictors (at jolvii server)
mpirun -np 9 --oversubscribe --allow-run-as-root el-ensemble --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_el.tsv

# (6) ensemble of Support Vector Machine predictor (at crick server)
mpirun -np 16 --oversubscribe --allow-run-as-root svm-ensemble --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_svm.tsv

# (7) ensemble of Support Vector Machine predictors (at crick server)
mpirun -np 16 --oversubscribe --allow-run-as-root llr-ensemble --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_llr.tsv

# (8) GENIE3 (at jolvii server)
genie3 --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_genie3.tsv

# (9) Narromi (at pine)
mpirun -np 9 --oversubscribe --allow-run-as-root narromi --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_narromi.tsv

# (10) Partial Correlation (at jolvii server)
pcor --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_pcor.tsv

# (11) PLSNET (at pine)
mpirun -np 9 --oversubscribe --allow-run-as-root plsnet --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_plsnet.tsv

# (12) TIGRESS (at pine)
mpirun -np 9 --oversubscribe --allow-run-as-root tigress --force -i data/xso_expr_mat.txt -g data/xso_genes.txt -o seidr_results/xso_edgelist_tigress.tsv
