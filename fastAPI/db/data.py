import sqlite3

# Connecting
con = sqlite3.connect("psf.db")
cur = con.cursor()

# Connection: connect
# Executing: execute
cur.execute("CREATE TABLE Data(case_number, device, storage_location)")

res = cur.execute("SELECT name FROM sqlite_master")

cur.execute("INSERT INTO Data VALUES")


print(res.fetchone())