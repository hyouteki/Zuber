from termcolor import colored


def error(message: str) -> None:
    print(colored(f"ERROR :: {message}", "red"))


def debug(message: str) -> None:
    print(colored(f"DEBUG :: {message}", "blue"))


def cookie(message: str) -> None:
    print(colored(message, "grey"))


def info(message: str) -> None:
    print(colored(message, "magenta"))


def say(message: str) -> None:
    print(colored(message, "cyan"))


def ask(message: str):
    return input(colored(message, "yellow"))


def details(message: str):
    return print(colored(message, "green"))
