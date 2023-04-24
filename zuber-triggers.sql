-- zuber Database Triggers
-- version 1.0

USE zuber;
DROP TRIGGER IF EXISTS update_booking_status;
DROP TRIGGER IF EXISTS insert_booking;
DROP TRIGGER IF EXISTS update_driver_car;

DELIMITER |
CREATE TRIGGER update_booking_status 
BEFORE UPDATE ON booking
FOR EACH ROW
BEGIN
    IF OLD.booking_status <> NEW.booking_status OR 
    OLD.transaction_id <> NEW.transaction_id THEN
        UPDATE customer SET current_booking = NULL
        WHERE customer_id = OLD.customer_id;
        UPDATE driver SET current_booking = NULL
        WHERE driver_id = OLD.driver_id;
    END IF;
END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER insert_booking 
AFTER INSERT ON booking
FOR EACH ROW
BEGIN
    UPDATE customer SET current_booking = NEW.booking_id 
    WHERE customer_id = NEW.customer_id;
    UPDATE driver SET current_booking = NEW.booking_id 
    WHERE driver_id = NEW.driver_id;
END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER update_driver_car 
BEFORE UPDATE ON driver
FOR EACH ROW
BEGIN
    IF OLD.car_id <> NEW.car_id THEN
        DELETE FROM car WHERE car_id = OLD.car_id;
    END IF;
END |
DELIMITER ;