WITHOUT WITH

SELECT * FROM payment AS p 
WHERE amount > (SELECT AVG(amount) FROM payment)

--------------------------------------------------------

SELECT * FROM (	SELECT  customer_id,SUM(amount) as sum_bitch FROM payment
	GROUP BY customer_id
	ORDER BY customer_id) AS total_amount 
	
JOIN
	(SELECT CAST(AVG(sum_amount)AS INT) AS total_avg_per_all_stores FROM 
	(SELECT customer_id,SUM(amount) AS sum_amount FROM payment
	 GROUP BY customer_id) AS total_average	
 	) AS allof
ON  total_amount.sum_bitch > allof.total_avg_per_all_stores

------------------------------------------------------------
WITH WITH :)


WITH average_salary (avg_payment)  AS (SELECT AVG(amount) FROM payment)
SELECT * FROM payment AS p , average_salary AS ass
WHERE amount > ass.avg_payment

-------------------------------------------------------------

with sum_amount_per_customer
AS 
(SELECT customer_id , SUM(amount) AS sum_amount 
	FROM payment 
	GROUP BY customer_id	
) , 
 avg_amount_per_customer 
 AS
 (SELECT AVG(sum_amount) AS dick FROM sum_amount_per_customer )

SELECT * FROM 
sum_amount_per_customer
JOIN 
avg_amount_per_customer 
ON sum_amount_per_customer.sum_amount > avg_amount_per_customer.dick

-----------------------------------------------------------------
EBI TEST 
----------------------------------------------------------------->

SELECT p.id, p.sku ,p.store_id , 
os.order_date , os.amount , os.price,
array_length(os.list,1) as number_of_items
FROM products AS p
LEFT JOIN orders_summary AS os
ON os.sku = p.sku AND os.store_id = p.store_id AND DATE(order_date) = '12/01/2022'
WHERE p.store_id = '11ef8970-1d06-4c66-86de-cbded0181e28'


WITH product_dick AS (
  SELECT p.id, p.sku ,p.store_id 
  FROM products AS p
  WHERE p.store_id = '11ef8970-1d06-4c66-86de-cbded0181e28'
), 
product_pussy AS (
  SELECT os.id , os.sku , os.store_id , os.order_date , 
  os.amount , os.price,
  array_length(os.list,1) as number_of_items 
  FROM orders_summary AS os 
  WHERE os.store_id = '11ef8970-1d06-4c66-86de-cbded0181e28'	
  AND DATE(os.order_date) = '12/01/2022'
)
SELECT pd.id,pd.sku,pd.store_id , pp.order_date
FROM product_dick AS pd
LEFT JOIN product_pussy AS pp
ON pd.sku = pp.sku 
WHERE pp.order_date IS null

------------------------------------------------------------------------

WITH item_day_one AS(
	SELECT  sku , SUM(amount) AS item1 ,
	SUM(array_length(list,1)) AS orders1
	FROM orders_summary
	WHERE store_id = '11ef8970-1d06-4c66-86de-cbded0181e28'
	AND DATE(order_date) = '12/01/2022'
	GROUP BY sku
),
	item_day_two AS (
		SELECT  sku ,SUM(amount) AS item2 ,
		SUM(array_length(list,1)) AS orders2
		FROM orders_summary
		WHERE store_id = '11ef8970-1d06-4c66-86de-cbded0181e28'
		AND DATE(order_date) = '12/02/2022'
		GROUP BY sku
	)
	
 SELECT  p.id, o.sku , o.item1 , o.orders1 ,
            t.sku,t.item2 , t.orders2
            FROM products AS p
            LEFT JOIN item_day_one AS o
            ON p.sku = o.sku
            LEFT JOIN item_day_two AS t
            ON p.sku = t.sku 
			WHERE p.store_id = '11ef8970-1d06-4c66-86de-cbded0181e28'

-----------------------------------------------------------------------------

WITH FILTER METHOD 

WITH items_of_both_days AS (
	
	SELECT  sku , 
	SUM(amount) FILTER (WHERE DATE(order_date) ='12/01/2022' ) AS items1,
	SUM(array_length(list,1))  FILTER (WHERE DATE(order_date) ='12/01/2022' ) AS orders1,
	SUM(amount) FILTER (WHERE DATE(order_date) ='12/02/2022' ) AS items2,
	SUM(array_length(list,1))  FILTER (WHERE DATE(order_date) ='12/02/2022' ) AS orders2
	FROM orders_summary
	WHERE store_id = '11ef8970-1d06-4c66-86de-cbded0181e28'
	AND DATE(order_date) BETWEEN '12/01/2022' AND '12/02/2022'
	GROUP BY sku	
)

 SELECT p.id, p.sku , kir.items1 , kir.orders1 ,kir.items2 , kir.orders2 		
 FROM products AS p
 LEFT JOIN items_of_both_days AS kir
 ON  p.sku = kir.sku 
 WHERE p.store_id = '11ef8970-1d06-4c66-86de-cbded0181e28'

------------------------------------------------------------------------------
WITH CASE WHEN METHOD 

WITH items_of_both_days AS (
	
	SELECT  sku , 
	SUM(CASE WHEN DATE(order_date)='12/01/2022' THEN amount END) AS items1,
	SUM(CASE WHEN DATE(order_date)='12/01/2022' THEN array_length(list,1)END) AS orders1,
	SUM(CASE WHEN DATE(order_date)='12/02/2022' THEN amount END) AS items2,
	SUM(CASE WHEN DATE(order_date)='12/02/2022' THEN array_length(list,1)END) AS orders2
	FROM orders_summary
	WHERE store_id = '11ef8970-1d06-4c66-86de-cbded0181e28'
	AND DATE(order_date) BETWEEN '12/01/2022' AND '12/02/2022'
	GROUP BY sku	
)

 SELECT p.id, p.sku , kir.items1 , kir.orders1 ,kir.items2 , kir.orders2 		
 FROM products AS p
 LEFT JOIN items_of_both_days AS kir
 ON  p.sku = kir.sku 
 WHERE p.store_id = '11ef8970-1d06-4c66-86de-cbded0181e28'


-----------------------------------------------------------------------------
js sex with sql 

WITH items_of_both_days AS (
                      SELECT sku,
                          SUM(amount) FILTER (WHERE DATE(order_date) ='11/01/2022' ) AS items1,
                          SUM(array_length(list,1))  FILTER (WHERE DATE(order_date) ='11/01/2022' ) AS orders1,
                          SUM(price)  FILTER (WHERE DATE(order_date) ='11/01/2022' ) AS prices1 ,       SUM(amount) FILTER (WHERE DATE(order_date) ='11/02/2022' ) AS items2,
                          SUM(array_length(list,1))  FILTER (WHERE DATE(order_date) ='11/02/2022' ) AS orders2,
                          SUM(price)  FILTER (WHERE DATE(order_date) ='11/02/2022' ) AS prices2,      SUM(amount) FILTER (WHERE DATE(order_date) ='11/03/2022' ) AS items3,
                          SUM(array_length(list,1))  FILTER (WHERE DATE(order_date) ='11/03/2022' ) AS orders3,
                          SUM(price)  FILTER (WHERE DATE(order_date) ='11/03/2022' ) AS prices3,      SUM(amount) FILTER (WHERE DATE(order_date) ='11/04/2022' ) AS items4,
                          SUM(array_length(list,1))  FILTER (WHERE DATE(order_date) ='11/04/2022' ) AS orders4,
                          SUM(price)  FILTER (WHERE DATE(order_date) ='11/04/2022' ) AS prices4,      SUM(amount) FILTER (WHERE DATE(order_date) ='11/05/2022' ) AS items5,
                          SUM(array_length(list,1))  FILTER (WHERE DATE(order_date) ='11/05/2022' ) AS orders5,
                          SUM(price)  FILTER (WHERE DATE(order_date) ='11/05/2022' ) AS prices5,      SUM(amount) FILTER (WHERE DATE(order_date) ='11/06/2022' ) AS items6,
                          SUM(array_length(list,1))  FILTER (WHERE DATE(order_date) ='11/06/2022' ) AS orders6,
                          SUM(price)  FILTER (WHERE DATE(order_date) ='11/06/2022' ) AS prices6,      SUM(amount) FILTER (WHERE DATE(order_date) ='11/07/2022' ) AS items7,
                          SUM(array_length(list,1))  FILTER (WHERE DATE(order_date) ='11/07/2022' ) AS orders7,
                          SUM(price)  FILTER (WHERE DATE(order_date) ='11/07/2022' ) AS prices7,      SUM(amount) FILTER (WHERE DATE(order_date) ='11/08/2022' ) AS items8,
                          SUM(array_length(list,1))  FILTER (WHERE DATE(order_date) ='11/08/2022' ) AS orders8,
                          SUM(price)  FILTER (WHERE DATE(order_date) ='11/08/2022' ) AS prices8,      SUM(amount) FILTER (WHERE DATE(order_date) ='11/09/2022' ) AS items9,
                          SUM(array_length(list,1))  FILTER (WHERE DATE(order_date) ='11/09/2022' ) AS orders9,
                          SUM(price)  FILTER (WHERE DATE(order_date) ='11/09/2022' ) AS prices9
                  FROM orders_summary
                  WHERE store_id = '11ef8970-1d06-4c66-86de-cbded0181e28'
                  AND DATE(order_date) BETWEEN '11/01/2022' AND '11/10/2022'
                  GROUP BY sku
                )
                SELECT p.id, p.sku
                 , kir.items1 , kir.orders1 , '11/01/2022'AS date1 , kir.prices1 , kir.items2 , kir.orders2 , '11/02/2022'AS date2 , kir.prices2, kir.items3 , kir.orders3 , '11/03/2022'AS date3 , kir.prices3, kir.items4 , kir.orders4 , '11/04/2022'AS date4 , kir.prices4, kir.items5 , kir.orders5 , '11/05/2022'AS date5 , kir.prices5, kir.items6 , kir.orders6 , '11/06/2022'AS date6 , kir.prices6, kir.items7 , kir.orders7 , '11/07/2022'AS date7 , kir.prices7, kir.items8 , kir.orders8 , '11/08/2022'AS date8 , kir.prices8 , kir.items9 , kir.orders9 , '11/01/2022'AS date9, kir.prices9 FROM products AS p
                LEFT JOIN items_of_both_days AS kir
                ON  p.sku = kir.sku
                WHERE p.store_id = '11ef8970-1d06-4c66-86de-cbded0181e28';
