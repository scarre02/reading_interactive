from werkzeug.security import generate_password_hash

password = "miclave123"
hashed = generate_password_hash(password, method="pbkdf2:sha256")
print("🔐 Hashed password:", hashed)
