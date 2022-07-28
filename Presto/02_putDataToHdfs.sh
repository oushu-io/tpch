#hdfs dfs -rm -r /dbgen/*
hdfs dfs -put -f customer.tbl /dbgen/customer
hdfs dfs -put -f lineitem.tbl /dbgen/lineitem
hdfs dfs -put -f nation.tbl   /dbgen/nation
hdfs dfs -put -f orders.tbl   /dbgen/orders
hdfs dfs -put -f partsupp.tbl /dbgen/partsupp
hdfs dfs -put -f part.tbl     /dbgen/part
hdfs dfs -put -f region.tbl   /dbgen/region
hdfs dfs -put -f supplier.tbl /dbgen/supplier