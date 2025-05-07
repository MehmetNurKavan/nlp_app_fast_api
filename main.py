from fastapi import FastAPI
from routers import text_cleaning, sentiment_analysis, tokenization

app = FastAPI(
    title="NLP FastAPI",
    description="Bu API çeşitli NLP işlemlerini sunar.",
    version="1.0.0"
)

@app.get("/")
def read_root():
    return {"message": "NLP FastAPI çalışıyor!"}

# Routers ekleniyor
app.include_router(text_cleaning.router, prefix="/text", tags=["Text Cleaning"])
app.include_router(sentiment_analysis.router, prefix="/sentiment", tags=["Sentiment Analysis"])
app.include_router(tokenization.router, prefix="/token", tags=["Tokenization"])
