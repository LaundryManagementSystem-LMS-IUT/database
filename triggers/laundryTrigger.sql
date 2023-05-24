CREATE OR REPLACE FUNCTION laundry_insert_trigger()
RETURNS TRIGGER AS $$
DECLARE
  laundryID TEXT;
BEGIN
  laundryID := LPAD(CAST(nextval('laundry_sequence') AS TEXT), 10, '0') || '-' || to_char(current_date, 'YYYYMMDD') || '-' || NEW.laundryName;
  NEW.laundryID := laundryID;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER laundry_insert
BEFORE INSERT ON laundry
FOR EACH ROW
EXECUTE FUNCTION laundry_insert_trigger();