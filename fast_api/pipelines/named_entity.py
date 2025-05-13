from transformers import pipeline

ner_tagger = pipeline("ner", aggregation_strategy="simple")