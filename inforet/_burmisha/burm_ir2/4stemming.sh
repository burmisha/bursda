#!/bin/bash
set -x
wget -O - http://en.wikipedia.org/wiki/Wikipedia:Featured_articles | \
 	grep "Bengali_Language_Movement" | tr -s '"' '\n' | \
	grep  '^\/wiki' | awk '{print "http://en.wikipedia.org"$1}' | \
	wget -i - -O lang.html
