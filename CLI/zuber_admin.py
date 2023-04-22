from utils import *
import zuber_queries as query


def options():
    info("Admin options")
    say("1. Select/print statements")
    say("2. Exit")
    choice = int(ask("Enter your choice: "))
    if (choice == 1):
        selectOptions()
    elif (choice == 2):
        exit()
    else:
        error("Invalid choice")
        options()


def selectOptions():
    info("Select/print ~ statements")
    say("1. Select customers")
    say("2. Select drivers")
    say("3. Select cars")
    say("4. Back")
    choice = int(ask("Enter your choice: "))
    if (choice == 1):
        query.selectCustomers()
    elif (choice == 2):
        query.selectDrivers()
    elif (choice == 3):
        query.selectCars()
    elif (choice == 4):
        options()
    else:
        error("Invalid choice")
    selectOptions()


if __name__ == "__main__":
    cookie("Welcome to Zuber ~ Admin side ~")
    options()
