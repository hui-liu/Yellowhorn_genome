import sys

# usage
USAGE = "\nusage: python %s [Infomap tree] [level] [output dir]\n" % sys.argv[0]

if len(sys.argv) !=4:
    print USAGE
    sys.exit()


Infomap = open(sys.argv[1], 'r')
Level = int(sys.argv[2])
out_dir = sys.argv[3]

aDict = {}
for line in Infomap:
    lsp = line.split()
    path, gene = lsp[0], lsp[-1]
    module = path.split(":")[:Level]
    if len(module) == Level and 'NA' not in module:
        module_name = "C_" + "_".join(module)
        aDict.setdefault(module_name, []).append(gene)

for m in aDict:
    if len(aDict[m]) >= 10:
        out = out_dir + "/" + m + ".txt"
        with open(out, 'w') as f:
            f.write("\n".join(aDict[m]) + "\n")

Infomap.close()
