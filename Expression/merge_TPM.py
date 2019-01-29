import sys

samples = [line.strip().split()[0] for line in open(sys.argv[1], 'r')]
inTab='st_out/%s/gene_exp.tab'

d_exp = {}
for sample in samples:
    expTab = inTab % sample
    with open(expTab, 'r') as f:
        for line in f:
            if line[0] == '#':
                continue
            temp = line.split()
            if temp[0] == 'Gene':
                continue
            gene_id = temp[0]
            exp_value = temp[-1]
            try:
                d_exp[gene_id][sample] = exp_value
            except KeyError:
                d_exp[gene_id] = {sample:exp_value}


OUT = open(sys.argv[2], 'w')
Header = ['Geneid'] + samples
OUT.write("\t".join(Header) + "\n")
for gene_id, d_values in d_exp.items():
    values = [d_values[sample] for sample in samples]
    line = [gene_id] + values
    OUT.write("\t".join(line) + "\n")

OUT.close()
