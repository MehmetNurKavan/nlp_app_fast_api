from fastapi import APIRouter, HTTPException
from models.message_processing import TextInput, TextOutput
from services.processor import process_text

router = APIRouter()

@router.post("/process-text", response_model=TextOutput)
def process_text_request(data: TextInput):
    try:
        # process_text fonksiyonunu kullanarak sonucu al
        result = process_text(data)

        if result == "Invalid operation":
            raise HTTPException(status_code=400, detail="Geçersiz işlem türü")

        return TextOutput(output_text=str(result))

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
