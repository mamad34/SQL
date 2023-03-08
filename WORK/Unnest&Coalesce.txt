SELECT p.id, p.sku, wiao.date_time, wiao.adjustment,
	(SELECT SUM(t) 
	 FROM UNNEST(wiao.inbound_outbound) AS t ) AS total
FROM products AS p 
LEFT JOIN warehouse_in_and_out AS wiao
ON p.id = wiao.sku_id
////////////////////////////////////////////////////////
WITH in_and_outs AS (
	SELECT sku_id,
	JSON_AGG(
		JSON_BUILD_OBJECT(
			'date', TO_CHAR(date_time, 'mm/dd/yyyy'),
			'inboundsOutbounds', inbound_outbound,
			'adjustments', adjustment
		)
	) AS in_and_outs
	FROM warehouse_in_and_out
	WHERE date_time BETWEEN '01/01/2023' AND '02/01/2023'
	GROUP BY sku_id
),
total AS (
SELECT sku_id, SUM(COALESCE(inbound_outbound,0)) + SUM(COALESCE(adjustment,0)) AS total
FROM (
	SELECT sku_id, UNNEST(inbound_outbound) AS inbound_outbound,
	UNNEST(adjustment) AS adjustment
	FROM warehouse_in_and_out
	WHERE date_time BETWEEN '01/01/2023' AND '02/01/2023'
) AS t
GROUP BY sku_id)
SELECT p.id, p.sku, iao.in_and_outs, t.total
FROM products AS p
LEFT JOIN in_and_outs AS iao
ON p.id = iao.sku_id
LEFT JOIN total AS t 
ON t.sku_id = p.id
WHERE store_id = $1


