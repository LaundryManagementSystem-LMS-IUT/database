CREATE OR REPLACE FUNCTION notification_trigger()
RETURNS TRIGGER AS $$
DECLARE
  notificationid TEXT;
BEGIN
  notificationid := LPAD(CAST(nextval('message_sequence') AS TEXT), 10, '0') || '-' || to_char(current_date, 'YYYYMMDD')||'-'||NEW.Email;
  NEW.notificationid := notificationid;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER notification_insert
BEFORE INSERT ON notification
FOR EACH ROW
EXECUTE FUNCTION notification_trigger();