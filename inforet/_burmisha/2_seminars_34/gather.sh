#!/bin/bash
set -x
wget -O best.html http://ru.wikipedia.org/wiki/%D0%92%D0%B8%D0%BA%D0%B8%D0%BF%D0%B5%D0%B4%D0%B8%D1%8F:%D0%A1%D0%BF%D0%B8%D1%81%D0%BE%D0%BA_%D0%B8%D0%B7%D0%B1%D1%80%D0%B0%D0%BD%D0%BD%D1%8B%D1%85_%D1%81%D1%82%D0%B0%D1%82%D0%B5%D0%B9/2005

cat best.html | grep "^<h2" | tail -50 | \
	sed 's|<span class="mw-editsection">.*||g' | sed 's|.*<a||g' | sed 's|title.*||g' | 	\
	sed 's|.*href="|http://ru.wikipedia.org|g' | sed 's|".*||g' >links.html

cat links.html | wget -i - -O html.html
cat html.html | sed 's|[-_<>":;]| |g' | sed 's|[^а-яА-Я ]||g' >words.html
./ngrams.py	

# cat html.html  | tr -s '\n' ' ' | sed 's|<script>|<script |g' | sed 's|</script>|>|g' >no_scripts.html
# cat no_scripts.html  | sed 's|<style\( type="text/css"\)\?>|<style |g' | sed 's|</style>|>|g' >no_style.html
# cat no_style.html     | sed 's|<[^>]*>||g' >no_tags.html
# cat no_tags.html      | sed 's|<[-][-][^>]*>||g' >no_ie.html
# cat no_ie.html      | sed 's|&.\{2,4\};| |g' >words.html

	# | sed 's|[ \t\n][ \t\n]| |g' | sed 's|[ \t\n][ \t\n]| |g' | sed 's|[ \t\n][ \t\n]| |g' \
	# | sed 's|^ ||g' | sed 's| $||g' \
	# | sed 's|^ ||g' | sed 's| $||g' \
	# | sed 's|[ \t\n][ \t\n]| |g' | sed 's|[ \t\n][ \t\n]| |g' | sed 's|[ \t\n][ \t\n]| |g' \
