import secrets
import re

# Generates a unique token for email verification
def generate_verification_token():
    return secrets.token_urlsafe(32)

# Simple email validator
def is_valid_email(email):
    # Very basic regex to validate email structure
    return re.match(r"[^@]+@[^@]+\.[^@]+", email)

# Function to format names or normalize data
def format_name(name):
    return name.strip().title()

# Function to format messages for logs
def log_message(msg):
    return f"[ReadingApp] {msg}"
