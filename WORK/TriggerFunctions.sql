CREATE OR REPLACE FUNCTION check_store_marketplace() RETURNS TRIGGER AS
$BODY$
BEGIN
IF NEW.main_store_id IS NOT NULL
THEN
IF EXISTS(
    SELECT id
    FROM stores
    WHERE id = NEW.main_store_id
    AND marketplace_id = NEW.marketplace_id
    UNION
    SELECT id
    FROM stores
    WHERE main_store_id = NEW.main_store_id
    AND marketplace_id = NEW.marketplace_id
)
THEN RAISE EXCEPTION 'Store with % marketplace already exists', NEW.marketplace_id;
END IF;
END IF;
RETURN NEW;
END;
$BODY$
language plpgsql;

CREATE TRIGGER check_marketplace_on_insert
BEFORE INSERT ON stores
FOR EACH ROW
EXECUTE FUNCTION check_store_marketplace();