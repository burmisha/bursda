#!/bin/bash
set -x
# cut -d , -f2 test.txt | sort -un | grep -v qid >in_qid.txt
# cut -d , -f2 test.txt | sort -un | grep -v qid | tr '\n' '|'
#head -1 test.txt >learn.txt
head -100000 learn_raw.txt | awk -F, 'BEGIN{
	while(getline <"in_qid.txt"){
		a[$1]=1;
	}
	}
	{
		{print $2","a[$2]","a[7802];}
	}'  | grep -v ",," 
