import nltk
from nltk.tokenize import word_tokenize, sent_tokenize

try:
    nltk.data.find('tokenizers/punkt')
except LookupError:
    nltk.download('punkt')

def tokenize_text(text: str):
    words = word_tokenize(text)
    sentences = sent_tokenize(text)
    return {
        "word_tokens": words,
        "sentence_tokens": sentences
    }
