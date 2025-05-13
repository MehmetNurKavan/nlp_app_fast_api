from models.message_processing import TextInput
from logic.named_entity import recognize_entities
from logic.question_answer import answer_question
from logic.sentiment_analysis import analyze_sentiment
from logic.summarization import summarize_text
from logic.text_classification import classify_text
from logic.tokenization import tokenize_text
from logic.translation import translate_text

def process_text(request: TextInput):
    operation = request.operation

    try:
        if operation == "classify":
            return classify_text(request.input_text, request.candidate_labels)
        elif operation == "aq":
            return answer_question(request.context, request.question)
        elif operation == "sentiment":
            return analyze_sentiment(request.input_text)
        elif operation == "tokenize":
            return tokenize_text(request.input_text)
        elif operation == "summarization":
            return summarize_text(request.input_text)
        elif operation == "recognize_entities":
            return recognize_entities(request.input_text)
        elif operation == "translate":
            return translate_text(request.input_text)
        else:
            return "Invalid operation"
    except Exception as e:
        return  f"Error during processing: {str(e)}"
