SELECT  DISTINCT ON (apbh.date_time) apbh.date_time , apbh.rank ,apbh.product_id 
FROM amazon_product_bsr_history AS apbh
WHERE product_id = 'bbced91d-3f76-4fdb-be32-e9d82373d9cd'
ORDER BY apbh.date_time , apbh.rank ASC
