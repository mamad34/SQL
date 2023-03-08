-- STEP ONE ---------------------------------------
SELECT *
FROM (
	SELECT *, row_number() OVER(PARTITION BY sku_id ORDER BY change_date DESC) AS rn
	FROM fba_fee_change_log AS ffcl
	ORDER BY sku_id
) AS temp
WHERE rn <= 10 

-- STEP TWO ---------------------------------------

SELECT * ,
CASE
    	WHEN rn = 1 THEN 'change 1' 
    	WHEN rn = 2 THEN 'change 2'
	WHEN rn = 3 THEN 'change 3'
	WHEN rn = 4 THEN 'change 4'
	WHEN rn = 5 THEN 'change 5'
	WHEN rn = 6 THEN 'change 6'
	WHEN rn = 7 THEN 'change 7'
	WHEN rn = 8 THEN 'change 8'
	WHEN rn = 9 THEN 'change 9'
	WHEN rn = 10 THEN 'change 10'
END AS changes

FROM (
	SELECT *, row_number() OVER(PARTITION BY sku_id ORDER BY change_date DESC) AS rn
	FROM fba_fee_change_log AS ffcl
	ORDER BY sku_id
) AS temp

WHERE rn <= 10

-- STEP THREE ---------------------------------------

SELECT * ,
CASE
    WHEN rn = 1 THEN 'change 1' 
END AS change1,
CASE
    WHEN rn = 2 THEN 'change 2' 
END AS change2,
CASE
    WHEN rn = 3 THEN 'change 3' 
END AS change3,
CASE
    WHEN rn = 4 THEN 'change 4' 
END AS change4,
CASE
    WHEN rn = 5 THEN 'change 5' 
END AS change5,
CASE
    WHEN rn = 6 THEN 'change 6' 
END AS change6,
CASE
    WHEN rn = 7 THEN 'change 7' 
END AS change7,
CASE
    WHEN rn = 8 THEN 'change 8' 
END AS change8,
CASE
    WHEN rn = 9 THEN 'change 9' 
END AS change9,
CASE
    WHEN rn = 10 THEN 'change 10' 
END AS change10

FROM (
	SELECT *, row_number() OVER(PARTITION BY sku_id ORDER BY change_date DESC) AS rn
	FROM fba_fee_change_log AS ffcl
	ORDER BY sku_id
) AS temp

WHERE rn <= 10

-- STEP FOUR ---------------------------------------


SELECT sku_id ,
MAX(CASE
    WHEN rn = 1 THEN 'cahnge 1'
END) AS change1,
MAX(CASE
    WHEN rn = 2 THEN 'change 2'
END) AS change2,
MAX(CASE
    WHEN rn = 3 THEN 'change 3'
END) AS change3
FROM (
	SELECT *, row_number() OVER(PARTITION BY sku_id ORDER BY change_date DESC) AS rn
	FROM fba_fee_change_log AS ffcl
	ORDER BY sku_id
) AS temp

WHERE rn <= 10
GROUP BY sku_id

-- STEP FIVE ---------------------------------------

SELECT sku_id ,
MAX(CASE
    WHEN rn = 1 THEN old_fba_fee
END) AS old_fba_change_1,
MAX(CASE
    WHEN rn = 1 THEN new_fba_fee
END) AS new_fba_change_1,
MAX(CASE
    WHEN rn = 1 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_1
FROM (
	SELECT *, row_number() OVER(PARTITION BY sku_id ORDER BY change_date DESC) AS rn
	FROM fba_fee_change_log AS ffcl
	ORDER BY sku_id
) AS temp

WHERE rn <= 10
GROUP BY sku_id

-- FINAL STEP -------------------------------------

SELECT sku_id ,
MAX(CASE
    WHEN rn = 1 THEN old_fba_fee
END) AS old_fba_change_1,
MAX(CASE
    WHEN rn = 1 THEN new_fba_fee
END) AS new_fba_change_1,
MAX(CASE
    WHEN rn = 1 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_1
,

MAX(CASE
    WHEN rn = 2 THEN old_fba_fee
END) AS old_fba_change_2,
MAX(CASE
    WHEN rn = 2 THEN new_fba_fee
END) AS new_fba_change_2,
MAX(CASE
    WHEN rn = 2 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_2
,

MAX(CASE
    WHEN rn = 3 THEN old_fba_fee
END) AS old_fba_change_3,
MAX(CASE
    WHEN rn = 3 THEN new_fba_fee
END) AS new_fba_change_3,
MAX(CASE
    WHEN rn = 3 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_3
,

MAX(CASE
    WHEN rn = 4 THEN old_fba_fee
END) AS old_fba_change_4,
MAX(CASE
    WHEN rn = 4 THEN new_fba_fee
END) AS new_fba_change_4,
MAX(CASE
    WHEN rn = 4 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_4
,
MAX(CASE
    WHEN rn = 5 THEN old_fba_fee
END) AS old_fba_change_5,
MAX(CASE
    WHEN rn = 5 THEN new_fba_fee
END) AS new_fba_change_5,
MAX(CASE
    WHEN rn = 5 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_5
,
MAX(CASE
    WHEN rn = 6 THEN old_fba_fee
END) AS old_fba_change_6,
MAX(CASE
    WHEN rn = 6 THEN new_fba_fee
END) AS new_fba_change_6,
MAX(CASE
    WHEN rn = 6 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_6
,
MAX(CASE
    WHEN rn = 7 THEN old_fba_fee
END) AS old_fba_change_7,
MAX(CASE
    WHEN rn = 7 THEN new_fba_fee
END) AS new_fba_change_7,
MAX(CASE
    WHEN rn = 7 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_7
,
MAX(CASE
    WHEN rn = 8 THEN old_fba_fee
END) AS old_fba_change_8,
MAX(CASE
    WHEN rn = 8 THEN new_fba_fee
END) AS new_fba_change_8,
MAX(CASE
    WHEN rn = 8 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_8
,
MAX(CASE
    WHEN rn = 9 THEN old_fba_fee
END) AS old_fba_change_9,
MAX(CASE
    WHEN rn = 9 THEN new_fba_fee
END) AS new_fba_change_9,
MAX(CASE
    WHEN rn = 9 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_9
,
MAX(CASE
    WHEN rn = 10 THEN old_fba_fee
END) AS old_fba_change_10,
MAX(CASE
    WHEN rn = 10 THEN new_fba_fee
END) AS new_fba_change_10,
MAX(CASE
    WHEN rn = 10 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_10

FROM (
	SELECT *, row_number() OVER(PARTITION BY sku_id ORDER BY change_date DESC) AS rn
	FROM fba_fee_change_log AS ffcl
	ORDER BY sku_id
) AS temp

WHERE rn <= 10
GROUP BY sku_id

********************************************END QUERY *********************************
WITH conflicts AS (
SELECT sku_id ,
MAX(CASE
    WHEN rn = 1 THEN old_fba_fee
END) AS old_fba_change_1,
MAX(CASE
    WHEN rn = 1 THEN new_fba_fee
END) AS new_fba_change_1,
MAX(CASE
    WHEN rn = 1 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_1
,

MAX(CASE
    WHEN rn = 2 THEN old_fba_fee
END) AS old_fba_change_2,
MAX(CASE
    WHEN rn = 2 THEN new_fba_fee
END) AS new_fba_change_2,
MAX(CASE
    WHEN rn = 2 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_2
,

MAX(CASE
    WHEN rn = 3 THEN old_fba_fee
END) AS old_fba_change_3,
MAX(CASE
    WHEN rn = 3 THEN new_fba_fee
END) AS new_fba_change_3,
MAX(CASE
    WHEN rn = 3 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_3
,

MAX(CASE
    WHEN rn = 4 THEN old_fba_fee
END) AS old_fba_change_4,
MAX(CASE
    WHEN rn = 4 THEN new_fba_fee
END) AS new_fba_change_4,
MAX(CASE
    WHEN rn = 4 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_4
,
MAX(CASE
    WHEN rn = 5 THEN old_fba_fee
END) AS old_fba_change_5,
MAX(CASE
    WHEN rn = 5 THEN new_fba_fee
END) AS new_fba_change_5,
MAX(CASE
    WHEN rn = 5 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_5
,
MAX(CASE
    WHEN rn = 6 THEN old_fba_fee
END) AS old_fba_change_6,
MAX(CASE
    WHEN rn = 6 THEN new_fba_fee
END) AS new_fba_change_6,
MAX(CASE
    WHEN rn = 6 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_6
,
MAX(CASE
    WHEN rn = 7 THEN old_fba_fee
END) AS old_fba_change_7,
MAX(CASE
    WHEN rn = 7 THEN new_fba_fee
END) AS new_fba_change_7,
MAX(CASE
    WHEN rn = 7 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_7
,
MAX(CASE
    WHEN rn = 8 THEN old_fba_fee
END) AS old_fba_change_8,
MAX(CASE
    WHEN rn = 8 THEN new_fba_fee
END) AS new_fba_change_8,
MAX(CASE
    WHEN rn = 8 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_8
,
MAX(CASE
    WHEN rn = 9 THEN old_fba_fee
END) AS old_fba_change_9,
MAX(CASE
    WHEN rn = 9 THEN new_fba_fee
END) AS new_fba_change_9,
MAX(CASE
    WHEN rn = 9 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_9
,
MAX(CASE
    WHEN rn = 10 THEN old_fba_fee
END) AS old_fba_change_10,
MAX(CASE
    WHEN rn = 10 THEN new_fba_fee
END) AS new_fba_change_10,
MAX(CASE
    WHEN rn = 10 THEN TO_CHAR(change_date,'mm/dd/yyyy')
END) AS date_change_10
FROM (
	SELECT *, row_number() OVER(PARTITION BY sku_id ORDER BY change_date DESC) AS rn
	FROM fba_fee_change_log AS ffcl
	ORDER BY sku_id
) AS temp
WHERE rn <= 10
GROUP BY sku_id
)
SELECT ffc.case_date,c.*, p.sku , p.big_image , p.small_image , p.unit_weight, p.unit_length, p.unit_width, p.unit_height
FROM conflicts AS c
LEFT JOIN products AS p
ON p.id = c.sku_id
LEFT JOIN fba_fee_conflicts AS ffc 
ON p.id = ffc.sku_id



















