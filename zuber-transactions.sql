USE zuber;

-- T1
START TRANSACTION;
-- getting the nearest driver instance i.e. with id 69 :: R(A)
SELECT * FROM driver WHERE driver_id = 69;
-- inserting booking of customer with id 1 and nearest driver :: W(A)
INSERT INTO booking VALUES 
(0, 'here', 'there', 6, '2001-08-01 11:03:42', 'Ongoing', NULL, FALSE, 1, 69, 69);
COMMIT;

-- T2
START TRANSACTION;
-- getting the nearest driver instance i.e. with id 69 :: R(A)
SELECT * FROM driver WHERE driver_id = 69;
-- inserting booking of customer with id 2 and nearest driver :: W(A)
INSERT INTO booking VALUES 
(0, 'here', 'there', 6, '2001-08-01 11:03:42', 'Ongoing', NULL, FALSE, 2, 69, 69);
COMMIT;