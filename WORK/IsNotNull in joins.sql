SELECT code 
FROM free_gift_code As fgc
LEFT JOIN free_gift_user AS fgu
ON fgu.code_id = fgc.id
WHERE fgu.code_id IS NULL
		