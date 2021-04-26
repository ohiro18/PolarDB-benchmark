CREATE TABLE `CUSTOMER` (
 `C_CUSTKEY` int NOT NULL,
 `C_NAME` varchar NOT NULL,
 `C_ADDRESS` varchar NOT NULL,
 `C_NATIONKEY` int NOT NULL,
 `C_PHONE` varchar NOT NULL,
 `C_ACCTBAL` decimal(12, 2) NOT NULL,
 `C_MKTSEGMENT` varchar NOT NULL,
 `C_COMMENT` varchar NOT NULL,
 primary key (c_custkey)
) 
DISTRIBUTE BY HASH(`c_custkey`) 
INDEX_ALL='Y';

CREATE TABLE `LINEITEM` (
 `L_ORDERKEY` bigint NOT NULL,
 `L_PARTKEY` int NOT NULL,
 `L_SUPPKEY` int NOT NULL,
 `L_LINENUMBER` bigint NOT NULL,
 `L_QUANTITY` decimal(12, 2) NOT NULL,
 `L_EXTENDEDPRICE` decimal(12, 2) NOT NULL,
 `L_DISCOUNT` decimal(12, 2) NOT NULL,
 `L_TAX` decimal(12, 2) NOT NULL,
 `L_RETURNFLAG` varchar NOT NULL,
 `L_LINESTATUS` varchar NOT NULL,
 `L_SHIPDATE` date NOT NULL,
 `L_COMMITDATE` date NOT NULL,
 `L_RECEIPTDATE` date NOT NULL,
 `L_SHIPINSTRUCT` varchar NOT NULL,
 `L_SHIPMODE` varchar NOT NULL,
 `L_COMMENT` varchar NOT NULL,
 primary key (l_orderkey,l_linenumber,l_shipdate)
) 
DISTRIBUTE BY HASH(`l_orderkey`) 
PARTITION BY VALUE(`date_format(l_shipdate, '%Y%m')`) 
LIFECYCLE 90 
INDEX_ALL='Y';

CREATE TABLE `NATION` (
 `N_NATIONKEY` int NOT NULL,
 `N_NAME` varchar NOT NULL,
 `N_REGIONKEY` int NOT NULL,
 `N_COMMENT` varchar,
 primary key (n_nationkey)
) DISTRIBUTE BY BROADCAST INDEX_ALL='Y';


CREATE TABLE `ORDERS` (
 `O_ORDERKEY` bigint NOT NULL,
 `O_CUSTKEY` int NOT NULL,
 `O_ORDERSTATUS` varchar NOT NULL,
 `O_TOTALPRICE` decimal(12, 2) NOT NULL,
 `O_ORDERDATE` date NOT NULL,
 `O_ORDERPRIORITY` varchar NOT NULL,
 `O_CLERK` varchar NOT NULL,
 `O_SHIPPRIORITY` int NOT NULL,
 `O_COMMENT` varchar NOT NULL,
 primary key (o_orderkey,o_orderdate)
) 
DISTRIBUTE BY HASH(`o_orderkey`) 
PARTITION BY VALUE(`date_format(O_ORDERDATE, '%Y%m')`) 
LIFECYCLE 90 
INDEX_ALL='Y';


CREATE TABLE `PART` (
 `P_PARTKEY` int NOT NULL,
 `P_NAME` varchar NOT NULL,
 `P_MFGR` varchar NOT NULL,
 `P_BRAND` varchar NOT NULL,
 `P_TYPE` varchar NOT NULL,
 `P_SIZE` int NOT NULL,
 `P_CONTAINER` varchar NOT NULL,
 `P_RETAILPRICE` decimal(12, 2) NOT NULL,
 `P_COMMENT` varchar NOT NULL,
 primary key (p_partkey)
) 
DISTRIBUTE BY HASH(`p_partkey`) 
INDEX_ALL='Y';

CREATE TABLE `PARTSUPP` (
 `PS_PARTKEY` int NOT NULL,
 `PS_SUPPKEY` int NOT NULL,
 `PS_AVAILQTY` int NOT NULL,
 `PS_SUPPLYCOST` decimal(12, 2) NOT NULL,
 `PS_COMMENT` varchar NOT NULL,
 primary key (ps_partkey,ps_suppkey)
) 
DISTRIBUTE BY HASH(`ps_partkey`) 
INDEX_ALL='Y';

CREATE TABLE `REGION` (
 `R_REGIONKEY` int NOT NULL,
 `R_NAME` varchar NOT NULL,
 `R_COMMENT` varchar,
 primary key (r_regionkey)
) 
DISTRIBUTE BY BROADCAST 
INDEX_ALL='Y';

CREATE TABLE `SUPPLIER` (
 `S_SUPPKEY` int NOT NULL,
 `S_NAME` varchar NOT NULL,
 `S_ADDRESS` varchar NOT NULL,
 `S_NATIONKEY` int NOT NULL,
 `S_PHONE` varchar NOT NULL,
 `S_ACCTBAL` decimal(12, 2) NOT NULL,
 `S_COMMENT` varchar NOT NULL,
 primary key (s_suppkey)
) 
DISTRIBUTE BY HASH(`s_suppkey`) 
INDEX_ALL='Y';