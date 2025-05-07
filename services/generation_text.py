from transformers import pipeline

generator = pipeline("text-generation", model="gpt2")

def generate_text(prompt: str) -> str:
    generated = generator(prompt, max_length=50, num_return_sequences=1)
    return generated[0]["generated_text"]
