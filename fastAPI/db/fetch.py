import sqlite3

con = sqlite3.connect("/Users/zeus/Documents/ps_db/fastAPI/psd.db")

def fetch_data():
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
formatted_data = fetch_data()
for item in formatted_data:
    print(item)
