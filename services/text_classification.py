from transformers import pipeline

classifier_pipeline = pipeline("zero-shot-classification")

def classify_text(text: str, candidate_labels: list) -> str:
    result = classifier_pipeline(text, candidate_labels=candidate_labels)
    return result['labels'][0]  # En yüksek olasılıkta olan sınıf
