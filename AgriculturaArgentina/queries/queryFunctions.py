import os
import sqlite3
import pandas as pd

# Function to read SQL
def load_query(file_path: str) -> str:
    try:
        with open(file_path, 'r') as f:
            return f.read()
    except FileNotFoundError:
        print(f"ERROR: Cannot find the query file at path: {file_path}")
        return ""


def run_query(query_file: str, SQLITE_DB: str):
    query = load_query(query_file)
    
    if not query:
        print("Could not load the query. Please check the SQL file name.")  
    else:
        conn = None
        try:
            conn = sqlite3.connect(SQLITE_DB)
            df = pd.read_sql_query(query, conn)

        except sqlite3.OperationalError as e:
            print(f"\nERROR in SQL: {e}")

        finally:
            if conn is not None:
                conn.close()
        return df