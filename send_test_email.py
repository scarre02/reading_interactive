import smtplib
from email.mime.text import MIMEText

EMAIL_USER = 'nubelus2022@gmail.com'      
EMAIL_PASS = 'obpm qtzk wqvu mjxb'            # App password generated at https://myaccount.google.com/apppasswords
TO_EMAIL = 'silvinacarrera87@gmail.com'       # Where I want to receive the email

msg = MIMEText("Este es un correo de prueba desde Python.")
msg['Subject'] = "Prueba de envío"
msg['From'] = EMAIL_USER
msg['To'] = TO_EMAIL

try:
    print("Conectando a Gmail SMTP...")
    with smtplib.SMTP_SSL('smtp.gmail.com', 465) as server:
        server.login(EMAIL_USER, EMAIL_PASS)
        server.send_message(msg)
        print("Correo enviado correctamente a", TO_EMAIL)
except Exception as e:
    print("Error:", e)

# test_email_send.py
from utils.email import send_verification_email

send_verification_email("silvinacarrera87@gmail.com", "prueba_token_123")
