-------------------------------------------------------------------------------

use dw_hive;
-- hive external table 
CREATE EXTERNAL TABLE IF NOT EXISTS  NATION ( N_NATIONKEY INTEGER ,
                          N_NAME       VARCHAR(25) ,
                          N_REGIONKEY INTEGER ,
                          N_COMMENT   VARCHAR(152))
Row format delimited fields terminated by '|'
Location 'hdfs://oushu/dbgen/nation';

-------------------------------------------------------------------------------

CREATE EXTERNAL  TABLE REGION ( R_REGIONKEY INTEGER ,
                          R_NAME       VARCHAR(25) ,
                          R_COMMENT   VARCHAR(152))
Row format delimited fields terminated by '|'
Location 'hdfs://oushu/dbgen/region';

-------------------------------------------------------------------------------

CREATE EXTERNAL  TABLE IF NOT EXISTS  PART ( P_PARTKEY     INTEGER ,
                        P_NAME       VARCHAR(55) ,
                        P_MFGR       VARCHAR(25) ,
                        P_BRAND       VARCHAR(10) ,
                        P_TYPE       VARCHAR(25) ,
                        P_SIZE       INTEGER ,
                        P_CONTAINER   VARCHAR(10) ,
                        P_RETAILPRICE DECIMAL(15,2) ,
                        P_COMMENT     VARCHAR(23) )
Row format delimited fields terminated by '|'
Location 'hdfs://oushu/dbgen/part';

-------------------------------------------------------------------------------

CREATE EXTERNAL  TABLE IF NOT EXISTS  SUPPLIER ( S_SUPPKEY     INTEGER ,
                            S_NAME       VARCHAR(25) ,
                            S_ADDRESS     VARCHAR(40) ,
                            S_NATIONKEY   INTEGER ,
                            S_PHONE       VARCHAR(15) ,
                            S_ACCTBAL     DECIMAL(15,2) ,
                            S_COMMENT     VARCHAR(101) )
Row format delimited fields terminated by '|'
Location 'hdfs://oushu/dbgen/supplier';

-------------------------------------------------------------------------------

CREATE EXTERNAL  TABLE IF NOT EXISTS  PARTSUPP ( PS_PARTKEY     INTEGER ,
                            PS_SUPPKEY     INTEGER ,
                            PS_AVAILQTY   INTEGER ,
                            PS_SUPPLYCOST DECIMAL(15,2) ,
                            PS_COMMENT     VARCHAR(199) )
Row format delimited fields terminated by '|'
Location 'hdfs://oushu/dbgen/partsupp';

-------------------------------------------------------------------------------

CREATE EXTERNAL  TABLE IF NOT EXISTS  CUSTOMER ( C_CUSTKEY     INTEGER ,
                            C_NAME       VARCHAR(25) ,
                            C_ADDRESS     VARCHAR(40) ,
                            C_NATIONKEY   INTEGER ,
                            C_PHONE       VARCHAR(15) ,
                            C_ACCTBAL     DECIMAL(15,2)   ,
                            C_MKTSEGMENT VARCHAR(10) ,
                            C_COMMENT     VARCHAR(117) )
Row format delimited fields terminated by '|'
Location 'hdfs://oushu/dbgen/customer';

-------------------------------------------------------------------------------

CREATE EXTERNAL  TABLE IF NOT EXISTS  ORDERS ( O_ORDERKEY       INTEGER ,
                          O_CUSTKEY       INTEGER ,
                          O_ORDERSTATUS   VARCHAR(1) ,
                          O_TOTALPRICE     DECIMAL(15,2) ,
                          O_ORDERDATE     DATE ,
                          O_ORDERPRIORITY VARCHAR(15) ,  
                          O_CLERK         VARCHAR(15) , 
                          O_SHIPPRIORITY   INTEGER ,
                          O_COMMENT       VARCHAR(79) )
Row format delimited fields terminated by '|'
Location 'hdfs://oushu/dbgen/orders';						  

-------------------------------------------------------------------------------

CREATE EXTERNAL  TABLE IF NOT EXISTS  LINEITEM ( L_ORDERKEY   INTEGER ,
                            L_PARTKEY     INTEGER ,
                            L_SUPPKEY     INTEGER ,
                            L_LINENUMBER INTEGER ,
                            L_QUANTITY   DECIMAL(15,2) ,
                            L_EXTENDEDPRICE DECIMAL(15,2) ,
                            L_DISCOUNT   DECIMAL(15,2) ,
                            L_TAX         DECIMAL(15,2) ,
                            L_RETURNFLAG VARCHAR(1) ,
                            L_LINESTATUS VARCHAR(1) ,
                            L_SHIPDATE   DATE ,
                            L_COMMITDATE DATE ,
                            L_RECEIPTDATE DATE ,
                            L_SHIPINSTRUCT VARCHAR(25) ,
                            L_SHIPMODE     VARCHAR(10) ,
                            L_COMMENT     VARCHAR(44) )
Row format delimited fields terminated by '|'
Location 'hdfs://oushu/dbgen/lineitem';

-------------------------------------------------------------------------------