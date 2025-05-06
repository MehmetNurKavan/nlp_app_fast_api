from fastapi import APIRouter
from app.models.text_cleaner import clean_text

router = APIRouter()

@router.post("/clean")
async def clean(text: str):
    cleaned_text = clean_text(text)
    return {"cleaned_text": cleaned_text}
