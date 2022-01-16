
PP=`pwd`
FN=Lect-03
DIR=../../../
IMG=
PY=   \
	../02/chk-state-code.sql \
	../02/create-tables.sql \
	../02/death_by_sars_cov_2.sql \
	../02/growth_by_candidate.sql \
	../02/insert3.sql \
	../02/slow-query.sql \
	../02/sum-cases-pct.sql \
	../02/sum-cases.sql \
	../02/us_states.sql  \
	01.out \
	01.sql \
	02.out \
	02.sql \
	03.out \
	03.sql \
	04.out \
	04.sql \
	05.out \
	05.sql \
	06.sql \
	07.sql

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

