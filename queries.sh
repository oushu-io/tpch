#!/bin/bash

QUERY_STREAMS=`grep QUERY_STREAMS tpch.config|awk -F '=' '{print $2}'`
DDLTYPE=`grep DDLTYPE tpch.config|awk -F '=' '{print $2}'`
DATASIZE=`grep DATASIZE tpch.config|awk -F '=' '{print $2}'`

time=""
CURDIR=`pwd`
rm -rf ${CURDIR}/logs/sem*
rm -rf ${CURDIR}/logs/queries*

getTiming()
{

    start=$1
    end=$2

    start_s=$(echo $start | cut -d '.' -f 1)
    start_ns=$(echo $start | cut -d '.' -f 2)
    end_s=$(echo $end | cut -d '.' -f 1)
    end_ns=$(echo $end | cut -d '.' -f 2)

    time=$(( ( 10#$end_s - 10#$start_s ) * 1000 + ( 10#$end_ns / 1000000 - 10#$start_ns / 1000000 ) ))

}

startall=$(date +%s.%N)

for ((c = 1; c <= $QUERY_STREAMS; ++c));do

	if [ "${DDLTYPE}" = "p" ];then

		echo " ===============================> TPCHQuery stream ${c}" > logs/queries${c}.out

		psql -d tpch -f queries.sql >> logs/queries${c}.out 2>&1 &

	else

		echo " ===============================> TPCHQuery stream ${c}" > logs/queries${c}.out

		psql -d tpch -f queries_new.sql >> logs/queries${c}.out 2>&1 &

	fi

done

wait

endall=$(date +%s.%N)

getTiming $startall $endall

grep -i TPCHQuery logs/queries*.out >> logs/queryresult4tpchform.out
echo "SF is: "$DATASIZE >> logs/queryresult4tpchform.out
echo "total time : ${time} ms" >> logs/queryresult4tpchform.out
