from fastapi import FastAPI
from app.api.text_cleaning import router as text_cleaning_router

app = FastAPI()

# API'yi dahil et
app.include_router(text_cleaning_router)
