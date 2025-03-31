import os
import torch
import numpy as np
from parler_tts import ParlerTTSForConditionalGeneration
from transformers import AutoTokenizer
from pydub import AudioSegment

# 🔹 Desactivar errores y optimizar procesamiento
os.environ["FLASHATTENTION_FORCE_DISABLE"] = "1"
os.environ["TOKENIZERS_PARALLELISM"] = "false"

device = "cuda:0" if torch.cuda.is_available() else "cpu"

# 🔹 Cargar modelo y tokenizers
model = ParlerTTSForConditionalGeneration.from_pretrained("parler-tts/parler-tts-mini-multilingual").to(device)
tokenizer = AutoTokenizer.from_pretrained("parler-tts/parler-tts-mini-multilingual")
description_tokenizer = AutoTokenizer.from_pretrained(model.config.text_encoder._name_or_path)

# Imprime el sample rate definido en el modelo
print("Sample rate del modelo:", model.config.sampling_rate)

tokenizer.pad_token = tokenizer.eos_token
description_tokenizer.pad_token = description_tokenizer.eos_token

# 📝 Texto completo de la historia
prompt_text = ("The Brave Little Squirrel"
               "In a vast and ancient forest, where the trees whispered secrets to the wind, lived a little squirrel named Pip.<br>Pip was small but full of courage. He loved to climb the tallest trees and leap from branch to branch with fearless energy.<br><br>One autumn morning, as Pip was gathering acorns for the winter, he overheard a group of birds talking anxiously.<br>A great storm was coming, and it would be the fiercest the forest had seen in years.<br><br>Pip’s heart pounded. He knew that the oldest oak tree, home to many animals, stood on a hill where the winds would be strongest.<br>He had to warn them!<br><br>Without hesitation, Pip raced up the tree trunks, leaping from branch to branch, spreading the warning.<br>He told the rabbits to burrow deeper, the foxes to find shelter, and the deer to move to the denser parts of the forest.<br><br>When he reached the old oak, he found a family of owls nestled inside. They were too young to fly far.<br>Determined, Pip helped them move to a hollowed-out log near the ground, where they would be safe."
)
# --- Cortar el texto deseado ---
start_phrase = "The ant and the Grasshopper"
end_phrase = "Come, enjoy the  "
start_idx = prompt_text.find(start_phrase)
end_idx = prompt_text.find(end_phrase)
if start_idx != -1 and end_idx != -1:
    prompt_text = prompt_text[start_idx:end_idx + len(end_phrase)]
else:
    print("No se encontró alguna de las frases especificadas.")

# Usar el texto recortado como un único segmento
segments = [prompt_text]

# Contar tokens en el prompt completo
tokens = tokenizer.tokenize(prompt_text)
print("Número de tokens en el prompt:", len(tokens))

# 🎙️ Descripción de la voz – Narración apasionada y llena de intriga
description = ("A passionate and engaging female narrator who reads as if telling a magical bedtime story to her child, "
               "full of wonder, mistery and excitement. Her voice is warm, expressive, and full of dynamic inflections that captivate and intrigue.")

# 🔹 Tokenizar la descripción para mantener coherencia
desc_tokenized = description_tokenizer(description, return_tensors="pt", padding=True, truncation=True, max_length=80)
input_ids = desc_tokenized.input_ids.to(device)
attention_mask = desc_tokenized.attention_mask.to(device)

# Contar tokens en la descripción corta
desc_tokens = description_tokenizer.tokenize(description)
print("Tokens en la descripción:", len(desc_tokens))

# Contar tokens en cada segmento
for idx, segment in enumerate(segments):
    segment_tokens = tokenizer.tokenize(segment)
    print(f"Tokens en el segmento {idx+1} ('{segment[:30]}...'): {len(segment_tokens)}")

# 🔹 Generar y unir todos los segmentos con coherencia de voz
audio_clips = []

for idx, text in enumerate(segments):
    print(f"🎙️ Generando segmento {idx + 1}/{len(segments)}: {text[:50]}...")
    
    # Tokenizar el fragmento de texto
    prompt_tokenized = tokenizer(text, return_tensors="pt", padding=True, truncation=True, max_length=512, )
    prompt_input_ids = prompt_tokenized.input_ids.to(device)
    prompt_attention_mask = prompt_tokenized.attention_mask.to(device)

    # Generación de audio con la misma configuración de voz
    generation = model.generate(
        input_ids=input_ids, 
        attention_mask=attention_mask, 
        prompt_input_ids=prompt_input_ids,
        prompt_attention_mask=prompt_attention_mask,  
        max_new_tokens=800,  # Aumentado para permitir generar el audio completo
        do_sample=True,        # Permite variabilidad para enriquecer la emoción
        temperature=0.6,       # Controla la "aleatoriedad" de la generación
        num_beams=1            # Reducido para hacer la generación más rápida
    )
    # Después de la generación, justo antes de convertir el array a audio:
    print("Forma del tensor generado:", generation.shape)

    # Suponiendo que la forma es [batch_size, sequence_length] o similar,
    # toma la dimensión que representa el número de muestras.
    num_muestras = generation.shape[-1]
    sample_rate = model.config.sampling_rate
    duracion_segundos = num_muestras / sample_rate

    print("Número de muestras:", num_muestras)
    print("Sample rate:", sample_rate)
    print("Duración aproximada en segundos:", duracion_segundos)

    # 🔹 Convertir a numpy y normalizar
    audio_arr = generation.cpu().numpy().squeeze()
    audio_arr = np.clip(audio_arr, -1, 1)  

    # 🔹 Crear objeto de audio
    audio_clip = AudioSegment(
        (audio_arr * 32767).astype(np.int16).tobytes(), 
        frame_rate=model.config.sampling_rate, 
        sample_width=2, 
        channels=1
    )

    # 🔹 Agregar el clip generado a la lista
    audio_clips.append(audio_clip)

# 🔹 Unir todos los fragmentos de audio en un solo archivo
final_audio = sum(audio_clips)

# 🔹 Guardar el archivo final
final_audio.export("story1_2.mp3", format="mp3", bitrate="128k")

print("✅ ¡Audio completo generado correctamente y guardado en MP3!")
