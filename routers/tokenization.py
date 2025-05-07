from fastapi import APIRouter, HTTPException
from models.message_processing import TextInput, TokenizationOutput
from services.tokenization import tokenize_text

router = APIRouter()

@router.post("/tokenize", response_model = TokenizationOutput)
def tokenize_endpoint(data: TextInput):
    try:
        result = tokenize_text(data.input_text)
        return result  # {"word_tokens": [...], "sentence_tokens": [...]}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
