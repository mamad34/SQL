INSERT INTO before_launch (sku_id , title_backend , title_backend_note , pics_descriptive ,pics_descriptive_note)
VALUES ('e9dba69f-53b7-4814-802c-ad5a24bbdd9d','can i get a hoya ? ' , 'hip5' , 'sadol' , 'posy')
SELECT * FROM products

SELECT * FROM before_launch 
WHERE sku_id = 'e9dba69f-53b7-4814-802c-ad5a24bbdd9d'

SELECT p.id , bl.sku_id 
FROM products AS p
LEFT JOIN before_launch AS bl
ON p.id = bl.sku_id
WHERE bl.sku_id IS NULL


SELECT p.id , bl.sku_id 
FROM products AS p 
LEFT JOIN before_launch AS bl 
ON p.id = bl.sku_id 
WHERE bl.sku_id IS NOT NULL 