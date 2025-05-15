import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from config import EMAIL_USER, EMAIL_PASS 

def send_verification_email(email, token):
    # Debugging: print the loaded email credentials (avoid in production)
    print("EMAIL_PASS loaded from config:", repr(EMAIL_PASS))
    
    print("Using sender:", sender_email)
    sender_password = EMAIL_PASS
    print("Using App Password length:", len(sender_password))

    # Set sender and recipient
    sender_email = EMAIL_USER
    sender_password = EMAIL_PASS

    # Define the subject and verification link
    subject = "Verify your account on Reading Interactive"
    verification_link = f"http://localhost:5001/auth/verify/{token}"

    # Create the email content using HTML
    message = MIMEMultipart()
    message["From"] = sender_email
    message["To"] = email
    message["Subject"] = subject

    # HTML body with verification link
    body = f"""
    <p>Thank you for registering at Reading Interactive</p>
    <p>To activate your account, click the following link:</p>
    <a href="{verification_link}">{verification_link}</a>
    <p>If this wasn’t you, you can ignore this message.</p>
    """
    message.attach(MIMEText(body, "html"))

    try:
        # Connect to Gmail SMTP server
        with smtplib.SMTP("smtp.gmail.com", 587) as server:
            server.starttls()
            server.login(sender_email, sender_password)
            server.sendmail(sender_email, email, message.as_string())
            print("Verification email sent.")
    except Exception as e:
        # Print error if email sending fails
        print("Error sending email:", e)
