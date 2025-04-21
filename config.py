import os
from dotenv import load_dotenv

load_dotenv()

EMAIL_USER = os.getenv("EMAIL_USER")
EMAIL_PASS = os.getenv("EMAIL_PASS")

db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '1234',
    'database': 'interactive_stories'
}

# DEBUG only – remove before deploy
# print("Loaded EMAIL_USER from .env:", EMAIL_USER)
# print("Loaded EMAIL_PASS length:", len(EMAIL_PASS) if EMAIL_PASS else "None")
# print("EMAIL_PASS loaded from .env:", repr(EMAIL_PASS))
