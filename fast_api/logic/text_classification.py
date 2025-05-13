from pipelines.text_classification import classifier_pipeline

def classify_text(text: str, candidate_labels: list) -> str:
    result = classifier_pipeline(text, candidate_labels=candidate_labels)
    return result['labels'][0]