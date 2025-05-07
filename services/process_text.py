from services.named_entity import recognize_entities
from services.sentiment_analysis import analyze_sentiment
from services.summarization import summarize_text
from services.translation import translate_text
from services.tokenization import tokenize_text

def process_text(data: str, operation: str):
    # Operation mapping: operation türüne göre doğru servisi çalıştır
    operations = {
        "sentiment": analyze_sentiment,
        "translate": translate_text,
        "tokenize": tokenize_text,
        "summarization": summarize_text,
        "recognize_entities": recognize_entities,
    }

    # Eğer operation geçerli değilse, hata döndür
    if operation not in operations:
        return "Invalid operation"

    # Operation'u çalıştır
    try:
        return operations[operation](data)
    except Exception as e:
        return f"Error during processing: {str(e)}"
