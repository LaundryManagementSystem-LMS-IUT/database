CREATE OR REPLACE FUNCTION order_update_notification2()
RETURNS TRIGGER AS $$
DECLARE
  DeliveryEmail varchar(100);
  result_count INT;
BEGIN
  SELECT COUNT(*) INTO result_count FROM DELIVERY_INFORMATION WHERE OrderID=NEW.OrderID;
  IF(result_count>0) THEN
    SELECT DELIVERY_INFORMATION.DeliveryEmail INTO DeliveryEmail FROM DELIVERY_INFORMATION WHERE OrderID=NEW.OrderID;
  ELSE
    RETURN NEW;
  END IF;
  INSERT INTO NOTIFICATION(Email,Message) VALUES(DeliveryEmail,'Order Status Has Been Updated to '||NEW.Status||' of OrderID: '||NEW.OrderID);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER order_update_notification2
BEFORE UPDATE OF Status ON ORDERS
FOR EACH ROW
EXECUTE FUNCTION order_update_notification2();
