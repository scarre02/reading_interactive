import os
from dotenv import load_dotenv

load_dotenv()

EMAIL_USER = os.getenv("EMAIL_USER")
EMAIL_PASS = os.getenv("EMAIL_PASS")

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = os.getenv("DB_NAME")

db_config = {
    'unix_socket': '/tmp/mysql.sock',
    'user': DB_USER,
    'password': DB_PASSWORD,
    'database': DB_NAME
}
