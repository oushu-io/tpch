#!/bin/bash

##GPLOAD_HOST: the host which will run gpfdist
##need change
GPLOAD_HOST=`grep GPLOAD_HOST tpch.config|awk -F '=' '{print $2}'`

##the destination database host
##need change
GP_DBHOST=`grep GP_DBHOST tpch.config|awk -F '=' '{print $2}'`

BASH_PROFILE=`grep BASH_PROFILE tpch.config|awk -F '=' '{print $2}'`
#type 'p' table ORIENTATION is parquet, 'o' table format is orc ,'m' table format is magmaap
DDLTYPE=`grep DDLTYPE tpch.config|awk -F '=' '{print $2}'`
DATASIZE=`grep DATASIZE tpch.config|awk -F '=' '{print $2}'`
T_DATA_DIR=`grep DIRS tpch.config|awk -F '=' '{print $2}'`
INSERT_STREAMS=`grep INSERT_STREAMS tpch.config|awk -F '=' '{print $2}'`
ISGENDATA=`grep ISGENDATA tpch.config|awk -F '=' '{print $2}'`

time=""
CURDIR=`pwd`
rm -rf ${CURDIR}/logs/insert*

echo > logs/queryresult4tpchform.out

errexit99()
{
        if [ $1 -ne 0 ]
        then
        echo "[ERROR]: EXCEPTION EXIT"
        exit 1
        fi
}

runCmd() {

COMMAND="$1"
declare RETVAL

printf "\nRunning command \"%s\" ..." "$COMMAND"
bash -l -c "$COMMAND" >& sysout
RETVAL=$?

if [ $RETVAL -ne 0 ]; then
	printf "\nError running command %s\nExiting...\n" "$COMMAND"
	printf "\nOutput is in file %s\n" `pwd`/sysout
	exit 1
else
	printf "done.\n"
	rm -f sysout
fi

}

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

runGpload() {

export PGDATABASE=tpch

TBNAME=$1

d_gpfdist_ips=
d_ext_create=

arrhost=(${GPLOAD_HOST//,/ })
for i in ${arrhost[@]}
do

	T_PORT=8888

	arr=(${T_DATA_DIR//,/ })
	for i_t_data_dir in ${arr[@]}
	do

	d_gpfdist_ips="${d_gpfdist_ips},'gpfdist://${i}:${T_PORT}/tpch/${DATASIZE}/${TBNAME}.tbl*'"

	sleep 1

	let "T_PORT += 1"

	done

done

#echo ${d_gpfdist_ips}

d_ext_create="drop  EXTERNAL TABLE if exists ext_${TBNAME};             \
	      CREATE READABLE EXTERNAL TABLE ext_${TBNAME} (like ${TBNAME})     \
	      LOCATION(${d_gpfdist_ips#,})                         \
	      FORMAT 'CSV' (DELIMITER '|' NULL '');"

psql -v ON_ERROR_STOP=1 -h $GP_DBHOST -c "$d_ext_create"
errexit99 $?

echo "\timing
set gp_autostats_mode='NONE';
insert into ${TBNAME} select * from ext_${TBNAME};"|psql -v ON_ERROR_STOP=1 -h $GP_DBHOST -At
errexit99 $?

psql -v ON_ERROR_STOP=1 -h $GP_DBHOST  -Atc "ANALYZE ${TBNAME};"
errexit99 $?

}

export PGDATABASE=tpch

runCmd "psql -d postgres -c 'drop database if exists $PGDATABASE'"
#runCmd "createdb $PGDATABASE -E SQL_ASCII"
runCmd "createdb $PGDATABASE"

if [ "${DDLTYPE}" = "p" ];then
	runCmd "psql -d $PGDATABASE -f dss.ddl"
elif [ "${DDLTYPE}" = "o" ];then
	runCmd "psql -d $PGDATABASE -f dss.ddl.orc"
elif [ "${DDLTYPE}" = "m" ];then
	runCmd "psql -d $PGDATABASE -f dss.ddl.magmaap"
else
	runCmd "psql -d $PGDATABASE -f dss.ddl"
fi

if [ ${ISGENDATA} -eq 1 ];then

runCmd "./gen_data.sh"

fi

sh gpfdist_create.sh
errexit99 $?

printf '\n'

if [ ${INSERT_STREAMS} -gt 1 ];then

	startall=$(date +%s.%N)

	for table in nation region part supplier partsupp customer orders lineitem
	do
		while [ `ps -ef|grep reload-gpload|grep -v grep|wc -l` -gt ${INSERT_STREAMS} ]
		do
			sleep 3
		done
		printf 'Loading and analyzing table: %s ...' $table
		runGpload $table > logs/insert$table.out 2>&1 &
	done

	wait

	endall=$(date +%s.%N)

	getTiming $startall $endall

	for table in nation region part supplier partsupp customer orders lineitem
	do
		cat logs/insert$table.out >> logs/queryresult4tpchform.out
	done

	echo "total insert time : ${time} ms" >> logs/queryresult4tpchform.out

else

	startall=$(date +%s.%N)

	for table in nation region part supplier partsupp customer orders lineitem
	do
		printf 'Loading and analyzing table: %s ...' $table
		runGpload $table >> logs/queryresult4tpchform.out
	done

	endall=$(date +%s.%N)

	getTiming $startall $endall

	echo "total insert time : ${time} ms" >> logs/queryresult4tpchform.out

fi

printf '\n'

psql -c "Select relname,pg_size_pretty(pg_total_relation_size(oid)) from pg_class where relname in ('lineitem','orders','nation','region','partsupp','part','supplier','customer') order by pg_total_relation_size(oid) desc"
