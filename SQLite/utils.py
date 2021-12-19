import sqlite3



# fetch everything from a table
def show_all_from(table):
	# connect to database
	conn = sqlite3.connect('customer.db')

	# create a cursor
	c = conn.cursor()

	c.execute(f"SELECT * FROM {table}")
	items = c.fetchall()

	for item in items:
		print(item)

	conn.commit()
	conn.close()