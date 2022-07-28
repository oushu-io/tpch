v_sql=$1
time /home/hive/presto --server http://pre01:8881 --catalog iceberg  --schema dw_tpch -f SQL/${v_sql} >/data/tpch/tmp/${v_sql}.log 
#time java -Xmx1G -jar /home/hive/presto --server http://pre01:8881 --catalog iceberg  --schema dw_tpch -f SQL/${v_sql} >/data/tpch/tmp/${v_sql}.log 
    