import sys

USAGE = "\nusage: python %s <xso_up_2k.fasta> <promoter.gff> <cutoff> <promoter_jbrowse.gff>\n" % sys.argv[0]

if len(sys.argv) != 5:
    print USAGE
    sys.exit()

aDict = {}
with open(sys.argv[1], 'r') as f:
    for line in f:
        if line[0] == ">":
            lsp = line.split()
            gene = lsp[0].lstrip(">")
            chr = lsp[2].split(":")[0]
            start, end = lsp[2].split(":")[1].split("-")
            strand = lsp[3]
            length = lsp[4].split("=")[1]
            aDict[gene] = [chr, int(start), int(end), strand]

cutoff = float(sys.argv[3])
out = open(sys.argv[4], 'w')
with open(sys.argv[2], 'r') as f:
    for line in f:
        if line[0] == "#": continue
        lsp = line.split("\t")
        attri = lsp[8].split(";")[0]
        qvalue =  float(lsp[8].split()[1].split(";")[0])
        if qvalue <= cutoff:
            id  = lsp[0]
            chr, start, end, strand = aDict[id]
            if strand == "FORWARD":
                pstart, pend = start + int(lsp[3]) - 1, start + int(lsp[4])- 1
                temp = lsp[5:8] + [attri]
                out.write("\t".join([chr] + lsp[1:2] + ["promoter"]+ [str(pstart), str(pend)] + temp) + "\n")
            elif strand == "REVERSE":
                pstart, pend = end - int(lsp[4]) + 1, end - int(lsp[3]) + 1
                if lsp[6] == "+":
                    temp = [lsp[5], "-", lsp[7]] + [attri]
                    out.write("\t".join([chr] + lsp[1:2] + ["promoter"]+ [str(pstart), str(pend)] + temp) + "\n")
                elif lsp[6] == "-":
                    temp = [lsp[5], "+", lsp[7]] + [attri]
                    out.write("\t".join([chr] + lsp[1:2] + ["promoter"]+ [str(pstart), str(pend)] + temp) + "\n")
out.close()
