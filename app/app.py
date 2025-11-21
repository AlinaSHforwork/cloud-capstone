import time
import os
import psycopg2
from flask import Flask

app = Flask(__name__)

def get_db_connection():
    # Retry logic to wait for the database to start up
    retries = 5
    while retries > 0:
        try:
            conn = psycopg2.connect(
                host=os.environ.get('DB_HOST'),
                database=os.environ.get('DB_NAME'),
                user=os.environ.get('DB_USER'),
                password=os.environ.get('DB_PASS')
            )
            return conn
        except psycopg2.OperationalError:
            print("Waiting for DB...")
            time.sleep(2)
            retries -= 1
    return None

@app.route('/')
def hello():
    return "<h2>Hello from the Cloud Capstone!</h2>"

@app.route('/db')
def db_test():
    conn = get_db_connection()
    if conn:
        cur = conn.cursor()
        cur.execute('SELECT version();')
        db_version = cur.fetchone()
        cur.close()
        conn.close()
        return f"<h3>Database Connected! Version: {db_version}</h3>"
    else:
        return "<h3>Connection Failed :(</h3>"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)