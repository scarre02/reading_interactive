import os
from dotenv import load_dotenv

# Load environment variables from a .env file into the system environment
load_dotenv()

# Email credentials used for sending verification emails
EMAIL_USER = os.getenv("EMAIL_USER")
EMAIL_PASS = os.getenv("EMAIL_PASS")

# Database connection credentials
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = os.getenv("DB_NAME")

# Assumes the use of a Unix socket 
db_config = {
    'unix_socket': '/tmp/mysql.sock',
    'user': DB_USER,
    'password': DB_PASSWORD,
    'database': DB_NAME
}
