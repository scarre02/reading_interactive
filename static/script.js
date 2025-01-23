document.addEventListener("DOMContentLoaded", () => {
    /* -------------------- Funcionalidad Existente de Reconocimiento de Voz -------------------- */
    const currentWordDisplay = document.getElementById("current-word");
    const correctCountDisplay = document.getElementById("correct-count");
    const correctWordsList = document.getElementById("correct-words-list");
    const recognizedWordDisplay = document.getElementById("recognized-word");

    let currentWord = "";
    let recognition;
    
    const startRecognition = () => {
        console.log("startRecognition() ha sido llamada."); // Debugging log
        if (!("webkitSpeechRecognition" in window)) {
            alert("Speech Recognition API no es compatible en este navegador.");
            return;
        }
    
        recognition = new webkitSpeechRecognition();
        recognition.lang = "es-ES"; // Configurado para español
        recognition.interimResults = false;
        recognition.maxAlternatives = 1;
    
        recognition.onresult = (event) => {
            const spokenWord = event.results[0][0].transcript.toLowerCase();
            console.log("Palabra reconocida:", spokenWord); // Debugging log
            recognizedWordDisplay.textContent = `Dijiste: ${spokenWord}`;
            sendWordToServer(spokenWord);
        };
    
        recognition.onerror = (event) => {
            console.error("Error en el reconocimiento de voz:", event.error); // Debugging log
            alert("Error en el reconocimiento de voz: " + event.error);
            restartRecognition();
        };
    
        recognition.onend = () => {
            console.log("El reconocimiento de voz ha terminado."); // Debugging log
            if (currentWord) restartRecognition();
        };
    
        recognition.start();
        console.log("Reconocimiento de voz iniciado."); // Debugging log
    };
    
    const restartRecognition = () => {
        if (recognition) recognition.start();
    };

    const sendWordToServer = (spokenWord) => {
        fetch("/process_speech", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ word: spokenWord }),
        })
            .then((response) => response.json())
            .then((data) => {
                if (data.correct) {
                    if (data.next_word) {
                        currentWord = data.next_word;
                        currentWordDisplay.textContent = currentWord;
                    } else {
                        currentWordDisplay.textContent = "¡Felicitaciones! Has completado todas las palabras.";
                        if (recognition) recognition.stop();
                    }
                } else {
                    recognizedWordDisplay.textContent = `Incorrecto: intenta decir "${currentWord}" nuevamente.`;
                }

                correctCountDisplay.textContent = data.correct_count;
                correctWordsList.innerHTML = "";
                data.correct_words.forEach((word) => {
                    const li = document.createElement("li");
                    li.textContent = word;
                    correctWordsList.appendChild(li);
                });
            })
            .catch((error) => {
                console.error("Error:", error);
                alert("Ocurrió un problema. Intenta nuevamente.");
            });
    };

    const startRecognitionButton = document.getElementById("start-recognition");
    if (startRecognitionButton) {
        startRecognitionButton.addEventListener("click", () => {
            console.log("Botón 'Iniciar reconocimiento' presionado."); // Debugging log
            startRecognition();
        });
    }
    

    // Inicializa el juego
    fetch("/process_speech", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({ word: "" }),
    })
        .then((response) => response.json())
        .then((data) => {
            currentWord = data.next_word || "¡Empieza a hablar para comenzar!";
            currentWordDisplay.textContent = currentWord;
        });

    
});
