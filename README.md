# 📚 Learn to Read Through Play: Interactive Reading Game with Pronunciation Evaluation

**Interactive Reading for Children Using Artificial Intelligence** combines traditional storytelling with AI technologies to create a personalized reading experience in English.

It uses voice recognition to help users improve pronunciation and comprehension, adapting to each child’s skills and interests — including those with reading difficulties or disabilities.

---

## Features

- ✅ User registration  
- 🗣️ Interactive reading with AI  
- 🎙️ Emotional voice narration  

---
  
## Table of Contents

- [Technologies Used](#technologies-used)  
- [Project Structure](#project-structure)  
- [Installation](#installation)  
- [Usage](#usage)  
- [Database Structure](#database-structure)  
- [Additional Tools](#additional-tools)  
- [Contact](#contact)

---

## Technologies Used

- **Python + Flask**: Backend development and web application framework  
- **Flask `url_for()`**: Static file referencing  
- **MySQL + MySQL Workbench**: Database and admin tool  
- **HTML, CSS, JavaScript**: Frontend structure and interactivity  
- **Visual Studio Code**: Main development environment  
- **Webkit API**: Voice recognition (real-time voice-to-text)  
- **Python modules**: `re`, `json`, `logging`, etc.  
- **Jinja2**: Flask’s templating engine

---

## Project Structure

```bash
.
├── app.py                  # Main Flask application file
├── config.py
├── auth/
│   ├── __init__.py
│   └── routes.py           # Routes for /signup, /login, /verify
├── utils/                  # Helper functions (email, token generation, validators)
│   ├── __init__.py        
│   ├── email.py            # Email sending
│   └── utils.py            # Helper functions (tokens, validators)
├── requirements.txt        # List of dependencies 
├── static                  # Static files (CSS, JS, images)
│   ├── style.css           # Stylesheets 
│   ├── styles-history.css  # Stylesheets for my_history.html
│   └── tts.js              # Frontend scripts  
├── templates               # HTML templates
│   ├── base.html           # Main layout
│   ├── index.html          # Main page 
│   ├── fairy_tales.html  
│   ├── animal_fables.html
│   ├── bedtime_stories.html
│   ├── about_us.html
│   ├── story.html          # Story display with interaction
│   ├── feedback.html
│   ├── signup.html
│   ├── login.html
│   ├── privacy.html
│   ├── terms.html
│   └── 404.html            # Error page
├── tests/
│   └── test_signup.py      # Automated tests
├── README.md               # Documentation file 
└── interactive_stories.sql # SQL script to build the database
└── .env                    # Sensitive variables
```

## Installation

Steps to install and run the project:

1. Clone the repository: 
git clone https://github.com/tu_usuario/tu_repositorio.git
cd tu_repositorio

2. Create a virtual environment (optional but recommended):
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate     # Windows

3. Install dependencies:
pip install -r requirements.txt

4. Configure the database:

Create a database in MySQL and update the configuration in your application (e.g., in app.py or a configuration file).

Run the necessary SQL scripts or migrations to create tables and populate the initial data.

5. Run the application:

python app.py

Then, open the address shown in your browser, usually http://127.0.0.1:5000.

## Usage

Main Page (Index.html):

Displays the stories or the selection interface.

"Speak" Button:

When the user clicks "Speak", the first word of the story is highlighted and the microphone is enabled (using the Webkit API or the voice recognition API you have implemented).

The voice is converted to text and sent to a Flask endpoint.

The spoken word is compared with the current word in the story. If it matches, the highlighting is deactivated and it proceeds to the next word.

Adaptation and Feedback:

The system records the user's pronunciation.

Based on correct or incorrect attempts, feedback can be provided and the difficulty can be adjusted.

## Database Structure: 

Include the structure in a .sql file with the tables users, stories, keywords, progress, etc. (see interactive_stories.sql).

- **users**:  Stores information about registered users.
    Fields: id_user, name, email, dob, terms_accepted, registration_date
- **stories**: Stores the interactive stories or tales, including title, content, image, and category
    Fields: id, title, content, image, category_id
- **category**: Defines the categories for the stories (e.g., "Fables", "Classic Tales", etc.).
    Fields: id_category, name_category
- **keywords**: List of keywords associated with the stories.
    Fields: id, keyword
- **story_keywords**: Intermediate table representing the many-to-many relationship between stories and keywords.
    Fields: story_id, keyword_id
- **history**: Records the reading history of each user, including scores and reviews.
    Fields: id_history, users_id_user, stories_id, date_of_lecture, score, rating

🔗 .sql File:

To import the full schema, you can use the `interactive_stories.sql` file included in this repository.

This file contains the CREATE TABLE, INSERT INTO, and relationship statements required to start the application.

## How to Import the SQL File

### Option 1: Using MySQL Workbench

1. Open **MySQL Workbench** and connect to your server.

2. In the menu, select: **File > Open SQL Script...** and choose interactive_stories.sql.

3. The script will open in a new tab.

4. Click the ⚡ **Execute** button (or press Ctrl + Shift + Enter) to run the entire script.

5. Done! The interactive_stories database will be created with all its data.

### Option 2: Using the Command Line

1. Open your terminal or command prompt.

2. Access MySQL with your user (for example, `root`):
 ```bash
   mysql -u root -p 
```
3. Once inside MySQL, run the script with:

source ruta/al/archivo/interactive_stories.sql;

Replace path/to/interactive_stories.sql with the actual path to your .sql file on your system.

This will create the `interactive_stories` database along with all its tables and initial data.

## Additional Tools

Use of Google Colab for Audio Generation:

To accelerate the audio creation process, a notebook in Google Colab was used along with Text-to-Speech libraries (such as gTTS). These audios were generated, trimmed, and then directly integrated into the code, so that end users do not need to replicate this process. This methodology optimized development and ensured the quality of the audio files incorporated into the application.

The general steps were:

Write and run the script in Colab that converts text to audio.

Download the generated audio files.

Trim and adjust the audios as needed.

Integrate the files into the project's static/audios/ folder.

## Contact

Project developed by Silvina Carrera as part of the dissertation for the BSc Data Science and Computing degree – Birkbeck, University of London.
Author: Silvina Carrera Scholz

Email: scarre02@student.bbk.ac.uk

LinkedIn / linkedin.com/in/silvinacarrerascholz


