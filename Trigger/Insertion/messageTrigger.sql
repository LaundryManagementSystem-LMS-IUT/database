CREATE OR REPLACE FUNCTION messages_trigger_chat()
RETURNS TRIGGER AS $$
DECLARE
  message_id TEXT;
BEGIN
  message_id := LPAD(CAST(nextval('message_sequence') AS TEXT), 10, '0') || '-' || TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS.MS');
  NEW.message_id := message_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER chat_insert
BEFORE INSERT ON chats
FOR EACH ROW
EXECUTE FUNCTION messages_trigger_chat();