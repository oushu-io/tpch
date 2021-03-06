-- Sccsid:     @(#)dss.ddl	2.1.8.1
CREATE TABLE NATION  ( N_NATIONKEY  bigint NOT NULL,
                            N_NAME       CHAR(25) NOT NULL,
                            N_REGIONKEY  bigint NOT NULL,
                            N_COMMENT    VARCHAR(152)) WITH (appendonly=true,orientation=PARQUET,COMPRESSTYPE=snappy,bucketnum=:bkn) DISTRIBUTED BY (N_NATIONKEY);

CREATE TABLE REGION  ( R_REGIONKEY  bigint NOT NULL,
                            R_NAME       CHAR(25) NOT NULL,
                            R_COMMENT    VARCHAR(152)) WITH (appendonly=true,orientation=PARQUET,COMPRESSTYPE=snappy,bucketnum=:bkn) DISTRIBUTED BY (R_REGIONKEY);

CREATE TABLE PART  ( P_PARTKEY     bigint NOT NULL,
                          P_NAME        VARCHAR(55) NOT NULL,
                          P_MFGR        CHAR(25) NOT NULL,
                          P_BRAND       CHAR(10) NOT NULL,
                          P_TYPE        VARCHAR(25) NOT NULL,
                          P_SIZE        bigint NOT NULL,
                          P_CONTAINER   CHAR(10) NOT NULL,
                          P_RETAILPRICE DECIMAL(15,2) NOT NULL,
                          P_COMMENT     VARCHAR(23) NOT NULL ) WITH (appendonly=true,orientation=PARQUET,COMPRESSTYPE=snappy,bucketnum=:bkn) DISTRIBUTED BY (P_PARTKEY);

CREATE TABLE SUPPLIER ( S_SUPPKEY     bigint NOT NULL,
                             S_NAME        CHAR(25) NOT NULL,
                             S_ADDRESS     VARCHAR(40) NOT NULL,
                             S_NATIONKEY   bigint NOT NULL,
                             S_PHONE       CHAR(15) NOT NULL,
                             S_ACCTBAL     DECIMAL(15,2) NOT NULL,
                             S_COMMENT     VARCHAR(101) NOT NULL) WITH (appendonly=true,orientation=PARQUET,COMPRESSTYPE=snappy,bucketnum=:bkn) DISTRIBUTED BY (S_SUPPKEY);

CREATE TABLE PARTSUPP ( PS_PARTKEY     bigint NOT NULL,
                             PS_SUPPKEY     bigint NOT NULL,
                             PS_AVAILQTY    bigint NOT NULL,
                             PS_SUPPLYCOST  DECIMAL(15,2)  NOT NULL,
                             PS_COMMENT     VARCHAR(199) NOT NULL ) WITH (appendonly=true,orientation=PARQUET,COMPRESSTYPE=snappy,bucketnum=:bkn) DISTRIBUTED BY (PS_PARTKEY);

CREATE TABLE CUSTOMER ( C_CUSTKEY     bigint NOT NULL,
                             C_NAME        VARCHAR(25) NOT NULL,
                             C_ADDRESS     VARCHAR(40) NOT NULL,
                             C_NATIONKEY   bigint NOT NULL,
                             C_PHONE       CHAR(15) NOT NULL,
                             C_ACCTBAL     DECIMAL(15,2)   NOT NULL,
                             C_MKTSEGMENT  CHAR(10) NOT NULL,
                             C_COMMENT     VARCHAR(117) NOT NULL) WITH (appendonly=true,orientation=PARQUET,COMPRESSTYPE=snappy,bucketnum=:bkn) DISTRIBUTED BY (C_CUSTKEY);

CREATE TABLE ORDERS  ( O_ORDERKEY       bigint NOT NULL,
                           O_CUSTKEY        bigint NOT NULL,
                           O_ORDERSTATUS    CHAR(1) NOT NULL,
                           O_TOTALPRICE     DECIMAL(15,2) NOT NULL,
                           O_ORDERDATE      DATE NOT NULL,
                           O_ORDERPRIORITY  CHAR(15) NOT NULL,  -- R
                           O_CLERK          CHAR(15) NOT NULL,  -- R
                           O_SHIPPRIORITY   bigint NOT NULL,
                           O_COMMENT        VARCHAR(79) NOT NULL) WITH (appendonly=true,orientation=PARQUET,COMPRESSTYPE=snappy,bucketnum=:bkn) DISTRIBUTED BY (O_ORDERKEY);

CREATE TABLE LINEITEM ( L_ORDERKEY    bigint NOT NULL,
                             L_PARTKEY     bigint NOT NULL,
                             L_SUPPKEY     bigint NOT NULL,
                             L_LINENUMBER  bigint NOT NULL,
                             L_QUANTITY    DECIMAL(15,2) NOT NULL,
                             L_EXTENDEDPRICE  DECIMAL(15,2) NOT NULL,
                             L_DISCOUNT    DECIMAL(15,2) NOT NULL,
                             L_TAX         DECIMAL(15,2) NOT NULL,
                             L_RETURNFLAG  CHAR(1) NOT NULL,
                             L_LINESTATUS  CHAR(1) NOT NULL,
                             L_SHIPDATE    DATE NOT NULL,
                             L_COMMITDATE  DATE NOT NULL,
                             L_RECEIPTDATE DATE NOT NULL,
                             L_SHIPINSTRUCT CHAR(25) NOT NULL,  -- R
                             L_SHIPMODE     CHAR(10) NOT NULL,  -- R
                             L_COMMENT      VARCHAR(44) NOT NULL) WITH (appendonly=true,orientation=PARQUET,COMPRESSTYPE=snappy,bucketnum=:bkn) DISTRIBUTED BY (L_ORDERKEY);

