CREATE OR REPLACE FUNCTION review_laundry_trigger()
RETURNS TRIGGER AS $$
DECLARE
  CustomerName varchar(100);
BEGIN
  SELECT Username INTO CustomerName from CUSTOMER,USERS WHERE CUSTOMER.Email=NEW.CustomerEmail AND CUSTOMER.Email=USERS.Email;
  INSERT INTO NOTIFICATION(Email,Message) VALUES(NEW.ManagerEmail,'A Review Has Been Added By '||CustomerName);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER review_laundry_insert_notification
BEFORE INSERT ON REVIEW_LAUNDRIES
FOR EACH ROW
EXECUTE FUNCTION review_laundry_trigger();
