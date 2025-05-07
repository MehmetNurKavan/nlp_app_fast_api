import re
import string
from textblob import TextBlob
from bs4 import BeautifulSoup

def clean_text(text: str) -> str:
    # HTML etiketlerini kaldır
    text = BeautifulSoup(text, "html.parser").get_text()

    # Yazım hatalarını düzelt
    text = str(TextBlob(text).correct())

    # Özel karakterleri kaldır
    text = re.sub(r"[^A-Za-z0-9\s]", "", text)

    # Noktalama işaretlerini kaldır
    text = text.translate(str.maketrans("", "", string.punctuation))

    # Küçük harfe çevir
    text = text.lower()

    # Fazla boşlukları kaldır
    text = " ".join(text.split())

    return text
