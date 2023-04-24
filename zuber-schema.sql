-- zuber Database Schema
-- version 1.0

DROP SCHEMA IF EXISTS zuber;
CREATE SCHEMA zuber;
USE zuber;

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS; 
SET FOREIGN_KEY_CHECKS=0; 

-- Table structure for table `customer`

CREATE TABLE customer (
    customer_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    current_booking SMALLINT UNSIGNED,
    phone_number VARCHAR(35) NOT NULL,
    PRIMARY KEY (customer_id),
    UNIQUE KEY (phone_number),
    FOREIGN KEY (current_booking) REFERENCES booking (booking_id)
);

-- Table structure for table `car`

CREATE TABLE car (
    car_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    brand VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    registration_number VARCHAR(255) NOT NULL,
    capacity TINYINT NOT NULL,
    price_per_km SMALLINT NOT NULL,
    PRIMARY KEY (car_id),
    UNIQUE KEY (registration_number)
);

-- Table structure for table `driver`

CREATE TABLE driver (
    driver_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    current_booking SMALLINT UNSIGNED,
    phone_number VARCHAR(35) NOT NULL,
    car_id SMALLINT UNSIGNED NOT NULL,
    current_location VARCHAR(255),
    working BOOLEAN NOT NULL,
    PRIMARY KEY (driver_id),
    UNIQUE KEY (phone_number),
    FOREIGN KEY (car_id) REFERENCES car (car_id),
    FOREIGN KEY (current_booking) REFERENCES booking (booking_id)
);

-- Table structure for table `transaction`

CREATE TABLE transaction (
    transaction_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    payment_type VARCHAR(30) NOT NULL,
    amount SMALLINT NOT NULL,
    PRIMARY KEY (transaction_id)
);

-- Table structure for table `booking`

CREATE TABLE booking (
    booking_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    pickup_location VARCHAR(255) NOT NULL,
    destination VARCHAR(255) NOT NULL,
    number_of_people TINYINT NOT NULL,
    pickup_time DATETIME NOT NULL,
    booking_status VARCHAR(20) NOT NULL,
    transaction_id SMALLINT UNSIGNED,
    sharing BOOLEAN NOT NULL,
    customer_id SMALLINT UNSIGNED NOT NULL,
    driver_id SMALLINT UNSIGNED NOT NULL,
    car_id SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (booking_id),
    FOREIGN KEY (transaction_id) REFERENCES transaction (transaction_id),
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    FOREIGN KEY (driver_id) REFERENCES driver (driver_id),
    FOREIGN KEY (car_id) REFERENCES car (car_id)
);

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;