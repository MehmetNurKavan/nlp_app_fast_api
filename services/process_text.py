from services.generation_text import generate_text
from services.named_entity import recognize_entities
from services.question_answer import answer_question
from services.sentiment_analysis import analyze_sentiment
from services.summarization import summarize_text
from services.translation import translate_text
from services.tokenization import tokenize_text
from services.text_classification import classify_text

def process_text(data: str, operation: str):
    # Operation mapping: operation türüne göre doğru servisi çalıştır
    operations = {
        "sentiment": analyze_sentiment,
        "qa": lambda data: answer_question(*data.split('\n', 1)),  # context ve question
        "translate": translate_text,
        "tokenize": tokenize_text,
        "generation": generate_text,
        "summarization": summarize_text,
        "recognize_entities": recognize_entities,
        "classify": lambda data: classify_text(data, candidate_labels=["sports", "politics", "economics", "entertainment"])
    }

    # Eğer operation geçerli değilse, hata döndür
    if operation not in operations:
        return "Invalid operation"

    # Operation'u çalıştır
    try:
        return operations[operation](data)
    except Exception as e:
        return f"Error during processing: {str(e)}"
