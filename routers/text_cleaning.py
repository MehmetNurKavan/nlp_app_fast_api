from fastapi import APIRouter
from models.message_processing import TextInput, TextOutput
from services.text_cleaning import clean_text

router = APIRouter()

@router.post("/clean-text", response_model=TextOutput)
def clean_user_text(data: TextInput):
    cleaned = clean_text(data.text)
    return TextOutput(output_text=cleaned)
