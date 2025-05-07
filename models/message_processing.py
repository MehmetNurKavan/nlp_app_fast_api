from pydantic import BaseModel
from typing import List

class TextInput(BaseModel):
    input_text: str
    operation: str

class TextOutput(BaseModel):
    output_text: str
