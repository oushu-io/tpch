-- Sccsid:     @(#)dss.ddl	2.1.8.1
CREATE TABLE NATION  ( N_NATIONKEY  bigint ,
                            N_NAME       CHAR(25) ,
                            N_REGIONKEY  bigint ,
                            N_COMMENT    VARCHAR(152)) with (APPENDONLY=true,ORIENTATION=orc,COMPRESSTYPE=lz4,dicthreshold=0.8,bucketnum=:bkn) DISTRIBUTED BY (N_NATIONKEY);

CREATE TABLE REGION  ( R_REGIONKEY  bigint ,
                            R_NAME       CHAR(25) ,
                            R_COMMENT    VARCHAR(152)) with (APPENDONLY=true,ORIENTATION=orc,COMPRESSTYPE=lz4,dicthreshold=0.8,bucketnum=:bkn) DISTRIBUTED BY (R_REGIONKEY);

CREATE TABLE PART  ( P_PARTKEY     bigint ,
                          P_NAME        VARCHAR(55) ,
                          P_MFGR        CHAR(25) ,
                          P_BRAND       CHAR(10) ,
                          P_TYPE        VARCHAR(25) ,
                          P_SIZE        bigint ,
                          P_CONTAINER   CHAR(10) ,
                          P_RETAILPRICE DECIMAL(15,2) ,
                          P_COMMENT     VARCHAR(23)  ) with (APPENDONLY=true,ORIENTATION=orc,COMPRESSTYPE=lz4,dicthreshold=0.8,bucketnum=:bkn) DISTRIBUTED BY (P_PARTKEY);

CREATE TABLE SUPPLIER ( S_SUPPKEY     bigint ,
                             S_NAME        CHAR(25) ,
                             S_ADDRESS     VARCHAR(40) ,
                             S_NATIONKEY   bigint ,
                             S_PHONE       CHAR(15) ,
                             S_ACCTBAL     DECIMAL(15,2) ,
                             S_COMMENT     VARCHAR(101) ) with (APPENDONLY=true,ORIENTATION=orc,COMPRESSTYPE=lz4,dicthreshold=0.8,bucketnum=:bkn) DISTRIBUTED BY (S_SUPPKEY);

CREATE TABLE PARTSUPP ( PS_PARTKEY     bigint ,
                             PS_SUPPKEY     bigint ,
                             PS_AVAILQTY    bigint ,
                             PS_SUPPLYCOST  DECIMAL(15,2)  ,
                             PS_COMMENT     VARCHAR(199)  ) with (APPENDONLY=true,ORIENTATION=orc,COMPRESSTYPE=lz4,dicthreshold=0.8,bucketnum=:bkn) DISTRIBUTED BY (PS_PARTKEY);

CREATE TABLE CUSTOMER ( C_CUSTKEY     bigint ,
                             C_NAME        VARCHAR(25) ,
                             C_ADDRESS     VARCHAR(40) ,
                             C_NATIONKEY   bigint ,
                             C_PHONE       CHAR(15) ,
                             C_ACCTBAL     DECIMAL(15,2)   ,
                             C_MKTSEGMENT  CHAR(10) ,
                             C_COMMENT     VARCHAR(117) ) with (APPENDONLY=true,ORIENTATION=orc,COMPRESSTYPE=lz4,dicthreshold=0.8,bucketnum=:bkn) DISTRIBUTED BY (C_CUSTKEY);

CREATE TABLE ORDERS  ( O_ORDERKEY       bigint ,
                           O_CUSTKEY        bigint ,
                           O_ORDERSTATUS    CHAR(1) ,
                           O_TOTALPRICE     DECIMAL(15,2) ,
                           O_ORDERDATE      DATE ,
                           O_ORDERPRIORITY  CHAR(15) ,  -- R
                           O_CLERK          CHAR(15) ,  -- R
                           O_SHIPPRIORITY   bigint ,
                           O_COMMENT        VARCHAR(79) ) with (APPENDONLY=true,ORIENTATION=orc,COMPRESSTYPE=lz4,dicthreshold=0.8,bucketnum=:bkn) DISTRIBUTED BY (O_ORDERKEY);

CREATE TABLE LINEITEM ( L_ORDERKEY    bigint ,
                             L_PARTKEY     bigint ,
                             L_SUPPKEY     bigint ,
                             L_LINENUMBER  bigint ,
                             L_QUANTITY    DECIMAL(15,2) ,
                             L_EXTENDEDPRICE  DECIMAL(15,2) ,
                             L_DISCOUNT    DECIMAL(15,2) ,
                             L_TAX         DECIMAL(15,2) ,
                             L_RETURNFLAG  CHAR(1) ,
                             L_LINESTATUS  CHAR(1) ,
                             L_SHIPDATE    DATE ,
                             L_COMMITDATE  DATE ,
                             L_RECEIPTDATE DATE ,
                             L_SHIPINSTRUCT CHAR(25) ,  -- R
                             L_SHIPMODE     CHAR(10) ,  -- R
                             L_COMMENT      VARCHAR(44) ) with (APPENDONLY=true,ORIENTATION=orc,COMPRESSTYPE=lz4,dicthreshold=0.8,bucketnum=:bkn) DISTRIBUTED BY (L_ORDERKEY);

