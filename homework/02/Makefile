
PP=`pwd`
FN=Assignment-02
DIR=../../
IMG=
PY=    \
	ans-count-counties.sql \
	ans-per-capita-by-candidate.sql \
	bea_growth_data.sql \
	load-bea-data.sql \
	per-county-winner.sql

all: setup all2

setup:
	../mk_all_nu.sh

all2: ${FN}.html ${PY}


#%.html: %.raw.md
#	../mk_html.sh $< $@ 

#%.pdf: %.md
#	~/bin/md-to-pdf.sh $<

.PRECIOUS: %.md 
%.md: %.raw.md $(PY) $(IMG)
	m4 -P $< >$@

%.html: %.md
	blackfriday-tool ./$< $@
	echo cat ./${DIR}/css/md.css $@ >/tmp/$@
	cat ./${DIR}/css/pre ./${DIR}/css/markdown.css ./${DIR}/css/post ./${DIR}/css/md.css ./${DIR}/css/hpre $@ ./${DIR}/css/hpost >/tmp/$@
	mv /tmp/$@ ./$@
	echo "file://${PP}/$@" >>open.1

