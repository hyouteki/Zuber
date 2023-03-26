import mysql.connector
from pprint import pprint


class Database():

    def __init__(this):
        this.debug = False
        this.__databaseInstance = mysql.connector.connect(
            host="localhost",
            user="root",
            password="mysql1234",
            database="zuber"
        )
        this.__cursor = this.__databaseInstance.cursor()

    def executeAndPrintQuery(this, query: str):
        if this.debug:
            print(query)
        this.__cursor.execute(query)
        pprint(this.__cursor.fetchall())
        this.__databaseInstance.commit()

    def executeQuery(this, query: str):
        this.__cursor.execute(query)
        this.__databaseInstance.commit()

    def nonCommitQuery(this, query: str):
        this.__cursor.execute(query)

    def getCursor(this): return this.__cursor

    def commit(this): this.__databaseInstance.commit()
