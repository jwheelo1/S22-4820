#!/bin/bash

function mk_nu_sh {
	cat -n $1 | sed -e 's/\t/    /g' -e 's/^   //' -e 's/    /: /' >$1.nu
}

if ls *.sql >/dev/null 2>&1 ; then
	for i in *.sql ; do
		mk_nu_sh $i
	done
fi

if ls */*.sql >/dev/null 2>&1 ; then
	XXX=$(pwd)
	for i in $( find . -name "*.sql") ; do
		DN=$(dirname $i)
		BN=$(basename $i)
		cd $DN
		mk_nu_sh $BN
		cd $XXX
	done
fi

