from flask import Blueprint, render_template, request, redirect, url_for, session
from werkzeug.security import generate_password_hash, check_password_hash
import mysql.connector
import secrets
import logging
import os
from dotenv import load_dotenv
from config import db_config, EMAIL_USER, EMAIL_PASS
from utils.email import send_verification_email
from utils.utils import generate_verification_token, is_valid_email

auth_bp = Blueprint('auth', __name__)

load_dotenv()


# Login route

@auth_bp.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form.get("email")
        password = request.form.get("password")

        if not email or not password:
            return render_template("login.html", error="Please fill in all fields.")

        try:
            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT * FROM users WHERE email = %s AND provider='local'", (email,))
            user = cursor.fetchone()

            if user and check_password_hash(user['password'], password):
                if not user['is_verified']:
                    return render_template("login.html", error="Please verify your email before logging in.")

                session['user_id'] = user['id_user']
                session['user_email'] = user['email']
                session['user_name'] = user['name']

                return redirect(url_for("fairy_tales"))  # Make sure this route exists
            else:
                return render_template("login.html", error="Incorrect email or password.")

        except mysql.connector.Error as err:
            logging.error(f"Login error: {err}")
            return render_template("login.html", error="Database error.")
        finally:
            cursor.close()
            conn.close()

    return render_template("login.html")



# Signup route

@auth_bp.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        dob = request.form['dob']
        password_raw = request.form['password']
        terms = request.form.get('terms') == 'on'
        privacy = request.form.get('privacy') == 'on'

        # Validate required fields
        if not name or not dob or not password_raw:
            return render_template("signup.html", error="Please fill in all required fields.")

        # Email format validation
        if not is_valid_email(email):
            return render_template("signup.html", error="Invalid email format.")

        # Password length check
        if len(password_raw) < 6:
            return render_template("signup.html", error="Password must be at least 6 characters long.")

        # Terms and privacy policy check
        if not terms or not privacy:
            return render_template("signup.html", error="You must accept the terms and privacy policy.")

        # Hash password
        password = generate_password_hash(password_raw)

        # Generate verification token
        token = generate_verification_token()

        try:
            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
            existing_user = cursor.fetchone()

            if existing_user:
                return render_template("signup.html", error="This email is already registered. Please log in or use a different one.")

            cursor.execute("""
                INSERT INTO users (name, email, dob, password, terms_accepted, privacy_accepted, is_verified, verification_token, provider)
                VALUES (%s, %s, %s, %s, %s, %s, FALSE, %s, 'local')
            """, (name, email, dob, password, terms, privacy, token))
            conn.commit()

            try:
                send_verification_email(email, token)
                print("Calling send_verification_email()")
            except Exception as e:
                logging.error(f"Error sending verification email: {e}")

            return render_template("verify_notice.html")

        finally:
            cursor.close()
            conn.close()

    return render_template("signup.html")



# Email verification route

@auth_bp.route("/verify/<token>")
def verify_email(token):
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        cursor.execute("SELECT id_user FROM users WHERE verification_token = %s", (token,))
        result = cursor.fetchone()

        if result:
            cursor.execute("""
                UPDATE users SET is_verified = TRUE, verification_token = NULL
                WHERE verification_token = %s
            """, (token,))
            conn.commit()
            return render_template("verification_success.html")
        else:
            return render_template("verification_failed.html")

    except mysql.connector.Error as err:
        logging.error(f"Verification error: {err}")
        return "Database error."

    finally:
        cursor.close()
        conn.close()
