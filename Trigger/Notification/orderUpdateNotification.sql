CREATE OR REPLACE FUNCTION order_update_notification()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO NOTIFICATIONS(Email,Message) VALUES(NEW.customer_email,'Order Status Has Been Updated to '||NEW.Status||' of Order ID: '||NEW.order_id);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER order_update_notification
BEFORE UPDATE OF Status ON ORDERS
FOR EACH ROW
EXECUTE FUNCTION order_update_notification();
