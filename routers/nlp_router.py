from fastapi import APIRouter, HTTPException
from models.message_processing import TextInput, TextOutput
from services.generation_text import generate_text
from services.question_answer import answer_question
from services.sentiment_analysis import analyze_sentiment
from services.summarization import summarize_text
from services.tokenization import tokenize_text
from services.text_classification import classify_text
from services.named_entity import recognize_entities
from services.translation import translate_text
from services.process_text import process_text  # process_text fonksiyonu burada olacak

router = APIRouter()

@router.post("/process-text", response_model=TextOutput)
def process_text_request(data: TextInput):
    try:
        # process_text fonksiyonunu kullanarak sonucu al
        result = process_text(data.input_text, data.operation)

        if result == "Invalid operation":
            raise HTTPException(status_code=400, detail="Geçersiz işlem türü")

        return TextOutput(output_text=str(result))

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
