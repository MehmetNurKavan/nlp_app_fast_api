from fastapi import APIRouter
from models.message_processing import TextInput, TextOutput
from services.text_cleaning import clean_text
from services.sentiment_analysis import analyze_sentiment

router = APIRouter()

@router.post("/sentiment-analysis", response_model=TextOutput)
def analyze_user_sentiment(data: TextInput):
    # Metni temizle
    cleaned_text = clean_text(data.input_text)
    
    # Duygu analizini yap
    sentiment = analyze_sentiment(cleaned_text)
    
    # Sonuç olarak "positive" veya "negative" döndürüyoruz
    return TextOutput(output_text=sentiment)
