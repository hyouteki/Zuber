## Project scope
- Our goal is to develop a fully functional backend with decent frontend for a cab booking application.
- Customer and driver both can use the application.
- Customers can book journeys consisting (pick-up location, pick-up time, car, number of people, destination, sharing). The nearest driver will be informed about the journey and can accept the journey.
- The fair will be calculated based on following variables; traffic, car-type, journey-duration, etc.

## Technologies used
- MySQL
- Python
- Google maps API

## Technological requirements

### Entities
- Customer
- Driver
- Booking
- Car

### Relations
- Customer & Booking have a one to many relationship.
- Driver & Car have a one to one relationship.
- Driver & Booking also have a one to many relationship.
- Booking & Car also have a one to one relationship.

### Schema
- Customer (*id*, name, password, history, current-booking, *phone-number*)
- Driver (*id*, name, password, history, car, *phone-number*, current-location, working)
- Booking (*id*, pick-up-location, destination, pick-up-time, car, number-of-people, sharing, status)
- Car (*id*, brand, model, capacity, price, *registration-number*)

## Functional requirements

### Customer actions
- Change password.
- Change phone-number.
- Check history(past bookings/transactions).
-  Cancel booking.

### Driver actions
- Change password.
- Change phone-number.
- Change car.
- Change currently working status.
- Check history(past transactions).
- Cancel booking.

### Administrative actions
- Change driver current-location.
- Change booking status.

### Booking system
Customer will book the journey. The booking will be push to the database and nearest driver will be informed about the journey. A tentative fair will be provided to the Costumer for reference.

### Dummy payment system
Customer can either pay with UPI or cash. 

### User interaction
Customer can select pick-up location and destination using maps. Customer can see the Driver’s current-location in the map. Driver can also navigate to pick-up-location through maps.

### Secure handling
During transaction atomicity will be handled. And all the constraints will be handled with care.