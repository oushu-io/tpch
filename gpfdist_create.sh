#!/bin/bash

BASH_PROFILE=`grep BASH_PROFILE tpch.config|awk -F '=' '{print $2}'`
source ${BASH_PROFILE}
export PGCLIENTENCODING=UTF8

T_DATA_DIR=`grep DIRS tpch.config| awk -F '=' '{print $2}'`
GPLOAD_HOST=`grep GPLOAD_HOST tpch.config| awk -F '=' '{print $2}'`

errexit99()
{
        if [ $1 -ne 0 ]
        then
        echo "[ERROR]: EXCEPTION EXIT"
        exit 1
        fi
}

arrhost=(${GPLOAD_HOST//,/ })
for i in ${arrhost[@]}
do
    T_PORT=8888

    d_tmp=$i

    ssh $d_tmp "ps -ef|grep "gpfdist -d*"|grep -v grep|awk '{print \$2}'|xargs kill -9" >& /dev/null
 
    arr=(${T_DATA_DIR//,/ })
    for i_t_data_dir in ${arr[@]}
    do

	    ssh $d_tmp "source ${BASH_PROFILE};gpfdist -d ${i_t_data_dir} -p ${T_PORT} > /dev/null &"

	    sleep 3

	    let "T_PORT += 1"

    done

done
