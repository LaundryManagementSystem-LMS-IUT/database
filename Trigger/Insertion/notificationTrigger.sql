CREATE OR REPLACE FUNCTION notification_trigger()
RETURNS TRIGGER AS $$
DECLARE
  notificationid TEXT;
BEGIN
  notificationid := LPAD(CAST(nextval('notification_sequence') AS TEXT), 10, '0') || '-' || TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS')||'-'||NEW.Email;
  NEW.notificationid := notificationid;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER notification_insert
BEFORE INSERT ON notification
FOR EACH ROW
EXECUTE FUNCTION notification_trigger();