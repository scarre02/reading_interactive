document.addEventListener("DOMContentLoaded", () => {
    const currentWordDisplay = document.getElementById("current-word");
    const correctCountDisplay = document.getElementById("correct-count");
    const correctWordsList = document.getElementById("correct-words-list");
    const recognizedWordDisplay = document.getElementById("recognized-word");

    let currentWord = "";
    let recognition;

    const startRecognition = () => {
        if (!("webkitSpeechRecognition" in window)) {
            alert("Speech Recognition API not supported in this browser.");
            return;
        }

        recognition = new webkitSpeechRecognition();
        recognition.lang = "en-US";
        recognition.interimResults = false;
        recognition.maxAlternatives = 1;

        recognition.onresult = (event) => {
            const spokenWord = event.results[0][0].transcript.toLowerCase();
            recognizedWordDisplay.textContent = `You said: ${spokenWord}`;
            sendWordToServer(spokenWord);
        };

        recognition.onerror = (event) => {
            alert("Error occurred in speech recognition: " + event.error);
        };

        recognition.start();
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
                        currentWordDisplay.textContent = "Congratulations! You've completed all the words!";
                    }
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
                alert("Something went wrong. Please try again.");
            });
    };

    document.getElementById("start-recognition").addEventListener("click", () => {
        startRecognition();
    });

    fetch("/process_speech", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({ word: "" }), // Inicializa el juego
    })
        .then((response) => response.json())
        .then((data) => {
            currentWord = data.next_word || "Start speaking to begin!";
            currentWordDisplay.textContent = currentWord;
        });
});
