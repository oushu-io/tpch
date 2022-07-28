
v_sql=$1
#time /home/hive/presto --server http://pre01:8881 --catalog iceberg  --schema dw_cc -f SQL/${v_sql} >/data/tpch/tmp/${v_sql}.log 
time java -Xmx6G -jar /home/hive/presto --server http://pre01:8881 --catalog iceberg  --schema dw_cc -f SQL/${v_sql} >/data/tpch/tmp/${v_sql}.log 