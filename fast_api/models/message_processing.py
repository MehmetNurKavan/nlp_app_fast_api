from pydantic import BaseModel
from typing import Optional, List

class TextInput(BaseModel):
    input_text: Optional[str] = None
    context: Optional[str] = None
    question: Optional[str] = None
    operation: str
    candidate_labels: Optional[List[str]] = None

class TextOutput(BaseModel):
    output_text: str
