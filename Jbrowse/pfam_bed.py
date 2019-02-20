import sys

USAGE = "\nusage: python %s <gene.gff3> <interproscan.tsv> <pfam_bed.txt>\n" % sys.argv[0]
if len(sys.argv) != 4:
    print USAGE
    sys.exit()

id_chr = {}
with open(sys.argv[1], 'r') as f:
    for line in f:
        lsp = line.split()
        if lsp[2] == "mRNA":
            chr, id = lsp[0], lsp[8].split(";")[0].lstrip("ID=")
            id_chr[id] = chr

out = open(sys.argv[3], 'w')
with open(sys.argv[2], 'r') as f:
    for line in f:
        lsp = line.split("\t")
        if lsp[3] == "Pfam":
            id, start, end, pfam = lsp[0], int(lsp[6]), int(lsp[7]), lsp[4]
            chr = id_chr[id]
            out.write("\t".join([chr, str(start-1), str(end), pfam]) + "\n")

out.close()
