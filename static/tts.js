function generateAndPlayAudio() {
    let text = document.getElementById("text_input").value.trim();

    if (!text) {
        alert("Por favor, introduce un texto.");
        return;
    }

    fetch("/generate_audio", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ text: text })
    })
    .then(response => response.json())
    .then(data => {
        if (data.audio_url) {
            let audioPlayer = document.getElementById("audio_player");
            audioPlayer.src = data.audio_url;
            audioPlayer.play();
        } else {
            alert("Error al generar el audio.");
        }
    })
    .catch(error => console.error("Error:", error));
}
function readStory(storyId) {
    fetch(`/read_story/${storyId}`, {
        method: "GET",
        headers: {
            "Content-Type": "application/json"
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.audio_url) {
            let audioPlayer = document.getElementById("story_audio_player");
            audioPlayer.src = data.audio_url;
            audioPlayer.play();
        } else {
            alert("Error al generar el audio del cuento.");
        }
    })
    .catch(error => console.error("Error:", error));
}
