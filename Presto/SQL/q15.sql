/*+big_query=true*/ WITH revenue0 AS (
  SELECT 
    l.l_suppkey as supplier_no,
    sum(l.l_extendedprice*(1-l.l_discount)) as total_revenue
  FROM 
    lineitem l
  WHERE 
    l.l_shipdate >= DATE '1996-01-01'
    AND l.l_shipdate < DATE '1996-01-01' + INTERVAL '3' MONTH
  GROUP BY 
    l.l_suppkey
)
select s_suppkey, s_name, s_address, s_phone, total_revenue from supplier, revenue0 where s_suppkey = supplier_no and total_revenue = ( select max(total_revenue) from revenue0 ) order by s_suppkey;