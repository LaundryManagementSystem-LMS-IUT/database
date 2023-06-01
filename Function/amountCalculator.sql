CREATE OR REPLACE FUNCTION amount_calc(order_id varchar(100))
RETURNS float AS 
$$
DECLARE
  amount float;
BEGIN
  SELECT SUM(services.price * order_details.quantity)
  INTO amount
  FROM services
  INNER JOIN order_details ON services.manager_email = order_details.manager_email
                           AND services.cloth_type = order_details.cloth_type
                           AND services.operation = order_details.operation
  WHERE order_details.order_id = order_id;

  RETURN amount;
END;
$$ LANGUAGE plpgsql;
