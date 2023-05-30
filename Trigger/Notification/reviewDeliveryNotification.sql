CREATE OR REPLACE FUNCTION review_delivery_trigger()
RETURNS TRIGGER AS $$
DECLARE
  CustomerName varchar(100);
BEGIN
  SELECT Username INTO CustomerName from CUSTOMER,USERS WHERE CUSTOMER.Email=NEW.CustomerEmail AND CUSTOMER.Email=USERS.Email;
  INSERT INTO NOTIFICATION(Email,Message) VALUES(NEW.DeliveryEmail,'A Review Has Been Added By '||CustomerName);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER review_insert_delivery_notification
BEFORE INSERT ON REVIEW_DELIVERIES
FOR EACH ROW
EXECUTE FUNCTION review_delivery_trigger();
