from pipelines.tokenization import tokenizer_pipeline

def tokenize_text(text: str) -> str:
    result = tokenizer_pipeline(text)
    return [token['word'] for token in result]