#!/bin/bash

CURDIR=`pwd`

rm -rf ${CURDIR}/logs/queryresult*

printf "\n===============================> Loading Data\n"
./reload-gpload.sh

if [ $? -ne 0 ]; then
	printf "Error loading data, exiting...\n"
	exit 1
fi

printf "===============================> Running Queries\n"
./queries.sh

printf "===============================> the following is used for tpch\n"
cat logs/queryresult4tpchform.out
