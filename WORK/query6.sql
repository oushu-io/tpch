\timing
SELECT
	sum(l_extendedprice * l_discount) :: BIGINT AS revenue
FROM
	lineitem
WHERE
	l_shipdate >= date '1994-01-01'
AND l_shipdate < date '1995-01-01'
AND l_discount BETWEEN 0.06 - 0.01
AND 0.06 + 0.01
AND l_quantity < 24;


