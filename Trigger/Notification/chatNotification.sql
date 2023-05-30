CREATE OR REPLACE FUNCTION chat_receiver_trigger()
RETURNS TRIGGER AS $$
DECLARE
  SenderEmail varchar(100);
  SenderName varchar(100);
BEGIN
  SELECT CHAT_SENDER.SenderEmail INTO SenderEmail from CHAT_SENDER WHERE message_id=NEW.message_id;
  SELECT Username INTO SenderName FROM USERS WHERE Email=SenderEmail;
  INSERT INTO NOTIFICATION(Email,Message) VALUES(NEW.ReceiverEmail,'New Message from '||SenderName);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER chat_insert_notification
BEFORE INSERT ON chat_receivers
FOR EACH ROW
EXECUTE FUNCTION chat_receiver_trigger();