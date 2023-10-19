import sqlite3 

con = sqlite3.connect("database.db")
cur = con.cursor()

def generate_id(device: str, value: str) -> str:

    count: int = 0
    
    id: str = ''
    if device == "computer":
        id += 'C'
    elif device == 'bærbar':
        id+= 'B'
    elif device == 'android':
        id+= 'A'
    elif device == 'iphone':
        id+= 'I'
    elif device == 'tablet':
        id+= 'T'
    elif device == 'ipad':
        id+= 'iP'
    elif device == 'stationær':
        id+='S'
    elif device == 'usb':
        id+='U'
    elif device == 'hdd':
        id+='HDD'
    elif device == 'sdd':
        id+='SDD'
    elif device=='email':
        id+='EM'
    elif device=='server':
        id+='SSH'

    # Write loop to iterate through all rows of sqlite3 database and find the highest number
    # of devices with the same ID. Then increment that number by 1 and add it to the ID.
    #  Extract all data from database
    try:

        cur.execute("SELECT case_number FROM Data")
        rows = cur.fetchall()

        for row in rows:
            if row[0] == value:
                count +=1
            else:
                pass
        
        new_device_number = str(count + 1).zfill(3)
    except:
        count += 1

   

    # Increment the device count and format it with leading zeros
    new_device_number = str(count + 1).zfill(3)

    # Generate the new device ID
    new_device_id = f"{value}-{id}-{new_device_number}"


    #value = str(value)
    #value+= f"-{id}-{padded_number}"
    
    #return "Test"
    return new_device_id