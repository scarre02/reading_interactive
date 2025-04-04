from flask import Flask, render_template, request, jsonify, session, redirect, url_for
import mysql.connector
import random
import re
import json  # To handle JSON in Python
import logging
from werkzeug.security import generate_password_hash, check_password_hash



app = Flask(__name__)
app.secret_key = 'your_secret_key'

# MySQL Connection Configuration
db_config = {
    'host': 'localhost',     # Change according to your setup
    'user': 'root',          # Change according to your MySQL user
    'password': '1234',      # Change according to your MySQL password
    'database': 'interactive_stories'
}

# Configure logging
logging.basicConfig(level=logging.DEBUG)

def get_story_by_id(id):
    conn = None
    cursor = None
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)

        # Select a story by ID
        cursor.execute("SELECT * FROM stories WHERE id = %s", (id,))
        story = cursor.fetchone()
        if not story:
            logging.warning(f"Story with ID {id} not found.")
            return None

        # Obtain the associated keywords
        cursor.execute('''
            SELECT k.keyword
            FROM keywords k
            JOIN story_keywords sk ON k.id = sk.keyword_id
            WHERE sk.story_id = %s
        ''', (id,))
        keywords = [row['keyword'] for row in cursor.fetchall()]

        # Do not highlight keywords in the content initially
        content = story['content']
        highlighted_content = content
        # Verify if there are actually keywords
        if keywords:
            logging.debug(f"Keywords found for story {id}: {keywords}")

        # Wrap each keyword with a unique span
        for index, word in enumerate(keywords):
            highlighted_content = re.sub(
                rf'\b{re.escape(word)}\b',
                f'<span class="keyword" data-index="{index}">{word}</span>',
                highlighted_content,
                flags=re.IGNORECASE
            )

        # Save words in the session
        session['random_words'] = keywords
        if 'pronounced_words' not in session:
            session['pronounced_words'] = []  # Initialize as empty

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

@app.route("/process_speech", methods=["POST"])
def process_speech():
    # Initialize session variables if they do not exist
    if 'pronounced_words' not in session:
        session['pronounced_words'] = []
    if 'incorrect_words' not in session:
        session['incorrect_words'] = []

    data = request.get_json()
    spoken_word = re.sub(r'[^a-zA-ZáéíóúüñÑ\s]', '', data.get("word", "").strip().lower())

    logging.debug(f"Spoken word received: {spoken_word}")

    # Check if 'random words' exists in the session
    if 'random_words' not in session:
        logging.warning("There are no 'random words' in the session.")
        return jsonify({
            "correct": False,
            "message": "There are no words to process. Please load a story first.",
            "correct_count": len(session['pronounced_words']),
            "incorrect_count": len(session['incorrect_words']),
            "total": 0,
            "correct_words": session['pronounced_words'],
            "next_word": None
        })

    correct_words = session['random_words']
    pronounced_words = session['pronounced_words']
    incorrect_words = session['incorrect_words']

    logging.debug(f"Correct words: {correct_words}")
    logging.debug(f"Pronounced words: {pronounced_words}")
    logging.debug(f"Palabras incorrectas: {incorrect_words}")
    

    if not correct_words:
        logging.warning("There are no correct words to process.")
        return jsonify({
            "correct": False,
            "message": "There are no words to process.",
            "correct_count": len(pronounced_words),
            "incorrect_count": len(incorrect_words),
            "total": 0,
            "correct_words": pronounced_words,
            "next_word": None
        })

    correct_words_in_lowercase = [word.lower() for word in correct_words]
    if spoken_word in correct_words_in_lowercase:
        logging.info(f"The word '{spoken_word}' is correct.")
        if spoken_word not in pronounced_words:
            pronounced_words.append(spoken_word)
            session['pronounced_words'] = pronounced_words
            logging.debug(f"Pronounced words updated: {pronounced_words}")

        if len(pronounced_words) >= len(correct_words_in_lowercase):
            logging.info("All words have been pronounced correctly.")
            return jsonify({
                "correct": True,
                "correct_count": len(pronounced_words),
                "incorrect_count": len(incorrect_words),
                "total": len(correct_words_in_lowercase),
                "correct_words": pronounced_words,
                "next_word": None
            })

        remaining_words = set(correct_words_in_lowercase) - set(pronounced_words)
        new_word = random.choice(list(remaining_words)) if remaining_words else None
        logging.debug(f"Next word to pronounce: {new_word}")

        return jsonify({
            "correct": True,
            "correct_count": len(pronounced_words),
            "incorrect_count": len(incorrect_words),
            "total": len(correct_words_in_lowercase),
            "correct_words": pronounced_words,
            "next_word": new_word,
            "highlight_word": new_word
        })
    
    else:
        # The word is incorrect: adding it to the list of incorrect words
        logging.info(f"The word '{spoken_word}' is incorrect.")
        incorrect_words.append(spoken_word)
        session['incorrect_words'] = incorrect_words

        current_word = correct_words_in_lowercase[len(pronounced_words)] if len(pronounced_words) < len(correct_words_in_lowercase) else None
        logging.info(f"The word '{spoken_word}' is incorrect. Next word: {current_word}")

        return jsonify({
            "correct": False,
            "correct_count": len(pronounced_words),
            "incorrect_count": len(incorrect_words),
            "total": len(correct_words_in_lowercase),
            "correct_words": pronounced_words,
            "next_word": current_word
        })

@app.route('/Signup', methods=['GET', 'POST'])
def Signup():
    if request.method == 'POST':
        name = request.form['name']
        dob = request.form['dob']
        email = request.form['email']
        password = request.form['password']
        terms = request.form.get('terms')
        privacy = request.form.get('privacy')

        if not all([name, email, dob, password, terms, privacy]):
            return render_template('Signup.html', error="Please complete all the fields.")

        email_regex = r'^[\w\.-]+@[\w\.-]+\.\w+$'
        if not re.match(email_regex, email):
            return render_template('Signup.html', error="Please enter a valid email address.")

        if terms != 'on':
            return render_template('Signup.html', error="You must accept the terms and conditions.")

        # Hash password
        hashed_password = generate_password_hash(password)

        try:
            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()
            cursor.execute("""
                INSERT INTO users (name, email, dob, password, terms_accepted, privacy_accepted)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (name, email, dob, hashed_password, True, True))
            conn.commit()

        except mysql.connector.Error as err:
            logging.error(f"Error registering user: {err}")
            return render_template('Signup.html', error=f"Error registering: {err}")

        finally:
            if cursor:
                cursor.close()
            if conn and conn.is_connected():
                conn.close()

        session['username'] = name  # Guardamos el nombre en sesión

        # 🎯 Ahora sí redirige después de guardar
        return redirect(url_for('login'))

    return render_template('Signup.html')



@app.route("/")
def index():
    return render_template("index.html")

@app.route('/story/<int:story_id>')
def story(story_id):
    story_data = get_story_by_id(story_id)
    if not story_data:
        return render_template('404.html'), 404
    return render_template('story.html', story=story_data)

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form.get("email")
        password = request.form.get("password")

        if not email or not password:
            return render_template("login.html", error="Please fill in all fields.")

        try:
            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor(dictionary=True)

            # Buscar usuario por email
            cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
            user = cursor.fetchone()

            if user and check_password_hash(user['password'], password):
                # Login correcto → guardar en sesión
                session['user_email'] = user['email']
                session['user_name'] = user['name']
                return redirect(url_for("index"))
            else:
                return render_template("login.html", error="Incorrect email or password.")

        except mysql.connector.Error as err:
            logging.error(f"Login error: {err}")
            return render_template("login.html", error="Database error.")
        
        finally:
            if cursor:
                cursor.close()
            if conn and conn.is_connected():
                conn.close()

    return render_template("login.html")


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
    session.clear()  # Elimina todos los datos de la sesión
    return redirect(url_for('index'))



if __name__ == "__main__":
    app.run(debug=True, port=5001)