from pipelines.sentiment_analysis import classifier

def analyze_sentiment(text: str) -> str:
    result = classifier(text)
    sentiment = result[0]["label"]
    return sentiment
