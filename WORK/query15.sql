\timing
CREATE VIEW revenue0 (supplier_no, total_revenue) AS SELECT
	l_suppkey,
	sum(
		l_extendedprice * (1 - l_discount)
	)
FROM
	lineitem
WHERE
	l_shipdate >= date '1996-09-01'
AND l_shipdate < date '1996-09-01' + INTERVAL '3 month'
GROUP BY
	l_suppkey;

SELECT
	s_suppkey,
	s_name,
	s_address,
	s_phone,
	total_revenue :: BIGINT
FROM
	supplier,
	revenue0
WHERE
	s_suppkey = supplier_no
AND total_revenue = (
	SELECT
		max(total_revenue)
	FROM
		revenue0
)
ORDER BY
	s_suppkey;


drop view revenue0;
