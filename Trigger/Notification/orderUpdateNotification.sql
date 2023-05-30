CREATE OR REPLACE FUNCTION order_update_notification()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO NOTIFICATION(Email,Message) VALUES(NEW.CustomerEmail,'Order Status Has Been Updated to '||NEW.Status||' of OrderID: '||NEW.OrderID);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER order_update_notification
BEFORE UPDATE OF Status ON ORDERS
FOR EACH ROW
EXECUTE FUNCTION order_update_notification();
