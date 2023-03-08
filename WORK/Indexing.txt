EXPLAIN SELECT *
FROM address
WHERE phone = '223664661973';

//

CREATE INDEX idx_address_phone 
ON address(phone);

//

EXPLAIN SELECT *
FROM address
WHERE phone = '223664661973';


https://www.postgresqltutorial.com/postgresql-indexes/postgresql-drop-index/

