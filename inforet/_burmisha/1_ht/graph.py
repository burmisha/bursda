#!/usr/bin/python
import json
import networkx as nx
import sys

def loadgraph(fname):
    G = nx.DiGraph()
    i = 0;
    for line in open(fname):
        i +=1
        if i % 100 == 0:
            print(i)
        j = json.loads(line)
        url = j["url"]
        G.add_node(url, size=int(j['size']))
        for linked_url in j["linkedurls"]:
            G.add_edge(url, linked_url)
    return G

if __name__=='__main__':
    # G = loadgraph("/home/burmisha/github/bursda/inforet/sitegraph/1000_sg.json")
    G = loadgraph("/home/burmisha/github/bursda/inforet/sitegraph/50000_sg.json")
    # G = loadgraph("/home/burmisha/github/bursda/inforet/sitegraph/0527_sitegraph.json")          
    root = "http://simple.wikipedia.org/wiki/Main_Page" 
    
#    stats = open('/home/burmisha/github/bursda/inforet/sitegraph/statistics.txt','w')
#    i = 0
#    for n in G:
#        i += 1
#        if i % 100 == 0:
#            print('%d of %d' % (i, len(G)))
#        # sh_path_len = None
#        try:
#            sh_path_len = len(nx.shortest_path(G, source=root, target=n)) - 1
#        except nx.exception.NetworkXNoPath:
#            sh_path_len = 10000
#        try: 
#            size  = G.node[n]['size']
#        except KeyError:
#            size = 0
#        stats.write('%s\t%d\t%d\t%d\t%d\t%d\n' % (n, i, G.in_degree(n), G.out_degree(n), sh_path_len, size))
#    stats.close()
    
    pr = open('/home/burmisha/github/bursda/inforet/sitegraph/pagerank.txt' ,'w')
    for k,v in sorted(nx.pagerank(G, tol=2e-04).items(), key = lambda x: x[1], reverse=True)[:50]:
        pr.write('%s\t%f\n' % (k,v))
    pr.close()

