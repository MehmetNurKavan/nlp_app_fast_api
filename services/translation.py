from transformers import pipeline

translator = pipeline("translation_en_to_fr")

def translate_text(text: str) -> str:
    translation = translator(text)
    return translation[0]["translation_text"]
