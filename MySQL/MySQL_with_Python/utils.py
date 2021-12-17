#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import pandas as pd
import mysql.connector
from mysql.connector import Error


# In[ ]:


# create server connection

def create_server_connection(host_name, user_name, user_password):
    connection = None
    try:
        connection = mysql.connector.connect(
            host = host_name,
            user = user_name,
            password = user_password
        )
        print('MySQL Database connection sussefull.')
    
    except Error as err:
        print(f'Error: {err}')
    
    return connection


# In[ ]:


# create mysql_python database

def create_database(connection, query):
    cursor = connection.cursor()
    try:
        cursor.execute(query)
        print('Database created successfully.')
    except Error as err:
        print(f'Error: {err}')


# In[ ]:


# connect to a database

def create_db_connection(host_name, user_name, user_password, db_name):
    connection = None
    try:
        connection = mysql.connector.connect(
            host = host_name,
            user = user_name,
            password = user_password,
            database = db_name
        )
        print('MySQL database connection successful')
    
    except Error as err:
        print(f'Error: {err}')
        
    return connection


# In[ ]:


# Execute sql queries

def execute_query(connection, query):
    cursor = connection.cursor() # to estalished and run sql statement
    try:
        cursor.execute(query)
        connection.commit()
        print('Query executed successfully.')
    except Error as err:
        print(f'Error: {err}')


# In[ ]:


# Read rows from database -> select

def read_query(connection, query):
    cursor = connection.cursor()
    result = None
    try:
        cursor.execute(query)
        result = cursor.fetchall()
        return result
    except Error as err:
        print(f'Error: {err}')


# In[ ]:


# fetch all data from a sql table and return as dataframe

# def select_all_from(table, pw='password_of_localhost'):
#     connection = create_db_connection('localhost', 'root', pw, db)
#     results = read_query(connection, f'select * from {table}')
#     from_db = []
#     for result in results:
#         from_db.append(list(result))
#     df = pd.DataFrame(from_db)
#     print(df)




