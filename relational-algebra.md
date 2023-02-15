# Customer related queries

- customer booking history
```
history := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (id = 1) (customer ⨝ booking))
```

- login customer using phone number
```
customer := σ (phone_number = '987-654-3210') (customer) 
```

# Driver related queries

- driver booking history 
```
history := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (id = 1) (driver ⨝ booking))
```

- login driver using phone number 
```
customer := σ (phone_number = '987-654-3210') (driver) 
```

- currently working drivers 
```
drivers := σ (working = 1) (driver) 
```

# Car related queries

- get cars with specific capacity 
```
cars := σ (capcity = 5) (car) 
```

- get cars where capacity range is provided
```
cars := σ (capcity >= 4 ∩ capacity <= 7) (car)  
```

- get car with a certain registration number 
```
car := σ (registration_number = '8YBB5ZL') (car)
```

- get cars with price_per_km range is provided
```
cars := σ (price_per_km >= 80 ∩ price_per_km <= 160) (car)
```

- get cars of a specific model 
```
cars := σ (model = 'OMV42A') (car) 
```

# Booking related queries

- get bookings where sharing is true
```
bookings := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (sharing = 1) (customer ⨝ booking))
```

- get bookings where destination is provided
```
bookings := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (destination = '6466 Moore Bypass Apt. 989 Michaelton' ∩ customer_id = 1) (customer ⨝ booking))

bookings := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (destination = '6466 Moore Bypass Apt. 989 Michaelton' ∩ driver_id = 1) (driver ⨝ booking))
```

- get bookings where pickup_location is provided
```
bookings := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (pickup_location = '6466 Moore Bypass Apt. 989 Michaelton' ∩ customer_id = 1) (customer ⨝ booking))

bookings := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (pickup_location = '6466 Moore Bypass Apt. 989 Michaelton' ∩ driver_id = 1) (driver ⨝ booking))
```

- get bookings where number_of_people is provided
```
bookings := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (number_of_people = 4 ∩ customer_id = 1) (customer ⨝ booking))

bookings := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (number_of_people = 4 ∩ driver_id = 1) (driver ⨝ booking))
```

- get bookings where car model is provided is provided
```
bookings := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (model = 'OMV42A' ∩ customer_id = 1) ((customer ⨝ booking) ⨝ car))

bookings := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (model = 'OMV42A' ∩ driver_id = 1) ((driver ⨝ booking) ⨝ car))
```

- get bookings where booking_status is Completed
```
bookings := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (booking_status = 'Completed' ∩ customer_id = 1) (customer ⨝ booking))

bookings := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (booking_status = 'Completed' ∩ driver_id = 1) (driver ⨝ booking))
```

- get bookings where booking_status is Cancelled
```
bookings := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (booking_status = 'Cancelled' ∩ customer_id = 1) (customer ⨝ booking))

bookings := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (booking_status = 'Cancelled' ∩ driver_id = 1) (driver ⨝ booking))
```

- get booking where booking_status is Active
```
booking := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (booking_status = 'Active' ∩ customer_id = 1) (customer ⨝ booking))

booking := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (booking_status = 'Active' ∩ driver_id = 1) (driver ⨝ booking))
```

- get booking where transaction_type is Net banking
```
booking := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (transaction_type = 'Net banking' ∩ customer_id = 1) ((customer ⨝ booking) ⨝ transaction))
```

- get booking where transaction_type is Credit card 
```
booking := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (transaction_type = 'Credit card' ∩ customer_id = 1) ((customer ⨝ booking) ⨝ transaction))
```

- get booking where transaction_type is Debit card
```
booking := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (transaction_type = 'Debit card' ∩ customer_id = 1) ((customer ⨝ booking) ⨝ transaction))
```

- get booking where transaction_type is Cash
```
booking := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (transaction_type = 'Cash' ∩ customer_id = 1) ((customer ⨝ booking) ⨝ transaction))
```

- get booking where transaction amount is provided
```
booking := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (amount = 400 ∩ customer_id = 1) ((customer ⨝ booking) ⨝ transaction))
```

- get booking where transaction amount range is provided
```
booking := π (booking_id, pickup_location, destination, number_of_people, pickup_time, booking_status, transaction_id, sharing, customer_id, driver_i, car_id) (σ (amount >= 400 ∩ amount <= 800 ∩ customer_id = 1) ((customer ⨝ booking) ⨝ transaction))
```