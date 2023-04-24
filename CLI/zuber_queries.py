from database import Database
from tabulate import tabulate

database = Database()


def executeAndPrintQuery(query: str): database.executeAndPrintQuery(query)


def executeQuery(query: str): database.executeQuery(query)


def lastInsertIds() -> int:
    database.nonCommitQuery("SELECT last_insert_id();")
    ret = database.getCursor().fetchall()[0][0]
    database.commit()
    return ret


def selectCustomers():
    database.nonCommitQuery("SELECT * FROM customer;")
    data = [record for record in database.getCursor().fetchall()]
    print(tabulate(data, headers=["ID", "Name",
                                  "Password", "Current booking", "Phone number"], tablefmt="fancy_grid"))


def selectDrivers():
    database.nonCommitQuery("SELECT * FROM driver;")
    data = [record for record in database.getCursor().fetchall()]
    print(tabulate(data, headers=["ID", "Name", "Password", "Current booking",
          "Phone number", "Car ID", "Current location", "Working status"], tablefmt="fancy_grid"))


def selectCars():
    database.nonCommitQuery("SELECT * FROM car;")
    data = [record for record in database.getCursor().fetchall()]
    print(tabulate(data, headers=[
          "ID", "Brand", "Model", "Registration number", "Capacity", "Price per km"], tablefmt="fancy_grid"))


def selectBookings():
    database.nonCommitQuery(
        f"SELECT * FROM booking;")
    data = [record for record in database.getCursor().fetchall()]
    print(tabulate(data, headers=["ID", "Pickup location", "Destination", "# People",
                                  "Pickup time", "Booking status", "Transaction ID",
                                  "Sharing", "Customer ID", "Driver ID", "Car ID"], tablefmt="fancy_grid"))


def selectTransactions():
    database.nonCommitQuery(
        f"SELECT * FROM transaction;")
    data = [record for record in database.getCursor().fetchall()]
    print(tabulate(data, headers=[
          "ID", "Payment type", "Amount"], tablefmt="fancy_grid"))


def insertCustomer(name: str, password: str,
                   currentBooking, phoneNumber: str):
    if currentBooking == None:
        database.executeQuery(
            f"INSERT INTO customer VALUES(0, '{name}', '{password}', NULL, '{phoneNumber}');")
    else:
        database.executeQuery(
            f"INSERT INTO customer VALUES(0, '{name}', '{password}', {currentBooking}, '{phoneNumber}');")


def insertCar(brand: str, model: str, registration_number: str, capacity: int, price_per_km: int):
    database.executeQuery(
        f"INSERT INTO car VALUES(0, '{brand}', '{model}', '{registration_number}', {capacity}, {price_per_km});")


def insertDriver(name: str, password: str,
                 currentBooking, phoneNumber: str, car_id: int,
                 currentLocation, workingStatus):
    if workingStatus == True:
        workingStatus = "TRUE"
    else:
        workingStatus = "FALSE"
    database.executeQuery(
        f"INSERT INTO driver VALUES(0, '{name}', '{password}', NULL, '{phoneNumber}', {car_id}, NULL, {workingStatus});")


def authenticateCustomer(phoneNumber: str, password: str):
    database.nonCommitQuery(
        f"SELECT * FROM customer WHERE phone_number = '{phoneNumber}' AND password = '{password}';")
    ret = database.getCursor().fetchall()
    database.commit()
    return ret


def updateCustomerPassword(id: int, password: str):
    database.executeQuery(
        f"UPDATE customer SET password = '{password}' WHERE customer_id = '{id}';")
    database.commit()


def setCustomerCurrentBooking(customerId, bookingId):
    database.executeQuery(
        f"UPDATE customer SET current_booking = {bookingId} WHERE customer_id = {customerId};")
    database.commit()


def setDriverCurrentBooking(driverId, bookingId):
    database.executeQuery(
        f"UPDATE driver SET current_booking = {bookingId} WHERE driver_id = {driverId};")
    database.commit()


def customerHasCurrentBooking(customerId):
    database.nonCommitQuery("SELECT * FROM customer;")
    data = [record for record in database.getCursor().fetchall()]
    customer = [record for record in data if record[0] == customerId][0]
    return customer[3] is not None


def driverHasCurrentBooking(driverId):
    database.nonCommitQuery("SELECT * FROM driver;")
    data = [record for record in database.getCursor().fetchall()]
    driver = [record for record in data if record[0] == driverId][0]
    return driver[3] is not None


def cancelCustomerBooking(customerId):
    database.nonCommitQuery("SELECT * FROM customer;")
    data = [record for record in database.getCursor().fetchall()]
    customer = [record for record in data if record[0] == customerId][0]
    database.executeQuery(
        f"UPDATE booking SET booking_status = 'Canceled' WHERE booking_id = {customer[3]};")


def getCustomerBookingHistory(customerId):
    database.nonCommitQuery(
        f"SELECT * FROM booking WHERE customer_id = {customerId};")
    data = [record for record in database.getCursor().fetchall()]
    print(tabulate(data, headers=["ID", "Pickup location",
                                  "Destination", "# People", "Pickup time", "Booking status",
                                  "Transaction ID", "Sharing", "Customer ID", "Driver ID", "Car ID"], tablefmt="fancy_grid"))


def getCurrentBooking(customerId):
    database.nonCommitQuery(
        f"SELECT * FROM customer WHERE customer_id = {customerId};")
    customer = [record for record in database.getCursor().fetchall()][0]
    currentBookingId = customer[3]
    database.nonCommitQuery(
        f"SELECT * FROM booking WHERE booking_id = {currentBookingId};")
    currentBooking = [record for record in database.getCursor().fetchall()][0]
    carId = currentBooking[10]
    database.nonCommitQuery(
        f"SELECT * FROM car WHERE car_id = {carId};")
    car = [record for record in database.getCursor().fetchall()][0]
    return currentBooking, car


def getLocationCoordinates(location: str):
    location = location.lower().replace(" ", "")
    hash_table: dict = {
        'a': (0, 0), 'b': (0, 1), 'c': (0, 2),
        'd': (1, 0), 'e': (1, 1), 'f': (1, 2),
        'g': (2, 0), 'h': (2, 1), 'i': (2, 2),
        'j': (3, 0), 'k': (3, 1), 'l': (3, 2),
        'm': (4, 0), 'n': (4, 1), 'o': (4, 2),
        'p': (5, 0), 'q': (5, 1), 'r': (5, 2),
        's': (6, 0), 't': (6, 1), 'u': (6, 2),
        'v': (7, 0), 'w': (7, 1), 'x': (7, 2),
        'y': (8, 0), 'z': (8, 1), '0': (8, 2),
        '1': (9, 0), '2': (9, 1), '3': (9, 2),
        '4': (10, 0), '5': (10, 1), '6': (10, 2),
        '7': (11, 0), '8': (11, 1), '9': (11, 2),
    }
    x: int = 0
    y: int = 0
    for char in location:
        if char in hash_table:
            x += hash_table[char][0]
            y += hash_table[char][1]
    return x, y


def distance(point1, point2):
    return ((point1[0]-point2[0])**2 + (point1[1]-point2[1])**2)**(0.5)


def getNearestDriver(pickupLocation: str, numberOfPeople: int, sharing: bool):
    database.nonCommitQuery("SELECT * FROM driver;")
    driverData = [record for record in database.getCursor().fetchall()]
    database.nonCommitQuery("SELECT * FROM car;")
    carData = [record for record in database.getCursor().fetchall()]
    if driverData.__len__() == 0:
        return None
    customerCurrentCoordinates = getLocationCoordinates(pickupLocation)
    nearestDriverId = driverData[0][0]
    nearestDistance = distance(customerCurrentCoordinates,
                               getLocationCoordinates(driverData[0][6]))
    flag = False
    for i in range(driverData.__len__()):
        driver = driverData[i]
        if driver[7] == True:  # if driver is working
            carId = driver[5]
            car = [record for record in carData if record[0] == carId][0]
            if car[4] >= numberOfPeople:  # if capacity >= numberOfPeople
                driverCurrentCoordinates = getLocationCoordinates(driver[6])
                currentDistance = distance(customerCurrentCoordinates,
                                           driverCurrentCoordinates)
                if nearestDistance <= currentDistance:
                    flag = True
                    nearestDriverId = driver[0]
                    nearestDistance = currentDistance
    if flag:
        return nearestDriverId
    else:
        return None


def makeBooking(pickupLocation, destination, numberOfPeople, pickupTime,
                bookingStatus, sharing, customerId, driverId):
    database.nonCommitQuery("SELECT * FROM driver;")
    driverData = [record for record in database.getCursor().fetchall()]
    driver = [record for record in driverData if record[0] == driverId][0]
    carId = driver[5]
    database.executeQuery(
        f"INSERT INTO booking VALUES(0, '{pickupLocation}', '{destination}', {numberOfPeople}, '{pickupTime}', '{bookingStatus}', NULL, {sharing}, {customerId}, {driverId}, {carId});")
    bookingId = lastInsertIds()
    setCustomerCurrentBooking(customerId, bookingId)
    setDriverCurrentBooking(driverId, bookingId)


def getCustomerTransactionHistory(customerId):
    database.nonCommitQuery(
        f"SELECT transaction.* FROM transaction, booking WHERE booking.customer_id = {customerId} AND booking.transaction_id = transaction.transaction_id;")
    data = [record for record in database.getCursor().fetchall()]
    print(tabulate(data, headers=[
          "ID", "Payment type", "Amount"], tablefmt="fancy_grid"))


def makeTransaction(bookingId, paymentType, amount):
    database.executeQuery(
        f"INSERT INTO transaction VALUES(0, '{paymentType}', {amount});")
    transactionId = lastInsertIds()
    database.executeQuery(
        f"UPDATE booking SET transaction_id = {transactionId}, booking_status = 'Completed' WHERE booking_id = {bookingId};")
    database.nonCommitQuery(
        f"SELECT * FROM booking WHERE booking_id = {bookingId};")
    booking = [record for record in database.getCursor().fetchall()][0]
    destination = booking[2]
    driverId = booking[9]
    database.executeQuery(
        f"UPDATE driver SET current_location = '{destination}' WHERE driver_id = {driverId};")


if __name__ == "__main__":
    # selectCustomers()
    # print(getNearestDriver("hello 27r8ygbvwnwnvlkm;v, .  ,nmoto", 9, False))
    # getCustomerTransactionHistory(99)
    # print(getCurrentBooking(100))
    makeTransaction(81, "UPI", 69)
    pass
