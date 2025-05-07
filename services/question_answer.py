from transformers import pipeline

qa_pipeline = pipeline("question-answering")

def answer_question(context: str, question: str) -> str:
    result = qa_pipeline(question=question, context=context)
    return result["answer"]
