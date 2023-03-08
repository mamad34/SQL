WITH get_amount AS(SELECT sku , SUM(CASE WHEN DATE(order_date) = '01/01/2023' THEN amount END) AS amount
	FROM orders_summary AS os 
	WHERE os.store_id = $1
GROUP BY sku )
,
get_cogs AS (SELECT ach.sku_id , 
	SUM (CASE WHEN created_on = '01/01/2023' THEN ach.cogs END ) AS cogs
	FROM amazon_cogs_history AS ach 
LEFT JOIN products AS p 
ON p.id = ach.store_id 
WHERE p.store_id = $1			 
GROUP BY ach.sku_id)

SELECT p.id, p.sku , ga.amount , gc.cogs
FROM products AS p 
LEFT JOIN get_amount AS ga
ON ga.sku = p.sku 
LEFT JOIN get_cogs AS gc 
ON gc.sku_id = p.id
WHERE p.store_id = $1

 WITH get_amount AS (
              SELECT sku,
              SUM(CASE WHEN DATE(order_date) = '01/01/2023' THEN amount END) AS amount_1 ,
                      SUM(CASE WHEN DATE(order_date) = '01/02/2023' THEN amount END) AS amount_2 ,
                      SUM(CASE WHEN DATE(order_date) = '01/03/2023' THEN amount END) AS amount_3 ,
                      SUM(CASE WHEN DATE(order_date) = '01/04/2023' THEN amount END) AS amount_4 ,
                      SUM(CASE WHEN DATE(order_date) = '01/05/2023' THEN amount END) AS amount_5 ,
                      SUM(CASE WHEN DATE(order_date) = '01/06/2023' THEN amount END) AS amount_6 ,
                      SUM(CASE WHEN DATE(order_date) = '01/07/2023' THEN amount END) AS amount_7 ,
                      SUM(CASE WHEN DATE(order_date) = '01/08/2023' THEN amount END) AS amount_8 ,
                      SUM(CASE WHEN DATE(order_date) = '01/09/2023' THEN amount END) AS amount_9 ,
                      SUM(CASE WHEN DATE(order_date) = '01/10/2023' THEN amount END) AS amount_10   FROM orders_summary AS os
            WHERE os.store_id = '11ef8970-1d06-4c66-86de-cbded0181e28'
            GROUP BY sku
          ),
          get_cogs AS (
            SELECT ach.sku_id,
            SUM(CASE WHEN created_on = '01/01/2023' THEN ach.cogs END) AS cogs_1 ,
                    SUM(CASE WHEN created_on = '01/02/2023' THEN ach.cogs END) AS cogs_2 ,
                    SUM(CASE WHEN created_on = '01/03/2023' THEN ach.cogs END) AS cogs_3 ,
                    SUM(CASE WHEN created_on = '01/04/2023' THEN ach.cogs END) AS cogs_4 ,
                    SUM(CASE WHEN created_on = '01/05/2023' THEN ach.cogs END) AS cogs_5 ,
                    SUM(CASE WHEN created_on = '01/06/2023' THEN ach.cogs END) AS cogs_6 ,
                    SUM(CASE WHEN created_on = '01/07/2023' THEN ach.cogs END) AS cogs_7 ,
                    SUM(CASE WHEN created_on = '01/08/2023' THEN ach.cogs END) AS cogs_8 ,
                    SUM(CASE WHEN created_on = '01/09/2023' THEN ach.cogs END) AS cogs_9 ,
                    SUM(CASE WHEN created_on = '01/10/2023' THEN ach.cogs END) AS cogs_10   FROM amazon_cogs_history AS ach
            LEFT JOIN products AS p
            ON p.id = ach.sku_id
            WHERE p.store_id = '11ef8970-1d06-4c66-86de-cbded0181e28'
            GROUP BY ach.sku_id
          )
          SELECT p.id, p.sku,
          ga.amount_1, gc.cogs_1 ,ga.amount_2, gc.cogs_2 ,ga.amount_3, gc.cogs_3 ,ga.amount_4, gc.cogs_4 ,ga.amount_5, gc.cogs_5 ,ga.amount_6, gc.cogs_6 ,ga.amount_7, gc.cogs_7 ,ga.amount_8, gc.cogs_8 ,ga.amount_9, gc.cogs_9 ,ga.amount_10, gc.cogs_10
          FROM products AS p
          LEFT JOIN get_amount AS ga
          ON ga.sku = p.sku
          LEFT JOIN get_cogs AS gc
          ON gc.sku_id = p.id
          WHERE p.store_id = '11ef8970-1d06-4c66-86de-cbded0181e28' ORDER BY SKU ASC NULLS LAST, p.id OFFSET 0 ROWS FETCH FIRST 26 ROWS ONLY

////////////////////////////////////////////////////////////////////////////////////////////////////////////////


WITH all_sales AS (	
	SELECT 	os.sku,
			SUM(CASE WHEN DATE(order_date) BETWEEN '01/01/2022' AND '01/30/2022' THEN 
			os.amount END ) AS item,
			SUM(CASE WHEN DATE(order_date) BETWEEN '01/01/2022' AND '01/30/2022' THEN 
			ARRAY_LENGTH(os.list,1) END ) AS order
	FROM orders_summary AS os 
	GROUP BY sku
	)
	
SELECT p.id, ass.*
FROM  products AS p
LEFT JOIN all_sales AS ass 
ON ass.sku = p.sku
