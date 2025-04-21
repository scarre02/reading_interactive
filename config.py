import os
from dotenv import load_dotenv

load_dotenv()

EMAIL_USER = os.getenv("EMAIL_USER")
EMAIL_PASS = os.getenv("EMAIL_PASS")

db_config = {
    'unix_socket': '/tmp/mysql.sock',  # Socket path
    'user': 'root',
    'password': '1234',
    'database': 'interactive_stories'
}


