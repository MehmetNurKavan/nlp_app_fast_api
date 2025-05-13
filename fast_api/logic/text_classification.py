from pipelines.text_classification import classifier_pipeline

def classify_text(text: str, candidate_labels: list) -> str:
    print(f"Received text: {text}")
    print(f"Received candidate_labels: {candidate_labels}")
    result = classifier_pipeline(text, candidate_labels=candidate_labels)
    return result['labels'][0]
