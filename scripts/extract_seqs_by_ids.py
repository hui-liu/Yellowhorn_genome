import sys
USAGE = "\nusage: python  %s sequences.fasta id_list out.fasta\n" % sys.argv[0]
if len(sys.argv) != 4:
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
fas = parseFasta(sys.argv[1])
IDs = open(sys.argv[2], 'r')
OUT = open(sys.argv[3], 'w')
for line in IDs:
     id = line.rstrip("\n")
     OUT.write(">" + id + "\n" + fas[id] + "\n")
IDs.close()
OUT.close()
