insert into iceberg.dw_tpch.CUSTOMER select * from dataload.dw_hive.CUSTOMER;
insert into iceberg.dw_tpch.NATION select * from dataload.dw_hive.NATION;
insert into iceberg.dw_tpch.PART select * from dataload.dw_hive.PART;
insert into iceberg.dw_tpch.REGION select * from dataload.dw_hive.REGION;
insert into iceberg.dw_tpch.SUPPLIER select * from dataload.dw_hive.SUPPLIER;
insert into iceberg.dw_tpch.ORDERS select * from dataload.dw_hive.ORDERS;
insert into iceberg.dw_tpch.PARTSUPP select * from dataload.dw_hive.PARTSUPP;
insert into iceberg.dw_tpch.LINEITEM select * from dataload.dw_hive.LINEITEM;