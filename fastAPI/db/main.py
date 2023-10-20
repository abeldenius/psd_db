import sqlite3
import pandas as pd 

# Connecting

column_data = ["Sagsnummer", "Enhed", "Mærke", "Model", "Serienummer", "ID", "Modtaget af", "Ansvarlig", "Noter", "Tid og dato", "Mail", "Password", "Lokation"]
overview = pd.DataFrame(columns=column_data)

con = sqlite3.connect("psd.db")
cur = con.cursor()
cur.execute("CREATE TABLE IF NOT EXISTS Data(case_number, device, manufacturer, model, serial_number , ID,  received, responsible, notes, time, mail, password, storage_location, case_comment)")

# con.commit()