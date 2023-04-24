__There are two transactions, each representing a customer booking a trip with the same (nearest) driver and making a conflicting / non-conflicting transaction at different scheduling policies.__
# Transaction 1
``` mysql
START TRANSACTION;
-- getting the nearest driver instance i.e. with id 69 :: R(A)
SELECT * FROM driver WHERE driver_id = 69;
-- inserting booking of customer with id 1 and nearest driver :: W(A)
INSERT INTO booking VALUES
(0, 'here', 'there', 6, '2001-08-01 11:03:42', 'Ongoing', NULL, FALSE, 1, 69, 69);
COMMIT;
```
# Transaction 2
``` mysql
START TRANSACTION;
-- getting the nearest driver instance i.e. with id 69 :: R(A)
SELECT * FROM driver WHERE driver_id = 69;
-- inserting booking of customer with id 2 and nearest driver :: W(A)
INSERT INTO booking VALUES
(0, 'here', 'there', 6, '2001-08-01 11:03:42', 'Ongoing', NULL, FALSE, 2, 69, 69);
COMMIT;
```
# Non-conflicting scheduling
| Transaction 1  | Transaction 2 |
|     :---:      |     :----:    |
| R(A)           |               |
| W(A)           |               |
| Commit         |               |
|                | R(A)          |
|                | W(A)          |
|                | Commit        |

Transaction 1 starts and ends before the starting of transaction 2, which can also be thought of as sequentially executing queries present in T1 and T2, respectively. Hence it is a non-conflicting (serial) transaction.

# Conflicting scheduling
| Transaction 1  | Transaction 2 | 
|     :---:      |     :----:    |
| R(A)           |               |
| W(A)           |               |
|                | R(A)          |
|                | W(A)          |
| Commit         |               |
|                | Commit        |

This is a conflicting transaction because first, T1 reads and then writes based on the initial data, and then T2 reads and writes (again based on the initial data, as the write operation made before the start of transaction two does not take effect until the commit). And when it writes in the second transaction, it causes an inconsistent state.