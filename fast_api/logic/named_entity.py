from pipelines.named_entity import ner_tagger

def recognize_entities(text: str):
    entities = ner_tagger(text)
    return entities
