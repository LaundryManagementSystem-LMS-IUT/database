CREATE OR REPLACE FUNCTION order_notification_trigger()
RETURNS TRIGGER AS $$
DECLARE
  CustomerName varchar(100);
BEGIN
  SELECT Username INTO CustomerName from CUSTOMER,USERS WHERE CUSTOMER.Email=NEW.CustomerEmail AND CUSTOMER.Email=USERS.Email;
  INSERT INTO NOTIFICATION(Email,Message) VALUES(NEW.ManagerEmail,'A New Order Has Been Added By '||CustomerName);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER order_insert_notification
AFTER INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION order_notification_trigger();