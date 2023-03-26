class Customer:
    def __init__(this, id: int = -1, name: str = "", phoneNumber: str = "", password: str = ""):
        this.id = id
        this.name = name
        this.phoneNumber = phoneNumber
        this.password = password

    def isNull(this): return this.id == -1

    def isNotNull(this): return this.id != -1

    def clear(this):
        this.id = -1
        this.name = ""
        this.phoneNumber = ""
        this.password = ""
