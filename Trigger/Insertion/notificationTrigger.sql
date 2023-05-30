CREATE OR REPLACE FUNCTION notification_trigger()
RETURNS TRIGGER AS $$
DECLARE
  notification_id TEXT;
BEGIN
  notification_id := LPAD(CAST(nextval('notification_sequence') AS TEXT), 10, '0') || '-' || TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS')||'-'||NEW.Email;
  NEW.notification_id := notification_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER notification_insert
BEFORE INSERT ON notifications
FOR EACH ROW
EXECUTE FUNCTION notification_trigger();