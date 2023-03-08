SELECT EXTRACT(MONTH FROM ('01/01/2022'::DATE - INTERVAL '12 months'))

////////////////


SELECT DISTINCT ON(p.sku) p.sku, p.id, adp.profit_date, adp.breakeven_price, adp.unit_sold, adp.sales_price,TO_DATE(CONCAT('01/',EXTRACT(MONTH FROM (adp.profit_date - INTERVAL '12 months')) + 1,'/',EXTRACT(YEAR FROM (adp.profit_date - INTERVAL '12 months'))),'DD/MM/YYYY') AS one_year_profit_date,
TO_DATE(CONCAT('01/',EXTRACT(MONTH FROM (adp.profit_date)) + 1,'/',EXTRACT(YEAR FROM (adp.profit_date))),'DD/MM/YYYY') AS one_month_profit_date
FROM amazon_daily_profit AS adp
LEFT JOIN products AS p
ON adp.sku_id = p.id
WHERE p.store_id = '11ef8970-1d06-4c66-86de-cbded0181e28'
ORDER BY p.sku, adp.profit_date DESC

