# Learn to Read Through Play: Interactive Reading Game with Pronunciation Evaluation

Interactive Reading for Children Using Artificial Intelligence combines traditional storytelling with artificial intelligence technologies to create a personalized reading experience in English. It uses voice recognition to help users improve pronunciation and comprehension, adapting to each child’s skills and interests, including those with reading difficulties or disabilities.
The following have been completed so far:
  The initial design of the user interface
  The needs analysis phase
  The development of a prototype
There are still technical and design challenges to be addressed, such as content personalization, real-time interaction optimization, data collection, and implementing a feedback system.

# Features

  User registration
  
  Interactive reading with AI
  
  Emotional voice narration  
  
# Table of Contents
  
  Technologies Used
  
  Project Structure
  
  Installation
  
  Usage
  
  Database Structure
  
  Contributions
  
  License
  
  Contact

# Technologies Used:

  Python and Flask: For backend development and building the web application.
  
  Flask (url_for): To correctly reference static files (CSS, JS, images, etc.) within the application.
  
  MySQL and MySQL Workbench: Relational database and its design/administration tool.
  
  HTML, CSS, and JavaScript: For the structure, styling, and functionality of the frontend.
  
  Visual Studio Code: Main development environment.
  
  Webkit API: Used for speech recognition and real-time voice-to-text conversion.
  
  Standard Python modules and libraries: Such as re, json, logging, among others.
  
  Jinja2: Flask’s templating engine for generating dynamic content in the views.

# Project Structure

The structure may vary depending on your needs, but an example could be:

.
├── app.py                  # Main Flask application file  
├── requirements.txt        # List of dependencies 
├── static
│   ├── style.css           # Stylesheets 
│   │         
│   └── tts.js              # Frontend scripts  
│       
├── templates
│   ├── base.html           
│   ├── index.html          # Main page 
│   ├── fairy_tales.html  
│   ├── animal_fables.html
│   ├── bedtime_stories.html
│   ├── about_us.html
│   ├── story.html
│   ├── feedback.html
│   ├── Signup.html
│   ├── login.html
│   ├── privacy.html
│   ├── terms.html
│   └── 404.html
│ 
├── README.md               # Documentation file 
└── interactive_stories.sql

# Installation

Steps to install and run the project:

Clone the repository:
git clone https://github.com/tu_usuario/tu_repositorio.git
cd tu_repositorio
Create a virtual environment (optional but recommended):
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate     # Windows
Install dependencies:
pip install -r requirements.txt
Configure the database:

Create a database in MySQL and update the configuration in your application (e.g., in app.py or a configuration file).

Run the necessary SQL scripts or migrations to create tables and populate the initial data.

Run the application:
python app.py
Then, open the address shown in your browser, usually http://127.0.0.1:5000.

# Usage**  

Main Page (Index):

Displays the stories or the selection interface.

"Speak" Button:

When the user clicks "Speak", the first word of the story is highlighted and the microphone is enabled (using the Webkit API or the voice recognition API you have implemented).

The voice is converted to text and sent to a Flask endpoint.

The spoken word is compared with the current word in the story. If it matches, the highlighting is deactivated and it proceeds to the next word.

Adaptation and Feedback:

The system records the user's pronunciation.

Based on correct or incorrect attempts, feedback can be provided and the difficulty can be adjusted.

# Database Structure: 

category

  id_category
  
  name_category

keywords

  id
  
  keyword

stories

  id
  
  title
  
  content
  
  image
  
  category_id

story_keywords

  story_id
  
  keyword_id

users

  id
  
  name
  
  dob
  
  terms_accepted
  
  registration_date
  
  password

# Additional Tools

Use of Google Colab for Audio Generation:

To accelerate the audio creation process, a notebook in Google Colab was used along with Text-to-Speech libraries (such as gTTS). These audios were generated, trimmed, and then directly integrated into the code, so that end users do not need to replicate this process. This methodology optimized development and ensured the quality of the audio files incorporated into the application.

The general steps were:

Write and run the script in Colab that converts text to audio.

Download the generated audio files.

Trim and adjust the audios as needed.

Integrate the files into the project's static/audios/ folder.

# Contact

Autor(a): Silvina Carrera Scholz

Correo: scarre02@student.bbk.ac.uk

LinkedIn / linkedin.com/in/silvinacarrerascholz


