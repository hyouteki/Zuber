-- zuber Database View
-- version 1.0

USE zuber;



-- customer related queries

CREATE VIEW customer_booking_history AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer.customer_id, driver_id, car_id
FROM customer, booking WHERE customer.customer_id = booking.customer_id and customer.customer_id = 1;

-- login customer by phone_number
CREATE VIEW login_customer_by_phone_number AS
SELECT * FROM customer WHERE customer.phone_number = '001-370-289-4294';

-- insert into customer
INSERT INTO customer VALUES(101, 'Martin Luther', 'lmao1234', NULL, '820-403-0187x9440');

-- update customer phone_number
UPDATE customer SET phone_number = '820-403-0187' WHERE customer_id = 2;

-- update customer password
UPDATE customer SET password = 'BEUe96Bz' WHERE customer_id = 2;

-- clear customer current_booking
UPDATE customer SET current_booking = NULL WHERE customer_id = 2;



-- driver related queries

CREATE VIEW driver_booking_history AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer_id, driver.driver_id, booking.car_id
FROM driver, booking WHERE driver.driver_id = booking.driver_id and driver.driver_id = 1;

-- login driver by phone_number
CREATE VIEW login_driver_by_phone_number AS
SELECT * FROM driver WHERE driver.phone_number = '9185337644';

CREATE VIEW working_drivers AS 
SELECT * FROM driver WHERE working=TRUE;

-- insert into driver
INSERT INTO driver VALUES(101, 'Martin Luther', 'lmao1234', NULL, '820-403-0187x9440');

-- update driver phone_number
UPDATE driver SET phone_number = '820-403-0187' WHERE driver_id = 2;

-- update driver password
UPDATE driver SET password = 'BEUe96Bz' WHERE driver_id = 2;

-- clear driver current_booking
UPDATE driver SET current_booking = NULL WHERE driver_id = 2;

-- update driver current_location
UPDATE driver SET current_location = '40611 Henderson Key Brownton, IA 42973' WHERE driver_id = 2;

-- set driver working(status)
UPDATE driver SET working = TRUE WHERE driver_id = 2;

-- clear driver working(status)
UPDATE driver SET working = FALSE WHERE driver_id = 2;



-- car related queries

CREATE VIEW get_car_from_capacity AS
SELECT * FROM car WHERE car.capacity = 5;

CREATE VIEW get_car_from_capacity_range AS
SELECT * FROM car WHERE car.capacity >= 4 AND car.capacity <= 7;

CREATE VIEW get_car_from_registration_number AS
SELECT * FROM car WHERE car.registration_number = '8YBB5ZL';

CREATE VIEW get_car_from_price_per_km_range AS
SELECT * FROM car WHERE car.price_per_km >= 80 AND car.price_per_km <= 120;

CREATE VIEW get_car_from_model AS
SELECT * FROM car WHERE car.model = 'OMV42A';

-- insert into car
INSERT INTO car VALUES(101, 'LUK', '4LMAOQ', 'BRUHMOMENT', 9, 60);



-- booking related queries

CREATE VIEW get_booking_where_sharing_is_true AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer.customer_id, driver_id, car_id
FROM customer, booking WHERE sharing = TRUE AND customer.customer_id = booking.customer_id 
AND customer.customer_id = 1;

CREATE VIEW get_booking_where_sharing_is_false AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer.customer_id, driver_id, car_id
FROM customer, booking WHERE sharing = FALSE AND customer.customer_id = booking.customer_id 
AND customer.customer_id = 1;

CREATE VIEW get_booking_with_destination_for_customer AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer.customer_id, driver_id, car_id
FROM customer, booking WHERE destination = '84251 Kim Forge Suite 650 South Lauraside, PA 33492'
AND customer.customer_id = booking.customer_id AND customer.customer_id = 1;

CREATE VIEW get_booking_with_destination_for_driver AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer_id, driver.driver_id, booking.car_id
FROM driver, booking WHERE destination = '84251 Kim Forge Suite 650 South Lauraside, PA 33492'
AND driver.driver_id = booking.driver_id AND driver.driver_id = 1;

CREATE VIEW get_booking_with_pickup_location_for_customer AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer.customer_id, driver_id, car_id
FROM customer, booking WHERE pickup_location = '04118 Alexander Common Moorehaven, MI 31705'
AND customer.customer_id = booking.customer_id AND customer.customer_id = 1;

CREATE VIEW get_booking_with_pickup_location_for_driver AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer_id, driver.driver_id, booking.car_id
FROM driver, booking WHERE pickup_location = '04118 Alexander Common Moorehaven, MI 31705'
AND driver.driver_id = booking.driver_id AND driver.driver_id = 1;

CREATE VIEW get_boooking_order_by_time_for_customer AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer.customer_id, driver_id, car_id
FROM customer, booking WHERE customer.customer_id = booking.customer_id
AND customer.customer_id = 1 ORDER BY pickup_time;

CREATE VIEW get_boooking_order_by_time_for_driver AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer_id, driver.driver_id, booking.car_id
FROM driver, booking WHERE driver.driver_id = booking.driver_id
AND driver.driver_id = 1 ORDER BY pickup_time;

CREATE VIEW get_boooking_by_number_of_people_for_customer AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer.customer_id, driver_id, car_id
FROM customer, booking WHERE customer.customer_id = booking.customer_id
AND customer.customer_id = 1 AND number_of_people = 3;

CREATE VIEW get_boooking_by_number_of_people_for_driver AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer_id, driver.driver_id, booking.car_id
FROM driver, booking WHERE driver.driver_id = booking.driver_id
AND driver.driver_id = 1 AND number_of_people = 3;

CREATE VIEW get_boooking_by_car_model_for_customer AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer.customer_id, driver_id, booking.car_id
FROM customer, booking, car WHERE customer.customer_id = booking.customer_id 
AND booking.car_id = car.car_id AND customer.customer_id = 1 AND model = 'OMV42A';

CREATE VIEW get_boooking_by_car_model_for_driver AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer_id, driver.driver_id, booking.car_id
FROM driver, booking, car WHERE driver.driver_id = booking.driver_id 
AND booking.car_id = car.car_id AND driver.driver_id = 1 AND model = 'OMV42A';

CREATE VIEW get_boooking_where_booking_status_is_completed_for_customer AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer.customer_id, driver_id, car_id
FROM customer, booking WHERE customer.customer_id = booking.customer_id 
AND customer.customer_id = 2 AND booking_status = 'Completed';

CREATE VIEW get_boooking_where_booking_status_is_completed_for_driver AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer_id, driver.driver_id, booking.car_id
FROM driver, booking WHERE driver.driver_id = booking.driver_id 
AND driver.driver_id = 2 AND booking_status = 'Completed';

CREATE VIEW get_boooking_where_booking_status_is_cancelled_for_customer AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer.customer_id, driver_id, car_id
FROM customer, booking WHERE customer.customer_id = booking.customer_id 
AND customer.customer_id = 1 AND booking_status = 'Canceled';

CREATE VIEW get_boooking_where_booking_status_is_cancelled_for_driver AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer_id, driver.driver_id, booking.car_id
FROM driver, booking WHERE driver.driver_id = booking.driver_id 
AND driver.driver_id = 1 AND booking_status = 'Canceled';

CREATE VIEW get_boooking_where_booking_status_is_active_for_customer AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer.customer_id, driver_id, car_id
FROM customer, booking WHERE customer.customer_id = booking.customer_id 
AND customer.customer_id = 1 AND booking_status = 'Active';

CREATE VIEW get_boooking_where_booking_status_is_active_for_driver AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, transaction_id, sharing, customer_id, driver.driver_id, booking.car_id
FROM driver, booking WHERE driver.driver_id = booking.driver_id 
AND driver.driver_id = 1 AND booking_status = 'Active';

CREATE VIEW get_boooking_by_transaction_type_net_banking AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, booking.transaction_id, sharing, customer.customer_id, driver_id, car_id
FROM customer, booking, transaction WHERE customer.customer_id = booking.customer_id 
AND booking.transaction_id = transaction.transaction_id AND customer.customer_id = 2
AND payment_type = 'Net banking';

CREATE VIEW get_boooking_by_transaction_type_credit_card AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, booking.transaction_id, sharing, customer.customer_id, driver_id, car_id
FROM customer, booking, transaction WHERE customer.customer_id = booking.customer_id 
AND booking.transaction_id = transaction.transaction_id AND customer.customer_id = 3 
AND payment_type = 'Credit card';

CREATE VIEW get_boooking_by_transaction_type_debit_card AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, booking.transaction_id, sharing, customer.customer_id, driver_id, car_id
FROM customer, booking, transaction WHERE customer.customer_id = booking.customer_id 
AND booking.transaction_id = transaction.transaction_id AND customer.customer_id = 8 
AND payment_type = 'Debit card';

CREATE VIEW get_boooking_by_transaction_type_cash AS
SELECT booking_id, pickup_location, destination, number_of_people, pickup_time, 
booking_status, booking.transaction_id, sharing, customer.customer_id, driver_id, car_id
FROM customer, booking, transaction WHERE customer.customer_id = booking.customer_id 
AND booking.transaction_id = transaction.transaction_id AND customer.customer_id = 6 
AND payment_type = 'Cash';

CREATE VIEW get_count_group_by_destination_for_customer AS
SELECT COUNT(booking_id), destination FROM customer, booking 
WHERE customer.customer_id = booking.customer_id AND customer.customer_id = 1 GROUP BY destination;

CREATE VIEW get_count_group_by_pickup_location_for_customer AS
SELECT COUNT(booking_id), destination FROM customer, booking 
WHERE customer.customer_id = booking.customer_id AND customer.customer_id = 1 GROUP BY pickup_location;

CREATE VIEW get_count_group_by_destination_for_driver AS
SELECT COUNT(booking_id), destination FROM driver, booking 
WHERE driver.driver_id = booking.driver_id AND driver.driver_id = 1 GROUP BY destination;

CREATE VIEW get_count_group_by_pickup_location_for_driver AS
SELECT COUNT(booking_id), destination FROM driver, booking 
WHERE driver.driver_id = booking.driver_id AND driver.driver_id = 1 GROUP BY pickup_location;

CREATE VIEW get_count_of_common_destination AS
SELECT COUNT(booking_id), destination FROM booking GROUP BY destination;

CREATE VIEW get_count_of_common_pickup_location AS
SELECT COUNT(booking_id), pickup_location FROM booking GROUP BY pickup_location;

CREATE VIEW get_count_of_pair_of_pickup_location_destination AS
SELECT COUNT(booking_id), pickup_location, destination FROM booking GROUP BY destination, pickup_location;

CREATE VIEW get_customer_having_same_destination_as_customer AS
SELECT customer_id FROM booking WHERE destination IN
(SELECT destination FROM booking WHERE customer_id = 1);

CREATE VIEW get_customer_having_same_pickup_location_as_customer AS
SELECT customer_id FROM booking WHERE destination IN
(SELECT destination FROM booking WHERE customer_id = 1);

