-- zuber Database Triggers
-- version 1.0

USE zuber;
DROP TRIGGER IF EXISTS update_booking_status;
DROP TRIGGER IF EXISTS update_driver_car;

DELIMITER |
CREATE TRIGGER update_booking_status 
BEFORE UPDATE ON booking
FOR EACH ROW
BEGIN
    IF OLD.booking_status = "Ongoing" AND
    NEW.booking_status = "Completed" THEN
        UPDATE customer SET current_booking = NULL
        WHERE customer_id = OLD.customer_id;
        UPDATE driver SET current_booking = NULL
        WHERE driver_id = OLD.driver_id;
    END IF;
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