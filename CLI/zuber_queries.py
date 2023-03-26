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


if __name__ == "__main__":
    # selectCustomers()
    pass
