CREATE OR REPLACE FUNCTION order_trigger()
RETURNS TRIGGER AS $$
DECLARE
  orderid TEXT;
BEGIN
  orderid := NEW.ManagerEmail||'-'||NEW.CustomerEmail||'-'||LPAD(CAST(nextval('order_sequence') AS TEXT), 5, '0') || '-' || TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS');
  NEW.orderid := orderid;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER order_insert
BEFORE INSERT ON ORDERS
FOR EACH ROW
EXECUTE FUNCTION order_trigger();