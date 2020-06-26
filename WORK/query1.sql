\timing
SELECT
	l_returnflag,
	l_linestatus,
	sum(l_quantity) :: BIGINT AS sum_qty,
	sum(l_extendedprice) :: BIGINT AS sum_base_price,
	sum(
		l_extendedprice * (1 - l_discount)
	) :: BIGINT AS sum_disc_price,
	sum(
		l_extendedprice * (1 - l_discount) * (1 + l_tax)
	) :: BIGINT AS sum_charge,
	avg(l_quantity) :: BIGINT AS avg_qty,
	avg(l_extendedprice) :: BIGINT AS avg_price,
	avg(l_discount) :: BIGINT AS avg_disc,
	count(*) AS count_order
FROM
	lineitem
WHERE
	l_shipdate <= date '1998-09-02'
GROUP BY
	l_returnflag,
	l_linestatus
ORDER BY
	l_returnflag,
	l_linestatus;

