#!/bin/bash

if ls *.sql >/dev/null 2>&1 ; then
	for i in *.sql ; do
		../mk_nu.sh $i
	done
fi

if ls */*.sql >/dev/null 2>&1 ; then
	XXX=$(pwd)
	for i in $( find . -name "*.sql") ; do
		DN=$(dirname $i)
		BN=$(basename $i)
		cd $DN
		$XXX/../mk_nu.sh $BN
		cd $XXX
	done
fi

