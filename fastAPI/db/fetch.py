import sqlite3

con = sqlite3.connect("/Users/zeus/Documents/ps_db/fastAPI/psd.db")
cur = con.cursor()

cur.execute("""SELECT * FROM Data""")

data = cur.fetchall()

for x in data:
    print(x)

