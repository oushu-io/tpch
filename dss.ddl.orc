-- Sccsid:     @(#)dss.ddl	2.1.8.1
CREATE TABLE NATION  ( N_NATIONKEY  INTEGER ,
                            N_NAME       CHAR(25) ,
                            N_REGIONKEY  INTEGER ,
                            N_COMMENT    VARCHAR(152)) format 'orc' (compresstype 'lz4') DISTRIBUTED BY (N_NATIONKEY);

CREATE TABLE REGION  ( R_REGIONKEY  INTEGER ,
                            R_NAME       CHAR(25) ,
                            R_COMMENT    VARCHAR(152)) format 'orc' (compresstype 'lz4') DISTRIBUTED BY (R_REGIONKEY);

CREATE TABLE PART  ( P_PARTKEY     INTEGER ,
                          P_NAME        VARCHAR(55) ,
                          P_MFGR        CHAR(25) ,
                          P_BRAND       CHAR(10) ,
                          P_TYPE        VARCHAR(25) ,
                          P_SIZE        INTEGER ,
                          P_CONTAINER   CHAR(10) ,
                          P_RETAILPRICE DECIMAL(15,2) ,
                          P_COMMENT     VARCHAR(23)  ) format 'orc' (compresstype 'lz4') DISTRIBUTED BY (P_PARTKEY);

CREATE TABLE SUPPLIER ( S_SUPPKEY     INTEGER ,
                             S_NAME        CHAR(25) ,
                             S_ADDRESS     VARCHAR(40) ,
                             S_NATIONKEY   INTEGER ,
                             S_PHONE       CHAR(15) ,
                             S_ACCTBAL     DECIMAL(15,2) ,
                             S_COMMENT     VARCHAR(101) ) format 'orc' (compresstype 'lz4') DISTRIBUTED BY (S_SUPPKEY);

CREATE TABLE PARTSUPP ( PS_PARTKEY     INTEGER ,
                             PS_SUPPKEY     INTEGER ,
                             PS_AVAILQTY    INTEGER ,
                             PS_SUPPLYCOST  DECIMAL(15,2)  ,
                             PS_COMMENT     VARCHAR(199)  ) format 'orc' (compresstype 'lz4') DISTRIBUTED BY (PS_PARTKEY);

CREATE TABLE CUSTOMER ( C_CUSTKEY     INTEGER ,
                             C_NAME        VARCHAR(25) ,
                             C_ADDRESS     VARCHAR(40) ,
                             C_NATIONKEY   INTEGER ,
                             C_PHONE       CHAR(15) ,
                             C_ACCTBAL     DECIMAL(15,2)   ,
                             C_MKTSEGMENT  CHAR(10) ,
                             C_COMMENT     VARCHAR(117) ) format 'orc' (compresstype 'lz4') DISTRIBUTED BY (C_CUSTKEY);

CREATE TABLE ORDERS  ( O_ORDERKEY       INTEGER ,
                           O_CUSTKEY        INTEGER ,
                           O_ORDERSTATUS    CHAR(1) ,
                           O_TOTALPRICE     DECIMAL(15,2) ,
                           O_ORDERDATE      DATE ,
                           O_ORDERPRIORITY  CHAR(15) ,  -- R
                           O_CLERK          CHAR(15) ,  -- R
                           O_SHIPPRIORITY   INTEGER ,
                           O_COMMENT        VARCHAR(79) ) format 'orc' (compresstype 'lz4') DISTRIBUTED BY (O_ORDERKEY);

CREATE TABLE LINEITEM ( L_ORDERKEY    INTEGER ,
                             L_PARTKEY     INTEGER ,
                             L_SUPPKEY     INTEGER ,
                             L_LINENUMBER  INTEGER ,
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
                             L_COMMENT      VARCHAR(44) ) format 'orc' (compresstype 'lz4') DISTRIBUTED BY (L_ORDERKEY);

