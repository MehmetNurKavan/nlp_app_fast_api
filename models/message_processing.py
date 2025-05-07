from pydantic import BaseModel
from typing import List

class TextInput(BaseModel):
    input_text: str

class TextOutput(BaseModel):
    output_text: str

class TokenizationOutput(BaseModel):
    word_tokens: List[str]
    sentence_tokens: List[str]
