import sqlite3


def db_start():
    con = sqlite3.connect("psd.db")
    cur = con.cursor()

    cur.execute(""" CREATE TABLE IF NOT EXISTS
            Data(
            case_number, device, manufacturer,
            model, serial_number , ID, 
            received, responsible, notes, 
            time, mail, password, size, storage_location)""")