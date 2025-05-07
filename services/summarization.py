from transformers import pipeline

summarizer = pipeline("summarization")

def summarize_text(text: str) -> str:
    summary = summarizer(text)
    return summary[0]["summary_text"]
