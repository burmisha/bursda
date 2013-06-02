#!/usr/bin/python
if __name__=='__main__':
    for N in range(2,6):
	    freq = dict()
	    words = open('words.html', 'r')
	    for line in words.readlines():
	        for word in [w for w in line.strip().decode('utf-8').lower().split(' ') if len(w) >= N]:
	        	for Ngram in [word[i:i+N] for i in range(0,len(word) - N + 1)]:
		            if Ngram in freq: 
		                freq[Ngram] += 1
		            else:
		                freq[Ngram] = 1
	    words.close()
	    
	    out = open('freq_%d.txt' % N, 'w')
	    for w,n in sorted(freq.items(), key = lambda x: x[1], reverse=True):
	        out.write('%s,%d\n' % (w.encode('utf-8'),n))
	    out.close()
