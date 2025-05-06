import string
import re
from textblob import TextBlob

def clean_text(text: str) -> str:
    # 1. Fazla boşlukları temizle
    text = " ".join(text.split())
    
    # 2. Büyük harfleri küçük harflere çevir
    text = text.lower()
    
    # 3. Noktalama işaretlerini kaldır
    text = text.translate(str.maketrans("", "", string.punctuation))
    
    # 4. Özel karakterleri kaldır
    text = re.sub(r"[^A-Za-z0-9\s]", "", text)
    
    # 5. Yazım hatalarını düzelt
    text = str(TextBlob(text).correct())
    
    return text
