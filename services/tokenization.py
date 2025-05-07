from transformers import pipeline

tokenizer_pipeline = pipeline("ner")

def tokenize_text(text: str) -> str:
    result = tokenizer_pipeline(text)
    return result
