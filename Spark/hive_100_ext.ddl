drop  table NATION_100_ext;
CREATE external TABLE NATION_100_ext  ( N_NATIONKEY  INTEGER ,
                            N_NAME       string ,
                            N_REGIONKEY  INTEGER ,
                            N_COMMENT    string) row format delimited fields terminated by '|' location 'hdfs://train:9000/hawq/exportdata/100/nation';
drop  table REGION_100_ext;
CREATE external TABLE REGION_100_ext  ( R_REGIONKEY  INTEGER ,
                            R_NAME       string ,
                            R_COMMENT    string) row format delimited fields terminated by '|' location 'hdfs://train:9000/hawq/exportdata/100/region';
drop  table part_100_ext;
CREATE external TABLE PART_100_ext  ( P_PARTKEY     INTEGER ,
                          P_NAME        string ,
                          P_MFGR        string ,
                          P_BRAND       string ,
                          P_TYPE        string ,
                          P_SIZE        INTEGER ,
                          P_CONTAINER   string ,
                          P_RETAILPRICE DECIMAL(15,2) ,
                          P_COMMENT     string  ) row format delimited fields terminated by '|' location 'hdfs://train:9000/hawq/exportdata/100/part';
drop  table SUPPLIER_100_ext;
CREATE external TABLE SUPPLIER_100_ext ( S_SUPPKEY     INTEGER ,
                             S_NAME        string ,
                             S_ADDRESS     string ,
                             S_NATIONKEY   INTEGER ,
                             S_PHONE       string ,
                             S_ACCTBAL     DECIMAL(15,2) ,
                             S_COMMENT     string ) row format delimited fields terminated by '|' location 'hdfs://train:9000/hawq/exportdata/100/supplier';
drop  table PARTSUPP_100_ext;
CREATE external TABLE PARTSUPP_100_ext ( PS_PARTKEY     INTEGER ,
                             PS_SUPPKEY     INTEGER ,
                             PS_AVAILQTY    INTEGER ,
                             PS_SUPPLYCOST  DECIMAL(15,2)  ,
                             PS_COMMENT     string  ) row format delimited fields terminated by '|' location 'hdfs://train:9000/hawq/exportdata/100/partsupp';
drop  table CUSTOMER_100_ext;
CREATE external TABLE CUSTOMER_100_ext ( C_CUSTKEY     INTEGER ,
                             C_NAME        string ,
                             C_ADDRESS     string ,
                             C_NATIONKEY   INTEGER ,
                             C_PHONE       string ,
                             C_ACCTBAL     DECIMAL(15,2)   ,
                             C_MKTSEGMENT  string ,
                             C_COMMENT     string ) row format delimited fields terminated by '|' location 'hdfs://train:9000/hawq/exportdata/100/customer';
drop  table ORDERS_100_ext;
CREATE external TABLE ORDERS_100_ext  ( O_ORDERKEY       INTEGER ,
                           O_CUSTKEY        INTEGER ,
                           O_ORDERSTATUS    string ,
                           O_TOTALPRICE     DECIMAL(15,2) ,
                           O_ORDERDATE      DATE ,
                           O_ORDERPRIORITY  string,  -- R
                           O_CLERK          string ,  -- R
                           O_SHIPPRIORITY   INTEGER ,
                           O_COMMENT        string ) row format delimited fields terminated by '|' location 'hdfs://train:9000/hawq/exportdata/100/orders';
drop  table LINEITEM_100_ext;
CREATE external TABLE LINEITEM_100_ext ( L_ORDERKEY    INTEGER ,
                             L_PARTKEY     INTEGER ,
                             L_SUPPKEY     INTEGER ,
                             L_LINENUMBER  INTEGER ,
                             L_QUANTITY    DECIMAL(15,2) ,
                             L_EXTENDEDPRICE  DECIMAL(15,2) ,
                             L_DISCOUNT    DECIMAL(15,2) ,
                             L_TAX         DECIMAL(15,2) ,
                             L_RETURNFLAG  string ,
                             L_LINESTATUS  string ,
                             L_SHIPDATE    DATE ,
                             L_COMMITDATE  DATE ,
                             L_RECEIPTDATE DATE ,
                             L_SHIPINSTRUCT string ,  -- R
                             L_SHIPMODE     string ,  -- R
                             L_COMMENT      string ) row format delimited fields terminated by '|' location 'hdfs://train:9000/hawq/exportdata/100/lineitem';
