\timing
SELECT
	ps_partkey,
	sum(ps_supplycost * ps_availqty) :: BIGINT AS
VALUE

FROM
	partsupp,
	supplier,
	nation
WHERE
	ps_suppkey = s_suppkey
AND s_nationkey = n_nationkey
AND n_name = 'GERMANY'
GROUP BY
	ps_partkey
HAVING
	sum(ps_supplycost * ps_availqty) > (
		SELECT
			sum(ps_supplycost * ps_availqty) * (0.0001 /:fct)
		FROM
			partsupp,
			supplier,
			nation
		WHERE
			ps_suppkey = s_suppkey
		AND s_nationkey = n_nationkey
		AND n_name = 'ALGERIA'
	)
ORDER BY

VALUE
	DESC;


