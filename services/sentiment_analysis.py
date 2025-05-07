from transformers import pipeline

# Duygu analizi pipeline'ını yükle
classifier = pipeline("sentiment-analysis")

def analyze_sentiment(text: str) -> str:
    result = classifier(text)
    sentiment = result[0]["label"]
    return sentiment
