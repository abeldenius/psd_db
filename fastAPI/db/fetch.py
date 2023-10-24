import sqlite3
from typing import List, Dict

con = sqlite3.connect("/Users/zeus/Documents/ps_db/fastAPI/psd.db")

async def fetch_data_from_db() -> List[Dict[str, str]]:
    cur = con.cursor()
    cur.execute("""SELECT * FROM Data""")
    data = cur.fetchall()
    
    # Get the column names from the cursor description
    column_names = [
        "Sagsnummer",
        "Enhed",
        "Mærke",
        "Model",
        "Serienummer",
        "ID",
        "Afsender",
        "Modtager",
        "Noter",
        "Tid",
        "Mail",
        "Password",
        "Størrelse",
        "Lokation"
    ]
    
    # Define a list to store the data as dictionaries
    formatted_data = []
    
    for row in data:
        # Create a dictionary for each row by zipping column names and row values
        data_dict = dict(zip(column_names, row))
        
        # Append the dictionary to the list
        formatted_data.append(data_dict)
    
    return formatted_data

# Fetch and print the formatted data
