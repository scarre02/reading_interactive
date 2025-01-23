from flask import Flask, render_template, request, jsonify, session, redirect, url_for
import mysql.connector
import Error
import random
import re
import json  # To handle JSON in Python

app = Flask(__name__)
app.secret_key = 'your_secret_key'

# Configuration of the MySQL connection
db_config = {
    'host': 'localhost',     # Change according to your configuration
    'user': 'root',          # Replace with your MySQL username
    'password': '1234',      # Replace with your MySQL password
    'database': 'interactive_stories'
}

def get_cuento_by_id(id):
    # Connect to the database
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)

        # Select a story by id, including the field `keywords`
        cursor.execute("SELECT * FROM stories WHERE id = %s", (id,))
        story = cursor.fetchone()  # Returns a row as a dictionary
        if not story:
            return None  # If the story is not found, return None

        # Retrieve the keywords associated with the story
        cursor.execute('''
            SELECT k.keyword
            FROM keywords k
            JOIN story_keywords sk ON k.id = sk.keyword_id
            WHERE sk.story_id = %s
        ''', (id,))
        keywords = cursor.fetchall()

        # Extract the keywords from the query results
        keywords = [keyword['keyword'] for keyword in keywords]

        # Highlight the keywords in the content
        content = story['content']
        contenido_resaltado = content
        for palabra in keywords:
            contenido_resaltado = re.sub(
                rf'\b{re.escape(palabra)}\b',
                f'<span class="highlight">{palabra}</span>',
                contenido_resaltado,
            )

        # Save the keywords in the session
        session['palabras_aleatorias'] = keywords
        session['palabras_pronunciadas'] = []  # Initialize as empty

        # Return the story with the keywords
        return {
            "id": story['id'],
            "title": story['title'],
            "content": contenido_resaltado,
            "palabras": keywords if keywords else []
        }

    except mysql.connector.Error as err:
        print(f"Error al conectar a la base de datos: {err}")
        return None
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

@app.route("/process_speech", methods=["POST"])
def process_speech():
    data = request.get_json()
    spoken_word = re.sub(r'[^a-zA-ZáéíóúüñÑ\s]', '', data.get("word", "").strip().lower())

    # Recuperar las palabras aleatorias y las ya pronunciadas desde la sesión
    palabras_correctas = session.get('palabras_aleatorias', [])
    palabras_pronunciadas = session.get('palabras_pronunciadas', [])

    # Si no hay palabras aleatorias, inicializamos el juego
    if not palabras_correctas:
        return jsonify({
            "correct": False,
            "message": "No hay palabras para procesar",
            "correct_count": len(palabras_pronunciadas),
            "total": 5,
            "correct_words": palabras_pronunciadas,
            "next_word": None
        })

    # Si la palabra dicha es correcta y no ha sido dicha antes
    if any(re.sub(r'[^a-zA-ZáéíóúüñÑ\s]', '', spoken_word) == palabra.lower() for palabra in palabras_correctas):
        palabras_pronunciadas.append(spoken_word)
        session['palabras_pronunciadas'] = palabras_pronunciadas

        # Si ya se han completado las 5 palabras correctas
        if len(palabras_pronunciadas) >= 5:
            return jsonify({
                "correct": True,
                "correct_count": len(palabras_pronunciadas),
                "total": 5,
                "correct_words": palabras_pronunciadas,
                "next_word": None  # Juego completado
            })

        # Seleccionar una nueva palabra aleatoria que no haya sido usada
        restantes = set(palabras_correctas) - set(palabras_pronunciadas)
        nueva_palabra = random.choice(list(restantes)) if restantes else None

        return jsonify({
            "correct": True,
            "correct_count": len(palabras_pronunciadas),
            "total": 5,
            "correct_words": palabras_pronunciadas,
            "next_word": nueva_palabra
        })

    # Si la palabra es incorrecta
    # Para mantener la palabra actual, puedes definir current_word como la palabra que el usuario debería decir
    # Aquí, supongo que es la última palabra correcta pronunciada o alguna lógica similar
    current_word = palabras_correctas[len(palabras_pronunciadas)] if len(palabras_pronunciadas) < len(palabras_correctas) else None

    return jsonify({
        "correct": False,
        "correct_count": len(palabras_pronunciadas),
        "total": 5,
        "correct_words": palabras_pronunciadas,
        "next_word": current_word  # Mantén la palabra actual
    })

@app.route('/story_rabbit')
def story_rabbit():
    story = get_cuento_by_id(1)  # This ID is the one we're looking for
    if not story:
        return "Story not found", 404
    return render_template('story_rabbit.html', story=story)

@app.route('/Signup', methods=['GET', 'POST'])
def Signup():
    if request.method == 'POST':
        name = request.form.get('name')
        email = request.form.get('email')
        dob = request.form.get('dob')
        terms = request.form.get('terms')

        # Validaciones básicas
        if not all([name, email, dob, terms]):
            # Manejar el error, por ejemplo, redirigir con un mensaje
            return render_template('Signup.html', error="Por favor completa todos los campos.")

        # Validar formato del email
        email_regex = r'^[\w\.-]+@[\w\.-]+\.\w+$'
        if not re.match(email_regex, email):
            error_message = "Por favor, ingresa un correo electrónico válido."
            return render_template('Signup.html', error=error_message)

        # Validar términos aceptados
        if terms != 'on':
            error_message = "Debes aceptar los términos y condiciones."
            return render_template('Signup.html', error=error_message)

        # Guardar los datos en la base de datos
        try:
            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()
            cursor.execute("""
                INSERT INTO users (name, email, dob, terms_accepted)
                VALUES (%s, %s, %s, %s)
            """, (name, email, dob, True))
            conn.commit()
            cursor.close()
            conn.close()
            # Redirigir al usuario después del registro exitoso
            return redirect(url_for('index'))
        except mysql.connector.Error as err:
            # Manejar el error, por ejemplo, mostrar un mensaje
            return render_template('Signup.html', error=f"Error al registrar: {err}")

    return render_template('Signup.html')

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/home")
def home():
    return render_template("home.html")
    
@app.route('/animal_fables')
def animal_fables():
    return render_template('animal_fables.html')

@app.route('/fairy_tales')
def fairy_tales():
    return render_template('fairy_tales.html')

@app.route('/stories_to_spark_the_imagination')
def stories_to_spark_the_imagination():
    return render_template('stories_to_spark_the_imagination.html')

@app.route('/page4')
def page4():
    return render_template('page4.html')

@app.route("/login")
def login():
    return render_template("login.html")

@app.route('/lion')
def lion():
    story = get_cuento_by_id(2)
    if not story:
        return "Story not found", 404
    return render_template('lion.html', story=story)

@app.route('/tortoise_and_hare')
def tortoise_and_hare():
    story = get_cuento_by_id(3)
    if not story:
        return "Story not found", 404
    return render_template('tortoise_and_hare.html', story=story)

@app.route('/the_brave_little_fox')
def the_brave_little_fox():
    story = get_cuento_by_id(4)
    if not story:
        return "Story not found", 404
    return render_template('the_brave_little_fox.html', story=story)

@app.route('/the_lion_and_the_mouse')
def the_lion_and_the_mouse():
    story = get_cuento_by_id(5)
    if not story:
        return "Story not found", 404
    return render_template('the_lion_and_the_mouse.html', story=story)

@app.route('/the_shepherd_and_the_wolf')
def the_shepherd_and_the_wolf():
    story = get_cuento_by_id(6)
    if not story:
        return "Story not found", 404
    return render_template('the_shepherd_and_the_wolf.html', story=story)
    
@app.route('/favicon.ico')
def favicon():
    return '', 204  # 204 = No Content

@app.route('/api/story/<int:id>')
def api_story(id):
    story = get_cuento_by_id(id)
    if not story:
        return jsonify({"error": "Story not found"}), 404

    return jsonify(story)

if __name__ == "__main__":
    app.run(debug=True, port=5001)
