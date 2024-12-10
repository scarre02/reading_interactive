from flask import Flask, render_template, request, jsonify
import mysql.connector
import random

app = Flask(__name__)

# Configuración de la conexión a MySQL
db_config = {
    'host': 'localhost',     # Cambia según tu configuración
    'user': 'root',    # Cambia 'tu_usuario' por tu usuario MySQL
    'password': '1234', # Cambia 'tu_contraseña' por tu contraseña MySQL
    'database': 'cuentos_interactivos'
}
def get_cuento_by_id(id):
    # Conectar a la base de datos
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    # Seleccionar un cuento by id
    cursor.execute("SELECT * FROM cuentos WHERE id = %s", (id,))

    cuento = cursor.fetchone()  # Devuelve una fila como diccionario
    conn.close()

    # Seleccionar 5 palabras aleatorias del contenido del cuento
    if cuento:
        contenido = cuento['contenido']  # El contenido del cuento
        palabras = contenido.split()  # Dividir en palabras
        palabras_aleatorias = random.sample(palabras, min(len(palabras), 1))  # Seleccionar hasta 5 palabras

        # Resaltar las palabras seleccionadas en el contenido
        contenido_resaltado = contenido
        for palabra in palabras_aleatorias:
            contenido_resaltado = contenido_resaltado.replace(
                palabra, f'<span class="highlight">{palabra}</span>', 1
            )

        return {"id": cuento['id'], "titulo": cuento['titulo'], "contenido": contenido_resaltado, "palabras": palabras_aleatorias}
    return None


@app.route("/")
def index():
    return render_template("index.html")

@app.route("/home")
def home():
    return render_template("home.html")

@app.route("/process_speech", methods=["POST"])
def process_speech():
    data = request.get_json()
    spoken_word = data.get("word", "").strip().lower()
    palabras_correctas = data.get("correct_words", [])

    # Compara la palabra pronunciada con las palabras correctas
    if spoken_word in palabras_correctas:
        return jsonify({"correct": True})
    else:
        return jsonify({"correct": False})

@app.route('/Signup')
def Signup():
    return render_template('Signup.html')
    
@app.route('/page1')
def page1():
    return render_template('page1.html')

@app.route('/page2')
def page2():
    return render_template('page2.html')

@app.route('/page3')
def page3():
    return render_template('page3.html')

@app.route('/page4')
def page4():
    return render_template('page4.html')

@app.route('/story_rabbit')
def story_rabbit():
    cuento = get_cuento_by_id(1)
    return render_template('story_rabbit.html', cuento=cuento)

@app.route('/lion')
def lion():
    cuento = get_cuento_by_id(2)
    return render_template('lion.html', cuento=cuento)

@app.route('/tortoise_and_hare')
def tortoise_and_hare():
    cuento = get_cuento_by_id(3)
    return render_template('tortoise_and_hare.html', cuento=cuento)


if __name__ == "__main__":
    app.run(debug=True)