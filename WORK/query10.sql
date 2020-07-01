\timing
set new_executor=on;
SELECT
	c_custkey,
	c_name,
	sum(l_extendedprice) AS revenue,
	sum(1 - l_discount) AS average,
	c_acctbal,
	n_name,
	c_address,
	c_phone
FROM
	customer,
	orders,
	lineitem,
	nation
WHERE
	c_custkey = o_custkey
AND l_orderkey = o_orderkey
AND o_orderdate >= date '1993-10-01'
AND o_orderdate < date '1994-1-01'
AND l_returnflag = 'R'
AND c_nationkey = n_nationkey
GROUP BY
	c_custkey,
	c_name,
	c_acctbal,
	c_phone,
	n_name,
	c_address,
	c_comment
ORDER BY
	c_custkey DESC,
	c_name DESC,
	revenue DESC
LIMIT 20;


