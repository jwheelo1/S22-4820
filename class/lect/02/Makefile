
PP=`pwd`
FN=Lect-02
DIR=../../../
IMG=
PY=  \
	CAGGP9/gdp.sql \
	CAGGP9/gdp_post.sql \
	CAGGP9/load_gdp.sql \
	CAGGP9/rpt_wy.sql \
	county/load_vote_by_county.sql \
	county/vote_by_county.sql \
	county/vote_by_county_post.sql \
	county/w0.sql \
	county/what-counties-voted-for-joe.sql \
	county/who-wran-in-2020.sql \
	covid-19-data/load-us-recent.sql \
	covid-19-data/us-counties-recent-post.sql \
	covid-19-data/us-counties-recent.sql \
	growth_by_candidate.sql \
	us_states.sql


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

