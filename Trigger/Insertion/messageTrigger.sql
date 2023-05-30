CREATE OR REPLACE FUNCTION messages_trigger_chat()
RETURNS TRIGGER AS $$
DECLARE
  messageid TEXT;
BEGIN
  messageid := LPAD(CAST(nextval('message_sequence') AS TEXT), 10, '0') || '-' || TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS.MS');
  NEW.messageid := messageid;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER chat_insert
BEFORE INSERT ON chat
FOR EACH ROW
EXECUTE FUNCTION messages_trigger_chat();