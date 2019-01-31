import json
import sys

# load json file
with open(sys.argv[1], "r") as read_file:
    data = json.load(read_file)

net = data['elements']
nodes = net['nodes']
edges = net['edges']

nodes_info = {i['data']['id']: i['data']['name'] for i in nodes}

out = open(sys.argv[2], 'w')
for i in edges:
    out.write("\t".join([nodes_info[i['data']['source']], nodes_info[i['data']['target']],
              str(float(i['data']['cor']))]) + "\n")
out.close()
