import sqlite3
import pandas as pd 

# Connecting

column_data = ["""Sagsnummer", "Enhed", "Mærke", "Model", "Serienummer", "ID", "Modtaget af", 
               "Ansvarlig", "Noter", "Tid og dato", "Mail", "Password", "Lokation"""]
overview = pd.DataFrame(columns=column_data)
con = sqlite3.connect("psd.db")
cur = con.cursor()
cur.execute(""" CREATE TABLE IF NOT EXISTS
            Data(
            case_number, device, manufacturer,
            model, serial_number , ID, 
            received, responsible, notes, 
            time, mail, password, storage_location)""")


def insertion(values: dict):
    cur.execute("""INSERT INTO Data(
                case_number, device, manufacturer,
                model, serial_number , ID, 
                received, responsible, notes, 
                time, mail, password, storage_location)
                 VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)""", 
                (values["Sagsnummer"], values["Mærke"], values["Enhed"], 
                values["Model"], values["Serienummer"], values["ID"], 
                values["Afsender"], values["Modtager"], values["Eventuelle noter"], 
                values["Tid og dato"], values["Email"], values["Password"], 
                values["Lokation for opbevaring"]))
    con.commit()



# con.commit()

#  NEW_ROW = {}
#    st.write("#### Oversigt over data")
#    cur.execute('''SELECT * FROM Data''')
#    rows = cur.fetchall()
#    for row in rows:
#        NEW_ROW = dict(zip(column_data, row))
#        overview = pd.concat([overview, pd.DataFrame(NEW_ROW, index=[0])], ignore_index=True)z<