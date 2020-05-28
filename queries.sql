-- using 1452887840 as a seed to the RNG
\qecho =================================================================
\qecho ========================= Query Number  1 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select l_returnflag, l_linestatus, sum(l_quantity)::bigint as sum_qty, sum(l_extendedprice)::bigint as sum_base_price, sum(l_extendedprice * (1 - l_discount))::bigint as sum_disc_price, sum(l_extendedprice * (1 - l_discount) * (1 + l_tax))::bigint as sum_charge, avg(l_quantity)::bigint as avg_qty, avg(l_extendedprice)::bigint as avg_price, avg(l_discount)::bigint as avg_disc, count(*) as count_order from lineitem where l_shipdate <= date '1998-09-02' group by l_returnflag, l_linestatus order by l_returnflag, l_linestatus;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery  1:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho 
\qecho =================================================================
\qecho ========================= Query Number  2 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select s_acctbal::bigint, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment from part, supplier, partsupp, nation, region where p_partkey = ps_partkey and s_suppkey = ps_suppkey and p_size = 15 and p_type like '%BRASS' and s_nationkey = n_nationkey and n_regionkey = r_regionkey and r_name = 'EUROPE' and ps_supplycost = ( select min(ps_supplycost) from partsupp, supplier, nation, region where p_partkey = ps_partkey and s_suppkey = ps_suppkey and s_nationkey = n_nationkey and n_regionkey = r_regionkey and r_name = 'EUROPE' ) order by s_acctbal desc, n_name, s_name, p_partkey limit 100;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery  2:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number  3 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select l_orderkey, sum(l_extendedprice * (1 - l_discount))::bigint as revenue, o_orderdate, o_shippriority from customer, orders, lineitem where c_mktsegment = 'BUILDING' and c_custkey = o_custkey and l_orderkey = o_orderkey and o_orderdate < date '1995-03-15' and l_shipdate > date '1995-03-15' group by l_orderkey, o_orderdate, o_shippriority order by revenue desc, o_orderdate, l_orderkey limit 10;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery  3:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number  4 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select o_orderpriority, count(*) as order_count from orders where o_orderdate >= date '1993-07-01' and o_orderdate < date '1993-10-01' and exists ( select * from lineitem where l_orderkey = o_orderkey and l_commitdate < l_receiptdate ) group by o_orderpriority order by o_orderpriority;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery  4:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number  5 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select n_name, sum(l_extendedprice * (1 - l_discount))::bigint as revenue from customer, orders, lineitem, supplier, nation, region where c_custkey = o_custkey and l_orderkey = o_orderkey and l_suppkey = s_suppkey and c_nationkey = s_nationkey and s_nationkey = n_nationkey and n_regionkey = r_regionkey and r_name = 'ASIA' and o_orderdate >= date '1994-01-01' and o_orderdate < date '1995-01-01' group by n_name order by revenue desc;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery  5:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number  6 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select sum(l_extendedprice * l_discount)::bigint as revenue from lineitem where l_shipdate >= date '1994-01-01' and l_shipdate < date '1995-01-01' and l_discount between 0.06 - 0.01 and 0.06 + 0.01 and l_quantity < 24;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery  6:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number  7 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select supp_nation, cust_nation, l_year, sum(volume)::bigint as revenue from ( select n1.n_name as supp_nation, n2.n_name as cust_nation, extract(year from l_shipdate) as l_year, l_extendedprice * (1 - l_discount) as volume from supplier, lineitem, orders, customer, nation n1, nation n2 where s_suppkey = l_suppkey and o_orderkey = l_orderkey and c_custkey = o_custkey and s_nationkey = n1.n_nationkey and c_nationkey = n2.n_nationkey and ( (n1.n_name = 'FRANCE' and n2.n_name = 'GERMANY') or (n1.n_name = 'GERMANY' and n2.n_name = 'FRANCE') ) and l_shipdate between date '1995-01-01' and date '1996-12-31' ) as shipping group by supp_nation, cust_nation, l_year order by supp_nation, cust_nation, l_year;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery  7:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number  8 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select o_year, (sum(case when nation = 'BRAZIL' then volume else 0 end) / sum(volume)) as mkt_share from ( select extract(year from o_orderdate) as o_year, l_extendedprice * (1 - l_discount) as volume, n2.n_name as nation from part, supplier, lineitem, orders, customer, nation n1, nation n2, region where p_partkey = l_partkey and s_suppkey = l_suppkey and l_orderkey = o_orderkey and o_custkey = c_custkey and c_nationkey = n1.n_nationkey and n1.n_regionkey = r_regionkey and r_name = 'AMERICA' and s_nationkey = n2.n_nationkey and o_orderdate between date '1995-01-01' and date '1996-12-31' and p_type = 'ECONOMY ANODIZED STEEL' ) as all_nations group by o_year order by o_year;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery  8:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number  9 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select nation, o_year, sum(amount)::bigint as sum_profit from ( select n_name as nation, extract(year from o_orderdate) as o_year, l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity as amount from part, supplier, lineitem, partsupp, orders, nation where s_suppkey = l_suppkey and ps_suppkey = l_suppkey and ps_partkey = l_partkey and p_partkey = l_partkey and o_orderkey = l_orderkey and s_nationkey = n_nationkey and p_name like '%green%' ) as profit group by nation, o_year order by nation, o_year desc;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery  9:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number 10 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select c_custkey, c_name, sum(l_extendedprice) as revenue, sum(1 - l_discount) as average, c_acctbal, n_name, c_address, c_phone from customer, orders, lineitem, nation where c_custkey = o_custkey and l_orderkey = o_orderkey and o_orderdate >= date'1993-10-01' and o_orderdate < date '1994-1-01' and l_returnflag = 'R' and c_nationkey = n_nationkey group by c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment order by c_custkey desc, c_name desc, revenue desc limit 20;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery 10:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number 11 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select ps_partkey, sum(ps_supplycost * ps_availqty)::bigint as value from partsupp, supplier, nation where ps_suppkey = s_suppkey and s_nationkey = n_nationkey and n_name = 'GERMANY' group by ps_partkey having sum(ps_supplycost * ps_availqty) > ( select sum(ps_supplycost * ps_availqty) * 0.0001000000 from partsupp, supplier, nation where ps_suppkey = s_suppkey and s_nationkey = n_nationkey and n_name = 'ALGERIA' ) order by value desc;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery 11:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number 12 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select l_shipmode, sum(case when o_orderpriority = '1-URGENT' or o_orderpriority = '2-HIGH' then 1 else 0 end) as high_line_count, sum(case when o_orderpriority <> '1-URGENT' and o_orderpriority <> '2-HIGH' then 1 else 0 end) as low_line_count from orders, lineitem where o_orderkey = l_orderkey and l_shipmode in ('MAIL', 'SHIP') and l_commitdate < l_receiptdate and l_shipdate < l_commitdate and l_receiptdate >= date '1994-01-01' and l_receiptdate < date '1995-01-01' group by l_shipmode order by l_shipmode;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery 12:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number 13 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select c_count, count(*) as custdist from ( select c_custkey, count(o_orderkey) from customer left outer join orders on c_custkey = o_custkey and o_comment not like '%special%requests%' group by c_custkey ) as c_orders (c_custkey, c_count) group by c_count order by custdist desc, c_count desc;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery 13:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number 14 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select (100.00 * sum(case when p_type like 'PROMO%' then l_extendedprice * (1 - l_discount) else 0 end) / sum(l_extendedprice * (1 - l_discount)))::bigint as promo_revenue from lineitem, part where l_partkey = p_partkey and l_shipdate >= date '1995-09-01' and l_shipdate < date '1995-10-01';

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery 14:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number 15 =======================
\qecho =================================================================

create view revenue0 (supplier_no, total_revenue) as
	select
		l_suppkey,
		sum(l_extendedprice * (1 - l_discount))
	from
		lineitem
	where
		l_shipdate >= date '1996-09-01'
		and l_shipdate < date '1996-09-01' + interval '3 month'
	group by
		l_suppkey;


-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select s_suppkey, s_name, s_address, s_phone, total_revenue::bigint from supplier, revenue0 where s_suppkey = supplier_no and total_revenue = ( select max(total_revenue) from revenue0 ) order by s_suppkey;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery 15:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

drop view revenue0;
\qecho =================================================================
\qecho ========================= Query Number 16 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select p_brand, p_type, p_size, count(distinct ps_suppkey) as supplier_cnt from partsupp, part where p_partkey = ps_partkey and p_brand <> 'Brand#45' and p_type not like 'MEDIUM BURNISHED%' and p_size in (49, 14, 23, 45, 19, 3, 36, 9) and ps_suppkey not in ( select s_suppkey from supplier where s_comment like '%Customer%Complaints%' ) group by p_brand, p_type, p_size order by supplier_cnt desc, p_brand, p_type, p_size;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery 16:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number 17 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select (sum(l_extendedprice) / 7.0)::bigint as avg_yearly from lineitem, part where p_partkey = l_partkey and p_brand = 'Brand#23' and p_container = 'MED BOX' and l_quantity < ( select 0.2 * avg(l_quantity) from lineitem where l_partkey = p_partkey );

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery 17:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number 18 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice::bigint, sum(l_quantity)::bigint from customer, orders, lineitem where o_orderkey in ( select l_orderkey from lineitem group by l_orderkey having sum(l_quantity) > 300 ) and c_custkey = o_custkey and o_orderkey = l_orderkey group by c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice order by o_totalprice desc, o_orderdate limit 100;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery 18:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number 19 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select sum(l_extendedprice* (1 - l_discount))::bigint as revenue from lineitem, part where ( p_partkey = l_partkey and p_brand = 'Brand#12' and p_container in ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG') and l_quantity >= 1 and l_quantity <= 1 + 10 and p_size between 1 and 5 and l_shipmode in ('AIR', 'AIR REG') and l_shipinstruct = 'DELIVER IN PERSON' ) or ( p_partkey = l_partkey and p_brand = 'Brand#23' and p_container in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK') and l_quantity >= 10 and l_quantity <= 10 + 10 and p_size between 1 and 10 and l_shipmode in ('AIR', 'AIR REG') and l_shipinstruct = 'DELIVER IN PERSON' ) or ( p_partkey = l_partkey and p_brand = 'Brand#34' and p_container in ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG') and l_quantity >= 20 and l_quantity <= 20 + 10 and p_size between 1 and 15 and l_shipmode in ('AIR', 'AIR REG') and l_shipinstruct = 'DELIVER IN PERSON' );

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery 19:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number 20 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select s_name, s_address from supplier, nation where s_suppkey in ( select ps_suppkey from partsupp where ps_partkey in ( select p_partkey from part where p_name like 'forest%' ) and ps_availqty > ( select 0.5 * sum(l_quantity) from lineitem where l_partkey = ps_partkey and l_suppkey = ps_suppkey and l_shipdate >= date '1994-01-01' and l_shipdate < date '1995-01-01' ) ) and s_nationkey = n_nationkey and n_name = 'CANADA' order by s_name;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery 20:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number 21 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select s_name, count(*) as numwait from supplier, lineitem l1, orders, nation where s_suppkey = l1.l_suppkey and o_orderkey = l1.l_orderkey and o_orderstatus = 'F' and l1.l_receiptdate > l1.l_commitdate and exists ( select * from lineitem l2 where l2.l_orderkey = l1.l_orderkey and l2.l_suppkey <> l1.l_suppkey ) and not exists ( select * from lineitem l3 where l3.l_orderkey = l1.l_orderkey and l3.l_suppkey <> l1.l_suppkey and l3.l_receiptdate > l3.l_commitdate ) and s_nationkey = n_nationkey and n_name = 'SAUDI ARABIA' group by s_name order by numwait desc, s_name limit 100;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery 21:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

\qecho =================================================================
\qecho ========================= Query Number 22 =======================
\qecho =================================================================

-- add by alex 2010-08-23
\set tpch_query_start `date +%s%N`

select cntrycode, count(*) as numcust, sum(c_acctbal)::bigint as totacctbal from ( select substring(c_phone from 1 for 2) as cntrycode, c_acctbal from customer where substring(c_phone from 1 for 2) in ('13', '31', '23', '29', '30', '18', '17') and c_acctbal > ( select avg(c_acctbal) from customer where c_acctbal > 0.00 and substring(c_phone from 1 for 2) in ('13', '31', '23', '29', '30', '18', '17') ) and not exists ( select * from orders where o_custkey = c_custkey ) ) as custsale group by cntrycode order by cntrycode;

-- add by alex 2010-08-23
\set tpch_query_end `date +%s%N`
select 'TPCHQuery 22:'||(:tpch_query_end - :tpch_query_start) / 1000000 || ' ms' as TPCH_Query_Run_Time;

