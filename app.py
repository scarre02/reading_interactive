from flask import Flask, render_template, request, jsonify, redirect, url_for, session
from markupsafe import Markup
from datetime import date 
from werkzeug.security import generate_password_hash, check_password_hash
from authlib.integrations.flask_client import OAuth
import mysql.connector
import smtplib
import secrets
import logging
import os
import re
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from dotenv import load_dotenv, dotenv_values



import sys

# --- Load environment variables ---
load_dotenv()

sys.path.append(os.path.dirname(os.path.abspath(__file__)))

if os.getenv("FLASK_ENV") == "testing":
    from config_test import db_config, EMAIL_USER, EMAIL_PASS
else:
    from config import db_config, EMAIL_USER, EMAIL_PASS 




def send_verification_email(email, token):
    print("Entering send_verification_email()")  # DEBUG
    sender_email = EMAIL_USER
    sender_password = EMAIL_PASS

    #DEBUG app password
    print("Using App Password length:", len(EMAIL_PASS))
    print("First char:", repr(EMAIL_PASS[0]))
    print("Last char:", repr(EMAIL_PASS[-1]))
    print("EMAIL_PASS (raw):", repr(sender_password))
    print("Length:", len(sender_password))



    subject = "Verify your account on Reading Interactive"
    verification_link = f"http://localhost:5001/verify/{token}"
    print("Using sender:", sender_email)
    print("Using App Password length:", len(sender_password))


    message = MIMEMultipart()
    message["From"] = sender_email
    message["To"] = email
    message["Subject"] = subject

    body = f"""
    <p>Thank you for registering at Reading Interactive</p>
    <p>To activate your account, click the following link:</p>
    <a href="{verification_link}">{verification_link}</a>
    <p>If this wasn’t you, you can ignore this message.</p>
    """
    message.attach(MIMEText(body, "html"))

    try:
        print("Connecting to Gmail SMTP...")
        with smtplib.SMTP("smtp.gmail.com", 587) as server:
            server.starttls()
            server.login(sender_email, sender_password)
            server.sendmail(sender_email, email, message.as_string())
            print("Verification email sent.")
    except Exception as e:
        print("Error sending email:", e)




# --- Create Flask app ---
app = Flask(__name__)
app.secret_key = os.getenv('SECRET_KEY')  # uses the variable from .env

# --- Register Blueprints ---
from auth.routes import auth_bp
app.register_blueprint(auth_bp, url_prefix='/auth')



logging.basicConfig(level=logging.DEBUG)




oauth = OAuth(app)

google = oauth.register(
    name='google',
    client_id=os.getenv("GOOGLE_CLIENT_ID"),
    client_secret=os.getenv("GOOGLE_CLIENT_SECRET"),
    server_metadata_url='https://accounts.google.com/.well-known/openid-configuration',
    client_kwargs={
        'scope': 'openid email profile'
    }
)

@app.route('/google_login')
def google_login():
    redirect_uri = url_for('google_callback', _external=True)
    return google.authorize_redirect(redirect_uri)

@app.route('/google/callback')
def google_callback():
    token = google.authorize_access_token()
    resp = google.get('https://openidconnect.googleapis.com/v1/userinfo')
    user_info = resp.json()

    email = user_info['email']
    name = user_info['name']

    # Save user to DB if not exists
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)

        # Check if the user already exists
        cursor.execute("SELECT * FROM users WHERE email = %s AND provider = 'google'", (email,))
        user = cursor.fetchone()

        if not user:
            cursor.execute("""
                INSERT INTO users (name, email, is_verified, provider)
                VALUES (%s, %s, TRUE, 'google')
            """, (name, email))
            conn.commit()
            cursor.execute("SELECT * FROM users WHERE email = %s AND provider = 'google'", (email,))
            user = cursor.fetchone()

        session['user_id'] = user['id_user']
        session['user_email'] = user['email']
        session['user_name'] = user['name']

    finally:
        cursor.close()
        conn.close()

    return redirect(url_for('index')) 




@app.template_filter('highlight_keywords')
def highlight_keywords(content, keywords):
    highlighted_content = content
    for index, word in enumerate(keywords):
        pattern = re.compile(rf'\b{re.escape(word)}\b', flags=re.IGNORECASE)
        replacement = rf'<span class="keyword" data-word="{word.lower()}">\g<0></span>'
        highlighted_content = pattern.sub(replacement, highlighted_content, count=1)
    return Markup(highlighted_content)

def get_story_by_id(id):
    conn = None
    cursor = None
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)

        cursor.execute("SELECT * FROM stories WHERE id = %s", (id,))
        story = cursor.fetchone()
        if not story:
            logging.warning(f"Story with ID {id} not found.")
            return None

        session['current_story_id'] = story['id']

        cursor.execute('''
            SELECT k.keyword
            FROM keywords k
            JOIN story_keywords sk ON k.id = sk.keyword_id
            WHERE sk.story_id = %s
        ''', (id,))
        keywords = [row['keyword'] for row in cursor.fetchall()]

        content = story['content']
        highlighted_content = content

        if keywords:
            logging.debug(f"Keywords found for story {id}: {keywords}")

        session['words'] = keywords
        return {
            "id": story['id'],
            "title": story['title'],
            "image": story['image'],
            "content": highlighted_content,
            "words": keywords if keywords else []
        }

    except mysql.connector.Error as err:
        logging.error(f"Error connecting to the database: {err}")
        return None
    finally:
        if cursor:
            cursor.close()
        if conn and conn.is_connected():
            conn.close()

def save_to_history(user_id, story_id):
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        cursor.execute("""
            SELECT COUNT(*) FROM history
            WHERE users_id_user = %s AND stories_id = %s
        """, (user_id, story_id))

        if cursor.fetchone()[0] > 0:
            logging.info("Story already saved in history. Skipping insert.")
            return

        today = date.today()
        cursor.execute("""
            INSERT INTO history (users_id_user, stories_id, date_of_lecture)
            VALUES (%s, %s, %s)
        """, (user_id, story_id, today))

        conn.commit()
        logging.info(f"Story {story_id} saved to history for user {user_id}.")

    except mysql.connector.Error as err:
        logging.error(f"Error saving history: {err}")
    finally:
        cursor.close()
        conn.close()

@app.route('/save_history', methods=['POST'])
def save_history_route():
    user_id = session.get('user_id')
    story_id = session.get('current_story_id')
    
    if not user_id or not story_id:
        return jsonify({
            "success": False,
            "message": "Missing user_id or story_id in session"
        }), 400
    
    try:
        save_to_history(user_id, story_id)
        return jsonify({
            "success": True,
            "message": f"Story {story_id} saved to history for user {user_id}"
        })
    except Exception as e:
        logging.error(f"Error saving history: {str(e)}")
        return jsonify({
            "success": False,
            "message": "Error saving to history"
        }), 500

@app.route("/process_speech", methods=["POST"])
def process_speech():
    session.setdefault('pronounced_words', [])
    session.setdefault('incorrect_words', [])
    session.setdefault('current_index', 0)
    
    data = request.get_json()
    spoken_word = re.sub(r'[^a-zA-ZáéíóúüñÑ\s]', '', data.get("word", "").strip().lower())

    words = session.get('words', [])
    current_index = session.get('current_index', 0)
    total = session.get('total_words', len(words))

    if not spoken_word:
        logging.warning("No word was spoken.")
        return jsonify({
            "correct": False,
            "message": "No word was received.",
            "correct_count": len(session['pronounced_words']),
            "incorrect_count": len(session['incorrect_words']),
            "total": total,
            "next_word": words[current_index] if current_index < total else None,
            "words_left": total - current_index
        })

    if current_index >= total:
        logging.info("All words have been pronounced.")
        return jsonify({
            "correct": False,
            "message": "All words have been pronounced.",
            "correct_count": len(session['pronounced_words']),
            "incorrect_count": len(session['incorrect_words']),
            "total": total,
            "next_word": None,
            "words_left": 0,
            "show_feedback": True
        })

    current_word = words[current_index].strip().lower()

    if spoken_word == current_word:
        logging.info(f"'{spoken_word}' is correct.")
        session['pronounced_words'].append(spoken_word)
        session['current_index'] = current_index + 1
        new_index = session['current_index']
        words_left = total - new_index

        if new_index == total:
            logging.info("All words pronounced correctly.")
            return jsonify({
                "correct": True,
                "message": f"Correct! You pronounced all words.",
                "correct_count": len(session['pronounced_words']),
                "incorrect_count": len(session['incorrect_words']),
                "total": total,
                "next_word": None,
                "words_left": 0,
                "show_feedback": True,
                "complete": True
            })
        else:
            next_word = words[new_index]
            return jsonify({
                "correct": True,
                "message": f"Correct! You said: {spoken_word}",
                "correct_count": len(session['pronounced_words']),
                "incorrect_count": len(session['incorrect_words']),
                "total": total,
                "next_word": next_word,
                "words_left": words_left,
                "highlight_word": next_word
            })
    else:
        logging.info(f"'{spoken_word}' is incorrect. Expected: {current_word}")
        session['incorrect_words'].append(spoken_word)
        return jsonify({
            "correct": False,
            "message": f"Incorrect! Expected: {current_word}",
            "correct_count": len(session['pronounced_words']),
            "incorrect_count": len(session['incorrect_words']),
            "total": total,
            "next_word": current_word,
            "words_left": total - current_index
        })

@app.route("/")
def index():
    return render_template("index.html")

@app.route('/story/<int:story_id>')
def story(story_id):
    story_data = get_story_by_id(story_id)
    if not story_data:
        return render_template('404.html'), 404

    session['total_words'] = len(story_data['words'])
    session['pronounced_words'] = []
    session['incorrect_words'] = []
    session['current_index'] = 0
    session['words'] = story_data['words']

    return render_template('story.html', story=story_data)

@app.route('/update_progress', methods=['POST'])
def update_progress():
    word = request.json.get('word')

    if 'pronounced_words' not in session:
        session['pronounced_words'] = []
    if 'incorrect_words' not in session:
        session['incorrect_words'] = []
    if 'current_index' not in session:
        session['current_index'] = 0

    words = session.get('words', [])
    current_index = session.get('current_index', 0)
    total = len(words)

    if current_index < total:
        expected_word = words[current_index].lower().strip()
        spoken_word = word.lower().strip()

        if spoken_word == expected_word:
            pronounced_words = session.get('pronounced_words', [])
            if expected_word not in pronounced_words:
                pronounced_words.append(expected_word)
                session['pronounced_words'] = pronounced_words

            session['current_index'] = current_index + 1
            next_index = session['current_index']
            correct = True
            message = f"Correct! You said: {word}"
            next_word = words[next_index] if next_index < total else None
        else:
            incorrect_words = session.get('incorrect_words', [])
            if spoken_word not in incorrect_words:
                incorrect_words.append(spoken_word)
                session['incorrect_words'] = incorrect_words

            correct = False
            message = f"Incorrect! Expected: {expected_word}"
            next_word = expected_word
    else:
        message = "All words have been pronounced."
        correct = False
        next_word = None

    words_left = total - session['current_index']
    session.modified = True

    return jsonify({
        'message': message,
        'correct': correct,
        'correct_count': len(session.get('pronounced_words', [])),
        'incorrect_count': len(session.get('incorrect_words', [])),
        'next_word': next_word,
        'words_left': words_left,
        'show_feedback': words_left == 0
    })

@app.route('/my_history')
def my_history():
    user_id = session.get('user_id')
    if not user_id:
        return redirect(url_for('auth.login'))

    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)

        cursor.execute("""
            SELECT h.date_of_lecture, s.title, s.image, s.id
            FROM history h
            JOIN stories s ON h.stories_id = s.id
            WHERE h.users_id_user = %s
            ORDER BY h.date_of_lecture DESC
        """, (user_id,))
        history_data = cursor.fetchall()

    except mysql.connector.Error as err:
        logging.error(f"Error fetching history: {err}")
        history_data = []

    finally:
        if cursor:
            cursor.close()
        if conn and conn.is_connected():
            conn.close()

    return render_template('my_history.html', history=history_data)

@app.route('/fairy_tales')
def fairy_tales():
    return render_template('fairy_tales.html')

@app.route('/animal_fables')
def animal_fables():
    return render_template('animal_fables.html')

@app.route('/bedtime_stories')
def bedtime_stories():
    return render_template('bedtime_stories.html')

@app.route('/about_us')
def about_us():
    return render_template('about_us.html')

@app.route('/terms')
def terms():
    return render_template('terms.html')

@app.route('/privacy')
def privacy():
    return render_template('privacy.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))

@app.route('/feedback')
def feedback():
    return render_template('feedback.html')

if __name__ == "__main__":
    app.run(debug=True, port=5001)

