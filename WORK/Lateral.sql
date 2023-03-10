SELECT  p.id, p.sku, p.big_image, p.small_image,
p.asin, nd.neglected_details, apd.neglected_status
FROM products as p 
LEFT JOIN LATERAL (
	SELECT JSON_AGG(
			JSON_BUILD_OBJECT(
				'id', andd.id,
				'date', TO_CHAR(andd.operation_date, 'mm/dd/yyyy'),
				'operationMode', andd.operation_mode,
				'note', andd.note
			) 
	) AS neglected_details
	FROM amazon_neglected_details AS andd
	WHERE andd.sku_id = p.id
	GROUP BY sku_id
) AS nd
ON true
LEFT JOIN amazon_product_details AS apd
ON apd.id = p.id 
WHERE p.store_id = $1
AND apd.neglected_status = dikc