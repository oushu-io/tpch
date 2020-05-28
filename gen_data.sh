#!/bin/bash

BASH_PROFILE="/usr/local/hawq/greenplum_path.sh"
source ${BASH_PROFILE}

GPLOAD_HOST=`grep GPLOAD_HOST tpch.config|awk -F '=' '{print $2}'`
CURDIR=`pwd`
DATASIZE=`grep DATASIZE tpch.config|awk -F '=' '{print $2}'`
PARALLEL=`grep PARALLEL tpch.config|awk -F '=' '{print $2}'`

DIRS=`grep DIRS tpch.config|awk -F '=' '{print $2}'`

slaveNum=0
arrslave=(${GPLOAD_HOST//,/ })
for islave in ${arrslave[@]}
do
	let "slaveNum += 1"
done

folderNum=0
arrdir=(${DIRS//,/ })
for idir in ${arrdir[@]}
do
	let "folderNum += 1"
done

totalparallel=$((PARALLEL * folderNum * slaveNum))

start_dbgen()
{
	ssh ${1} "cd ${3}/tpch/${DATASIZE};${CURDIR}/dbgen/dbgen -b ${CURDIR}/dbgen/dists.dss -s ${DATASIZE} -C $totalparallel -S ${2} -f"
        ssh ${1} "cd ${3}/tpch/${DATASIZE};rm -f nation.tbl;rm -f region.tbl;touch nation.tbl;touch region.tbl"
}

ic=1
arrdir=(${DIRS//,/ })
for idir in ${arrdir[@]}
do
	arrslave=(${GPLOAD_HOST//,/ })
	for islave in ${arrslave[@]}
	do
		ssh ${islave} "rm -rf ${idir}/tpch/${DATASIZE}"
		ssh ${islave} "mkdir -p ${idir}/tpch/${DATASIZE}"
		for ((counter = 1; counter <= $PARALLEL; ++counter)); do
			start_dbgen ${islave} ${ic} ${idir} &
			sleep 1
			let "ic += 1"
		done
	done
	wait
done
cd ${idir}/tpch/${DATASIZE};${CURDIR}/dbgen/dbgen -b ${CURDIR}/dbgen/dists.dss -T n -s ${DATASIZE} -f
cd ${idir}/tpch/${DATASIZE};${CURDIR}/dbgen/dbgen -b ${CURDIR}/dbgen/dists.dss -T r -s ${DATASIZE} -f

wait

