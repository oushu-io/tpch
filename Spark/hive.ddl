drop table NATION;
CREATE TABLE NATION  ( N_NATIONKEY  INTEGER NOT NULL,
                            N_NAME       string NOT NULL,
                            N_REGIONKEY  INTEGER NOT NULL,
                            N_COMMENT    string) STORED AS orc tblproperties ("orc.compress"="snappy");
drop table REGION;
CREATE TABLE REGION  ( R_REGIONKEY  INTEGER NOT NULL,
                            R_NAME       string NOT NULL,
                            R_COMMENT    string) STORED AS orc tblproperties ("orc.compress"="snappy");
drop table PART;
CREATE TABLE PART  ( P_PARTKEY     INTEGER NOT NULL,
                          P_NAME        string NOT NULL,
                          P_MFGR        string NOT NULL,
                          P_BRAND       string NOT NULL,
                          P_TYPE        string NOT NULL,
                          P_SIZE        INTEGER NOT NULL,
                          P_CONTAINER   string NOT NULL,
                          P_RETAILPRICE DECIMAL(15,2) NOT NULL,
                          P_COMMENT     string NOT NULL ) STORED AS orc tblproperties ("orc.compress"="snappy");
drop table SUPPLIER;
CREATE TABLE SUPPLIER ( S_SUPPKEY     INTEGER NOT NULL,
                             S_NAME        string NOT NULL,
                             S_ADDRESS     string NOT NULL,
                             S_NATIONKEY   INTEGER NOT NULL,
                             S_PHONE       string NOT NULL,
                             S_ACCTBAL     DECIMAL(15,2) NOT NULL,
                             S_COMMENT     string NOT NULL) STORED AS orc tblproperties ("orc.compress"="snappy");
drop table PARTSUPP;
CREATE TABLE PARTSUPP ( PS_PARTKEY     INTEGER NOT NULL,
                             PS_SUPPKEY     INTEGER NOT NULL,
                             PS_AVAILQTY    INTEGER NOT NULL,
                             PS_SUPPLYCOST  DECIMAL(15,2)  NOT NULL,
                             PS_COMMENT     string NOT NULL ) STORED AS orc tblproperties ("orc.compress"="snappy");
drop table CUSTOMER;
CREATE TABLE CUSTOMER ( C_CUSTKEY     INTEGER NOT NULL,
                             C_NAME        string NOT NULL,
                             C_ADDRESS     string NOT NULL,
                             C_NATIONKEY   INTEGER NOT NULL,
                             C_PHONE       string NOT NULL,
                             C_ACCTBAL     DECIMAL(15,2)   NOT NULL,
                             C_MKTSEGMENT  string NOT NULL,
                             C_COMMENT     string NOT NULL) STORED AS orc tblproperties ("orc.compress"="snappy");
drop table ORDERS;
CREATE TABLE ORDERS  ( O_ORDERKEY       INTEGER NOT NULL,
                           O_CUSTKEY        INTEGER NOT NULL,
                           O_ORDERSTATUS    string NOT NULL,
                           O_TOTALPRICE     DECIMAL(15,2) NOT NULL,
                           O_ORDERDATE      DATE NOT NULL,
                           O_ORDERPRIORITY  string NOT NULL,  -- R
                           O_CLERK          string NOT NULL,  -- R
                           O_SHIPPRIORITY   INTEGER NOT NULL,
                           O_COMMENT        string NOT NULL) STORED AS orc tblproperties ("orc.compress"="snappy");
drop table LINEITEM;
CREATE TABLE LINEITEM ( L_ORDERKEY    INTEGER NOT NULL,
                             L_PARTKEY     INTEGER NOT NULL,
                             L_SUPPKEY     INTEGER NOT NULL,
                             L_LINENUMBER  INTEGER NOT NULL,
                             L_QUANTITY    DECIMAL(15,2) NOT NULL,
                             L_EXTENDEDPRICE  DECIMAL(15,2) NOT NULL,
                             L_DISCOUNT    DECIMAL(15,2) NOT NULL,
                             L_TAX         DECIMAL(15,2) NOT NULL,
                             L_RETURNFLAG  string NOT NULL,
                             L_LINESTATUS  string NOT NULL,
                             L_SHIPDATE    DATE NOT NULL,
                             L_COMMITDATE  DATE NOT NULL,
                             L_RECEIPTDATE DATE NOT NULL,
                             L_SHIPINSTRUCT string NOT NULL,  -- R
                             L_SHIPMODE     string NOT NULL,  -- R
                             L_COMMENT      string NOT NULL) STORED AS orc tblproperties ("orc.compress"="snappy");
