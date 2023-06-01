CREATE OR REPLACE FUNCTION order_notification_trigger()
RETURNS TRIGGER AS $$
DECLARE
  CustomerName varchar(100);
BEGIN
  SELECT Username INTO CustomerName from CUSTOMERS,USERS WHERE CUSTOMERS.Email=NEW.customer_email AND CUSTOMERS.Email=USERS.Email;
  INSERT INTO NOTIFICATIONS(Email,Message) VALUES(NEW.manager_email,'A New Order Has Been Added By '||CustomerName);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER order_insert_notification
AFTER INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION order_notification_trigger();