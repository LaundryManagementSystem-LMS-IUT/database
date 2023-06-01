CREATE OR REPLACE FUNCTION review_laundry_trigger()
RETURNS TRIGGER AS $$
DECLARE
  CustomerName varchar(100);
BEGIN
  SELECT Username INTO CustomerName from CUSTOMERS,USERS WHERE CUSTOMERS.Email=NEW.customer_email AND CUSTOMERS.Email=USERS.Email;
  INSERT INTO NOTIFICATIONS(Email,Message) VALUES(NEW.manager_email,'A Review Has Been Added By '||CustomerName);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER review_laundry_insert_notification
BEFORE INSERT ON REVIEW_LAUNDRIES
FOR EACH ROW
EXECUTE FUNCTION review_laundry_trigger();
