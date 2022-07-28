v_sql=$1
/home/hive/presto --server http://pre01:8881 --catalog iceberg  --schema dw_tpch -f ${v_sql} 