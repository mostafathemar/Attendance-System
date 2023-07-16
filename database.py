import mysql.connector
import requests
import json

class Database:
    def __init__(self):
        self.db_config = {
            'host': 'localhost',
            'port': '3306',
            'user': 'root',
            'password': 'MyNewPass',
            'database': 'attendance'
        }
        self.conn = self.connect_to_database()
        self.create_attendance_table()

    def connect_to_database(self):
        try:
            connection = mysql.connector.connect(
                host=self.db_config['host'],
                port=self.db_config['port'],
                user=self.db_config['user'],
                password=self.db_config['password'],
                database=self.db_config['database']
            )
            return connection
        except mysql.connector.Error as err:
            if err.errno == mysql.connector.errorcode.ER_ACCESS_DENIED_ERROR:
                print("Error: Invalid credentials.")
            elif err.errno == mysql.connector.errorcode.ER_BAD_DB_ERROR:
                print("Database does not exist. Creating the database...")
                self.create_database()
                return self.connect_to_database()
            else:
                print(f"Error: {err}")
            exit(1)

    def create_database(self):
        try:
            connection = mysql.connector.connect(
                host=self.db_config['host'],
                port=self.db_config['port'],
                user=self.db_config['user'],
                password=self.db_config['password']
            )
            cursor = connection.cursor()
            cursor.execute(f"CREATE DATABASE IF NOT EXISTS {self.db_config['database']}")
            cursor.close()
            print("Database created successfully.")
        except mysql.connector.Error as err:
            print(f"Failed to create database: {err}")
            exit(1)

    def create_attendance_table(self):
        try:
            cursor = self.conn.cursor()
            cursor.execute("SHOW TABLES LIKE 'attendance'")
            table_exists = cursor.fetchone()

            if table_exists:
                print("Attendance table already exists.")
            else:
                cursor.execute("""
                    CREATE TABLE attendance (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        email VARCHAR(255),
                        date DATE,
                        time TIME
                    )
                """)
                print("Attendance table created successfully.")

            cursor.close()
            self.conn.commit()

        except mysql.connector.Error as err:
            print(f"Failed to create or check attendance table: {err}")
            exit(1)

    def insert_attendance_data(self, email, date, time):
        try:
            cursor = self.conn.cursor()
            insert_query = """
                INSERT INTO attendance (email, date, time)
                VALUES (%s, %s, %s)
            """
            cursor.execute(insert_query, (email, date, time))
            cursor.close()
            self.conn.commit()

            # Send data to web API
            self.send_to_web_api(email, date, time)

        except mysql.connector.Error as error:
            print(f"Error occurred while inserting attendance data: {error}")

    def send_to_web_api(self, email, date, time):
        # API endpoint
        url = "https://omar-gradeuation-project.forloop-eg.com/api/attendance"

        # Defining a params dict for the parameters to be sent to the API
        data = {'email': email, 'date': str(date), 'time': str(time)}

        # Define the headers
        headers = {
            'Content-Type': 'application/json',
        }

        # Sending POST request and saving response as response object
        try:
            response = requests.post(url, data=json.dumps(data), headers=headers)
            if response.status_code == 200:
                print("Data sent successfully to web API")
            elif response.status_code == 404:
                print(f"User not found in API's database, skipping record: {data}")
            else:
                print(f"Error sending data to web API. Status code: {response.status_code}")
                print("Response:", response.text)  # Print the response for debugging
        except requests.exceptions.RequestException as error:
            print(f"Error occurred while sending data to web API: {error}")

    def get_attendance_data(self):
        try:
            cursor = self.conn.cursor(dictionary=True)
            query = "SELECT * FROM attendance"
            cursor.execute(query)
            attendance_data = cursor.fetchall()
            cursor.close()
            return attendance_data
        except mysql.connector.Error as error:
            print(f"Error occurred while retrieving attendance data: {error}")
            return []

    def save_attendance_data(self, email, date, time):
        self.insert_attendance_data(email, date, time)