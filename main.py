from fastapi import FastAPI
from routers.nlp_router import router as nlp_router

app = FastAPI(
    title="NLP FastAPI",
    description="Bu API çeşitli NLP işlemlerini sunar.",
    version="1.0.0"
)

@app.get("/")
def read_root():
    return {"message": "NLP FastAPI çalışıyor!"}

# Router ekleniyor
app.include_router(nlp_router, prefix="/nlp", tags=["NLP Operations"])