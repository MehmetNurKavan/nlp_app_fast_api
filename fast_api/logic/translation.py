from pipelines.translation import translator

def translate_text(text: str) -> str:
    translation = translator(text)
    return translation[0]["translation_text"]
