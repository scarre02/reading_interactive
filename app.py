from flask import Flask, render_template, request, jsonify
import mysql.connector
import random
import re

app = Flask(__name__)

# Configuration of the MySQL connection
db_config = {
    'host': 'localhost',     # Change according to your configuration
    'user': 'root',    # Replace 'your_user' with your MySQL username
    'password': '1234', # Replace 'your_password' with your MySQL password"
    'database': 'interactive_stories'
}
def get_cuento_by_id(id):
    # Connect to the database
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    # Select a story by id
    cursor.execute("SELECT * FROM stories WHERE id = %s", (id,))

    story = cursor.fetchone()  # Returns a row as a dictionary
    conn.close()

    # Select 5 random words from the story content
    if story:
        
        contenido = story['contenido']  # The content of the story
        palabras = contenido.split()  # Split into words
        palabras_aleatorias = random.sample(palabras, min(len(palabras), 1))  # Select up to 5 random words

        # Highlight the selected words in the content
        contenido_resaltado = contenido
        for palabra in palabras_aleatorias:
            contenido_resaltado = re.sub(rf'\b{re.escape(palabra)}\b', 
                                 f'<span class="highlight">{palabra}</span>', 
                                 contenido_resaltado, 
                                 count=1)

        return {"id": story['id'], "titulo": story['titulo'], "contenido": contenido_resaltado, "palabras": palabras_aleatorias}
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

    # Compare the spoken word with the correct words
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

@app.route("/loggin")
def loggin():
    return render_template("loggin.html")

@app.route('/story_rabbit')
def story_rabbit():
    story = get_cuento_by_id(1)
    return render_template('story_rabbit.html', story=story)

@app.route('/lion')
def lion():
    story = get_cuento_by_id(2)
    return render_template('lion.html', story=story)

@app.route('/tortoise_and_hare')
def tortoise_and_hare():
    story = get_cuento_by_id(3)
    return render_template('tortoise_and_hare.html', story=story)

@app.route('/the_brave_little_fox')
def the_brave_little_fox():
    story = get_cuento_by_id(4)
    return render_template('the_brave_little_fox.html', story=story)

@app.route('/favicon.ico')
def favicon():
    return '', 204  # 204 = No Content


if __name__ == "__main__":
    app.run(debug=True)