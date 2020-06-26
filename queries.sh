#!/bin/bash

DATASIZE=`grep DATASIZE tpch.config|awk -F '=' '{print $2}'`
QUERY_STREAMS=`grep QUERY_STREAMS tpch.config|awk -F '=' '{print $2}'`

if [ ${QUERY_STREAMS} -gt 40 ]; then
	echo "Usage:$0 the QUERY_STREAMS exceeding the maximum limit of 40"
	exit
fi

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

start_query()
{

        while read i
        do

                echo ================================================================= >> logs/queries${1}.out
                echo ======================= Query Number ${i} ======================= >> logs/queries${1}.out
                echo ================================================================= >> logs/queries${1}.out

                start=$(date +%s.%N)

                psql -d tpch -v fct=${DATASIZE} -f ${CURDIR}/WORK/query${i}.sql >> logs/queries${1}.out 2>&1

                end=$(date +%s.%N)

                getTiming $start $end

                echo "TPCDSQuery ${i}: ${time} ms"  >> logs/sem${1}.out

        done < ${CURDIR}/WORK/stream${1}.sem

}

if [ $QUERY_STREAMS -gt 1 ];then 

        startall=$(date +%s.%N)
        for ((c = 1; c <= $QUERY_STREAMS; ++c)); do
                echo > logs/queries${c}.out
                echo "===============================>TPCDSQuery stream ${c}" > logs/sem${c}.out
                start_query ${c} &
        done

        wait

        for ((c = 1; c <= $QUERY_STREAMS; ++c)); do
                cat logs/sem${c}.out >> logs/queryresult4tpchform.out
        done

        endall=$(date +%s.%N)

        getTiming $startall $endall

        echo "SF is: "$DATASIZE >> logs/queryresult4tpchform.out

        echo "total time : ${time} ms" >> logs/queryresult4tpchform.out

else

        startall=$(date +%s.%N)
        echo > logs/queries0.out
        echo "===============================>TPCDSQuery stream 0" > logs/sem0.out
        start_query 0
        cat logs/sem0.out >> logs/queryresult4tpchform.out
        endall=$(date +%s.%N)

        getTiming $startall $endall

        echo "SF is: "$DATASIZE >> logs/queryresult4tpchform.out

        echo "total time : ${time} ms" >> logs/queryresult4tpchform.out

fi
