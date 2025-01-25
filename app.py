from flask import Flask, render_template, request, jsonify, session, redirect, url_for
import mysql.connector
import random
import re
import json  # Para manejar JSON en Python
import logging

app = Flask(__name__)
app.secret_key = 'your_secret_key'

# Configuración de la conexión MySQL
db_config = {
    'host': 'localhost',     # Cambia según tu configuración
    'user': 'root',          # Cambia según tu usuario de MySQL
    'password': '1234',      # Cambia según tu contraseña de MySQL
    'database': 'interactive_stories'
}

# Configurar logging
logging.basicConfig(level=logging.DEBUG)

def get_cuento_by_id(id):
    conn = None
    cursor = None
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)

        # Seleccionar un cuento por ID
        cursor.execute("SELECT * FROM stories WHERE id = %s", (id,))
        story = cursor.fetchone()
        if not story:
            logging.warning(f"Story with ID {id} not found.")
            return None

        # Obtener las palabras clave asociadas
        cursor.execute('''
            SELECT k.keyword
            FROM keywords k
            JOIN story_keywords sk ON k.id = sk.keyword_id
            WHERE sk.story_id = %s
        ''', (id,))
        keywords = [row['keyword'] for row in cursor.fetchall()]

        # No resaltar palabras clave en el contenido inicialmente
        content = story['content']
        contenido_resaltado = content
        # Envolver cada palabra clave con un span único
        for index, palabra in enumerate(keywords):
            contenido_resaltado = re.sub(
                rf'\b{re.escape(palabra)}\b',
                f'<span class="keyword" data-index="{index}">{palabra}</span>',
                contenido_resaltado,
                flags=re.IGNORECASE
            )

        # Guardar palabras en la sesión
        session['palabras_aleatorias'] = keywords
        if 'palabras_pronunciadas' not in session:
            session['palabras_pronunciadas'] = []  # Inicializar como vacío

        return {
            "id": story['id'],
            "title": story['title'],
            "image": story['image'],
            "content": contenido_resaltado,
            "palabras": keywords if keywords else []
        }
    except mysql.connector.Error as err:
        logging.error(f"Error al conectar a la base de datos: {err}")
        return None
    finally:
        if cursor:
            cursor.close()
        if conn and conn.is_connected():
            conn.close()

@app.route("/process_speech", methods=["POST"])
def process_speech():
    # Inicializar variables de sesión si no existen
    if 'palabras_pronunciadas' not in session:
        session['palabras_pronunciadas'] = []

    data = request.get_json()
    spoken_word = re.sub(r'[^a-zA-ZáéíóúüñÑ\s]', '', data.get("word", "").strip().lower())

    logging.debug(f"Palabra hablada recibida: {spoken_word}")

    # Verificar si 'palabras_aleatorias' existe en la sesión
    if 'palabras_aleatorias' not in session:
        logging.warning("No hay 'palabras_aleatorias' en la sesión.")
        return jsonify({
            "correct": False,
            "message": "No hay palabras para procesar. Por favor, carga una historia primero.",
            "correct_count": len(session['palabras_pronunciadas']),
            "total": 0,
            "correct_words": session['palabras_pronunciadas'],
            "next_word": None
        })

    palabras_correctas = session['palabras_aleatorias']
    palabras_pronunciadas = session['palabras_pronunciadas']

    logging.debug(f"Palabras correctas: {palabras_correctas}")
    logging.debug(f"Palabras pronunciadas: {palabras_pronunciadas}")

    if not palabras_correctas:
        logging.warning("No hay palabras correctas para procesar.")
        return jsonify({
            "correct": False,
            "message": "No hay palabras para procesar",
            "correct_count": len(palabras_pronunciadas),
            "total": 0,
            "correct_words": palabras_pronunciadas,
            "next_word": None
        })

    palabras_correctas_lower = [palabra.lower() for palabra in palabras_correctas]
    if spoken_word in palabras_correctas_lower:
        logging.info(f"La palabra '{spoken_word}' es correcta.")
        if spoken_word not in palabras_pronunciadas:
            palabras_pronunciadas.append(spoken_word)
            session['palabras_pronunciadas'] = palabras_pronunciadas
            logging.debug(f"Palabras pronunciadas actualizadas: {palabras_pronunciadas}")

        if len(palabras_pronunciadas) >= len(palabras_correctas_lower):
            logging.info("Se han pronunciado todas las palabras correctamente.")
            return jsonify({
                "correct": True,
                "correct_count": len(palabras_pronunciadas),
                "total": len(palabras_correctas_lower),
                "correct_words": palabras_pronunciadas,
                "next_word": None
            })

        restantes = set(palabras_correctas_lower) - set(palabras_pronunciadas)
        nueva_palabra = random.choice(list(restantes)) if restantes else None
        logging.debug(f"Siguiente palabra a pronunciar: {nueva_palabra}")

        return jsonify({
            "correct": True,
            "correct_count": len(palabras_pronunciadas),
            "total": len(palabras_correctas_lower),
            "correct_words": palabras_pronunciadas,
            "next_word": nueva_palabra,
            "highlight_word": nueva_palabra
        })

    current_word = palabras_correctas_lower[len(palabras_pronunciadas)] if len(palabras_pronunciadas) < len(palabras_correctas_lower) else None
    logging.info(f"La palabra '{spoken_word}' es incorrecta. Siguiente palabra: {current_word}")

    return jsonify({
        "correct": False,
        "correct_count": len(palabras_pronunciadas),
        "total": len(palabras_correctas_lower),
        "correct_words": palabras_pronunciadas,
        "next_word": current_word
    })

@app.route('/Signup', methods=['GET', 'POST'])
def Signup():
    if request.method == 'POST':
        name = request.form.get('name')
        email = request.form.get('email')
        dob = request.form.get('dob')
        terms = request.form.get('terms')

        if not all([name, email, dob, terms]):
            return render_template('Signup.html', error="Por favor completa todos los campos.")

        email_regex = r'^[\w\.-]+@[\w\.-]+\.\w+$'
        if not re.match(email_regex, email):
            return render_template('Signup.html', error="Por favor, ingresa un correo electrónico válido.")

        if terms != 'on':
            return render_template('Signup.html', error="Debes aceptar los términos y condiciones.")

        try:
            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()
            cursor.execute("""
                INSERT INTO users (name, email, dob, terms_accepted)
                VALUES (%s, %s, %s, %s)
            """, (name, email, dob, True))
            conn.commit()
        except mysql.connector.Error as err:
            logging.error(f"Error al registrar usuario: {err}")
            return render_template('Signup.html', error=f"Error al registrar: {err}")
        finally:
            if cursor:
                cursor.close()
            if conn and conn.is_connected():
                conn.close()

        return redirect(url_for('index'))
    return render_template('Signup.html')

# Ruta dinámica para manejar todas las historias
@app.route('/story/<int:story_id>')
def story_detail(story_id):
    story = get_cuento_by_id(story_id)
    if not story:
        return render_template('404.html'), 404  # Asegúrate de tener una plantilla 404.html amigable
    return render_template('story.html', story=story)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/login")
def login():
    return render_template("login.html")

@app.route('/fairy_tales')
def fairy_tales():
    return render_template('fairy_tales.html')

@app.route('/animal_fables')
def animal_fables():
    return render_template('animal_fables.html')

@app.route('/stories_to_spark_the_imagination')
def stories_to_spark_the_imagination():
    return render_template('stories_to_spark_the_imagination.html')

@app.route('/page4')
def page4():
    return render_template('page4.html')



@app.route('/story/<int:story_id>')
def story(story_id):
    story_data = get_cuento_by_id(story_id)
    if not story_data:
        return render_template('404.html'), 404
    return render_template('story.html', story=story_data)



if __name__ == "__main__":
    app.run(debug=True, port=5001)
