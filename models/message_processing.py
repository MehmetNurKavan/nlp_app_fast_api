from pydantic import BaseModel

class TextInput(BaseModel):
    input_text: str
    operation: str

class TextOutput(BaseModel):
    output_text: str
