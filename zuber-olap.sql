use zuber;

DROP VIEW IF EXISTS count_booking_passengers;
DROP VIEW IF EXISTS booking_count_on_that_date;
DROP VIEW IF EXISTS booking_count_of_that_fare;
DROP VIEW IF EXISTS get_count_of_common_destination;

-- query to find how many bookings are present with specific amount of passenger count with rollup

CREATE VIEW count_booking_passengers AS
SELECT DISTINCT number_of_people, COUNT(booking_ID) AS number_of_booking
FROM booking
GROUP BY number_of_people WITH ROLLUP;

-- get count of bookings on a particular date

CREATE VIEW booking_count_on_that_date AS
SELECT DISTINCT pickup_time, COUNT(booking_ID) AS number_of_booking
FROM booking
GROUP BY pickup_time;

-- get count of bookings of a particular fare amount

CREATE VIEW booking_count_of_that_fare AS
SELECT DISTINCT amount, COUNT(booking_ID) AS number_of_booking
FROM booking, transaction WHERE transaction.transaction_id = booking.transaction_id
GROUP BY amount ORDER BY number_of_booking ASC;

-- get count of bookings having destination

CREATE VIEW get_count_of_common_destination AS
SELECT COUNT(booking_id), destination FROM booking GROUP BY destination;