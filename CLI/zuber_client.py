from utils import *
import zuber_queries as query
from customer import Customer

currentCustomer = Customer()


def signUpLoginPage():
    info("Sign up ~ login page")
    say("1. Sign up")
    say("2. Sign in")
    say("3. Exit")
    choice = int(ask("Enter your choice: "))
    if choice == 1:
        signUpPage()
    elif choice == 2:
        signInPage()
    elif choice == 3:
        exit(0)
    else:
        error("Invalid choice")
        signUpLoginPage()


def signUpPage() -> None:
    info("Sign up page")
    say("1. Continue as customer")
    say("2. Continue as driver")
    say("3. Back")
    choice = int(ask("Enter your choice: "))
    if choice == 1:
        signUpCustomerPage()
    elif choice == 2:
        signUpDriverPage()
    elif choice == 3:
        signUpLoginPage()
    else:
        error("Invalid choice")
        signUpPage()


def signInPage():
    info("Sign in page")
    say("1. Continue as customer")
    say("2. Continue as driver")
    say("3. Back")
    choice = int(ask("Enter your choice: "))
    if choice == 1:
        signInCustomerPage()
    elif choice == 2:
        signInDriverPage()
    elif choice == 3:
        signUpLoginPage()
    else:
        error("Invalid choice")
        signUpPage()
    signInPage()


def signInCustomerPage():
    info("Sign in as CUSTOMER page")
    phoneNumber = ask("Enter your phone number: ").strip()
    password = ask("Enter your password: ").strip()
    result = query.authenticateCustomer(phoneNumber, password)
    if len(result) == 0:
        error("Either password is wrong or user is not signed up as a customer")
        signInPage()
    else:
        result = result[0]
        global currentCustomer
        currentCustomer = Customer(result[0], result[1], result[4], result[2])
        cookie("Signed In successfully")
        customerOptions()


def customerOptions():
    if (currentCustomer.isNotNull()):
        info("Customer options page")
        say("1. Check details")
        say("2. Change password")
        say("3. Book a trip")
        say("4. Cancel trip")
        say("5. History")
        say("6. Sign out")
        choice = int(ask("Enter your choice: "))
        if choice == 1:
            printCustomerDetails()
        elif choice == 2:
            updateCustomerPassword()
        elif choice == 3:
            pass
        elif choice == 4:
            pass
        elif choice == 5:
            pass
        elif choice == 6:
            currentCustomer.clear()
            signUpLoginPage()
        else:
            error("Invalid choice")
            signUpPage()
        customerOptions()


def printCustomerDetails():
    details(f"[Customer ID] :: {currentCustomer.id}")
    details(f"[Name] :: {currentCustomer.name}")
    details(f"[Phone number] :: {currentCustomer.phoneNumber}")
    details(f"[Password] :: {currentCustomer.password}")


def updateCustomerPassword():
    oldPassword = ask("Enter old password: ")
    newPassword = ask("Enter new password: ")
    confirmPassword = ask("Confirm new password: ")
    if (oldPassword != currentCustomer.password):
        error("Incorrect old password")
        updateCustomerPassword()
    if (newPassword != confirmPassword):
        error("Password does not match")
        updateCustomerPassword()
    query.updateCustomerPassword(currentCustomer.id, currentCustomer.password)
    currentCustomer.password = newPassword
    cookie("Password updated")


def signInDriverPage():
    debug("Work in progress")


def signUpCustomerPage():
    info("Sign up as CUSTOMER page")
    name = ask("Enter your name: ")
    password = ask("Choose password: ")
    confirmPassword = ask("Confirm password: ")
    while (password != confirmPassword):
        error("Password does not match; Try again")
        password = ask("Choose password: ")
        confirmPassword = ask("Confirm password: ")
    phoneNumber = ask("Phone number: ")
    currentBooking = None
    query.insertCustomer(name, password, currentBooking, phoneNumber)
    cookie("Signed up successfully !!")
    signUpLoginPage()


def signUpDriverPage():
    info("Sign up as DRIVER page")
    name = ask("Enter your name: ")
    password = ask("Choose password: ")
    confirmPassword = ask("Confirm password: ")
    while (password != confirmPassword):
        error("Password does not match; Try again")
        password = ask("Choose password: ")
        confirmPassword = ask("Confirm password: ")
    phoneNumber = ask("Phone number: ")
    currentBooking = None
    cookie("Car details")
    brand = ask("Brand: ")
    model = ask("Model: ")
    registration_number = ask("Registration Number: ")
    capacity = int(ask("Capacity (number of people): "))
    price_per_km = int(ask("Price per km: "))
    query.insertCar(brand, model, registration_number, capacity, price_per_km)
    car_id = query.lastInsertIds()
    currentLocation = None
    query.insertDriver(name, password, currentBooking,
                       phoneNumber, car_id, currentLocation, False)
    cookie("Signed up successfully !!")
    signUpLoginPage()


if __name__ == "__main__":
    cookie("Welcome to ZUBER ~ Client side ~")
    signUpLoginPage()
