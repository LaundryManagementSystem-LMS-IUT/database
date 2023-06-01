CREATE OR REPLACE FUNCTION laundry_trigger()
RETURNS TRIGGER AS $$
DECLARE
  laundry_id TEXT;
BEGIN
  laundry_id := LPAD(CAST(nextval('laundry_sequence') AS TEXT), 10, '0') || '-' || TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS:MS');
  NEW.laundry_id := laundry_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER order_insert
BEFORE INSERT ON managers
FOR EACH ROW
EXECUTE FUNCTION laundry_trigger();