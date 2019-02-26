import sys

USAGE = "\nTSS -2000bp\nusage: python %s genome.fasta upstream_size gffile out.fasta\n" % sys.argv[0]

if len(sys.argv) != 5:
    print USAGE
    sys.exit()

def parseFasta(filename):
    fas = {}
    id = None
    with open(filename, 'r') as fh:
        for line in fh:
            if line[0] == '>':
                header = line[1:].rstrip()
                id = header.split()[0]
                fas[id] = []
            else:
                fas[id].append(line.rstrip())
        for id, seq in fas.iteritems():
            fas[id] = ''.join(seq)
    return fas

def upstream2k(filename, fas, length):
    up2kcoor = {}
    with open(filename, 'r') as f:
        for line in f:
            lsplit = line.split()
            if "gene" == lsplit[2] and "+" == lsplit[6] and int(lsplit[3]) > 1:
                id = lsplit[8].split(";")[0].lstrip("ID=")
                start = int(lsplit[3]) - length - 1 if int(lsplit[3]) - length - 1 > 0 else 0
                end = int(lsplit[3]) - 1 if int(lsplit[3]) - 1 <= len(fas[lsplit[0]]) else len(fas[lsplit[0]])
                up2kcoor.setdefault(lsplit[0], []).append([start, end, lsplit[6], id])
            elif "gene" == lsplit[2] and "-" == lsplit[6] and int(lsplit[4]) < len(fas[lsplit[0]]):
                id = lsplit[8].split(";")[0].lstrip("ID=")
                start = int(lsplit[4]) if int(lsplit[4]) > 0 else 0
                end = int(lsplit[4]) + length if int(lsplit[4]) + length <= len(fas[lsplit[0]]) else len(fas[lsplit[0]])
                up2kcoor.setdefault(lsplit[0], []).append([start, end, lsplit[6], id])
    return up2kcoor

def revcomp(seq):
    bases = 'ABCDGHKMNRSTUVWXYabcdghkmnrstuvwxyTVGHCDMKNYSAABWXRtvghcdmknysaabwxr'
    complement_dict = {bases[i]:bases[i+34] for i in range(34)}
    seq = reversed(seq)
    result = [complement_dict[base] for base in seq]
    return ''.join(result)

fas = parseFasta(sys.argv[1])
# upstream
length = int(sys.argv[2])
up2kcoor = upstream2k(sys.argv[3], fas, length)
OUT = open(sys.argv[4], 'w')

for i in up2kcoor:
    for j in up2kcoor[i]:
        if j[1] == j[0]:
            continue
        elif j[2] =="-":
            seq = revcomp(fas[i][j[0]: j[1]])
            if seq.count("N") + seq.count("n") == length:
                continue
            else:
                OUT.write(">" + j[3] + " | " + i + ":" + str(j[0] + 1) + "-" + str(j[1]) + " REVERSE " + "LENGTH=" + str(j[1] -j[0])
        elif j[2] =="+":
            seq = fas[i][j[0]: j[1]]
            if seq.count("N") + seq.count("n") == length:
                continue
            else:
                OUT.write(">" + j[3] + " | " + i + ":" + str(j[0] + 1) + "-" + str(j[1]) + " FORWARD " + "LENGTH=" + str(j[1] -j[0])
OUT.close()
