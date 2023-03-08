--------------------STEP_ONE----------------------------
WITH get_rate_change AS (
SELECT id, JSON_AGG(
JSON_BUILD_OBJECT(
	'date', TO_CHAR(date_time, 'mm/dd/yyyy'),
	'oldRating', previous_rate,
	'newRating', rate
)) AS rate_change
FROM (
	SELECT p.id, aprr.date_time, aprr.rate,
	LAG(rate,1,rate) OVER(PARTITION BY p.id ORDER BY date_time ASC) AS previous_rate
	FROM amazon_product_rate_review AS aprr
	JOIN products AS p
	ON p.asin = aprr.asin
	RIGHT JOIN stores AS s
	ON s.id = p.store_id AND aprr.marketplace_id = s.marketplace_id
	WHERE s.id = '11ef8970-1d06-4c66-86de-cbded0181e28'
) AS temp
WHERE rate <> previous_rate
GROUP BY id
)

SELECT p.sku , grc.*
FROM products AS p
LEFT JOIN get_rate_change AS grc
--------------------STEP TWO --------------------------------

WITH get_rate_change AS (
                                    SELECT id,
                                    JSON_AGG(
                                      JSON_BUILD_OBJECT(
                                        'date', TO_CHAR(date_time, 'mm/dd/yyyy'),
                                        'oldRating', previous_rate,
                                        'newRating', rate
                                      )
                                    ) AS rate_change
                                    FROM (
                                      SELECT p.id, aprr.date_time, aprr.rate,
                                      LAG(aprr.rate,1,aprr.rate) OVER(PARTITION BY p.id ORDER BY aprr.date_time ASC) AS previous_rate
                                      FROM amazon_product_rate_review AS aprr
                                      JOIN products AS p
                                      ON p.asin = aprr.asin
                                      RIGHT JOIN stores AS s
                                      ON s.id = p.store_id AND aprr.marketplace_id = s.marketplace_id
                                      WHERE s.id = '11ef8970-1d06-4c66-86de-cbded0181e28'
                                    ) AS temp
                                    WHERE rate <> previous_rate
                                    GROUP BY id
                                  )
                                  SELECT p.id, p.sku, p.big_image, p.small_image, grc.rate_change
                                  FROM products AS p
                                  LEFT JOIN get_rate_change AS grc
                                  ON p.id = grc.id
                                  WHERE p.store_id = '11ef8970-1d06-4c66-86de-cbded0181e28';

--------------------STEP THREE -------------------------------

WITH get_rate_change AS (
                SELECT id,
                JSON_AGG(
                  JSON_BUILD_OBJECT(
                    'date', TO_CHAR(date_time, 'mm/dd/yyyy'),
                    'oldRating', previous_rate,
                    'newRating', rate
                  )
                ) AS rate_change
                FROM (
                  SELECT p.id, aprr.date_time, aprr.rate,
                  LAG(aprr.rate,1,aprr.rate) OVER(PARTITION BY p.id ORDER BY aprr.date_time ASC) AS previous_rate
                  FROM amazon_product_rate_review AS aprr
                  JOIN products AS p
                  ON p.asin = aprr.asin
                  RIGHT JOIN stores AS s
                  ON s.id = p.store_id AND aprr.marketplace_id = s.marketplace_id
                  WHERE s.id = $1
                ) AS temp
                WHERE rate <> previous_rate
                GROUP BY id
              ),
              latest_rate AS (
                SELECT DISTINCT ON(p.id) p.id, aprr.rate, aprr.global_rating
                FROM amazon_product_rate_review AS aprr
                JOIN products AS p
                ON p.asin = aprr.asin
                RIGHT JOIN stores AS s
                ON s.id = p.store_id AND aprr.marketplace_id = s.marketplace_id
                ORDER BY p.id, aprr.date_time DESC
                LIMIT 1
              )
              SELECT p.id, p.sku ,p.big_image, p.small_image, grc.rate_change,
              lr.rate AS latest_rate, lr.global_rating AS latest_global_rating
              FROM products AS p
              LEFT JOIN get_rate_change AS grc
              ON p.id = grc.id
              LEFT JOIN latest_rate AS lr
              ON p.id = lr.id
              WHERE p.store_id = $1


---------------------STEP FOUR -------------------------------------

WITH get_rate_change AS (
                SELECT id,
                JSON_AGG(
                  JSON_BUILD_OBJECT(
                    'date', TO_CHAR(date_time, 'mm/dd/yyyy'),
                    'oldRating', previous_rate,
                    'newRating', rate
                  )
                ) AS rate_change
                FROM (
                  SELECT p.id, aprr.date_time, aprr.rate,
                  LAG(aprr.rate,1,aprr.rate) OVER(PARTITION BY p.id ORDER BY aprr.date_time ASC) AS previous_rate
                  FROM amazon_product_rate_review AS aprr
                  JOIN products AS p
                  ON p.asin = aprr.asin
                  RIGHT JOIN stores AS s
                  ON s.id = p.store_id AND aprr.marketplace_id = s.marketplace_id
                  WHERE s.id = $1
                ) AS temp
                WHERE rate <> previous_rate
                GROUP BY id
              ),
              latest_rate AS (
                SELECT DISTINCT ON(p.id) p.id, aprr.rate, aprr.global_rating
                FROM amazon_product_rate_review AS aprr
                JOIN products AS p
                ON p.asin = aprr.asin
                RIGHT JOIN stores AS s
                ON s.id = p.store_id AND aprr.marketplace_id = s.marketplace_id
                ORDER BY p.id, aprr.date_time DESC
                LIMIT 1
              )
              SELECT p.id, p.sku ,p.big_image, p.small_image, grc.rate_change,
              lr.rate AS latest_rate, lr.global_rating AS latest_global_rating
              FROM products AS p
              LEFT JOIN get_rate_change AS grc
              ON p.id = grc.id
              LEFT JOIN latest_rate AS lr
              ON p.id = lr.id
              WHERE p.store_id = $1




/////////////////////////////////////////////////////////////////

NEW CODE ABOUT JSON IN SQL 
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
)
SELECT p.id, p.sku, iao.in_and_outs
FROM products AS p
LEFT JOIN in_and_outs AS iao
ON p.id = iao.sku_id
WHERE store_id = $1