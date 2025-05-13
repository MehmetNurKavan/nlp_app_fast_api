from pipelines.question_answer import qa_pipeline

def answer_question(context: str, question: str) -> str:
    result = qa_pipeline(question=question, context=context)
    return result["answer"]
