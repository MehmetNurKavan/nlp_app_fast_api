from transformers import pipeline

ner_tagger = pipeline("ner", aggregation_strategy="simple")

def recognize_entities(text: str):
    entities = ner_tagger(text)
    return entities
