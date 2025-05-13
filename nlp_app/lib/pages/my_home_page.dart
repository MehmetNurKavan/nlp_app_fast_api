import 'package:flutter/material.dart';
import 'package:nlp_app/widgets/cutom_elevated_button.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final List<Map<String, String>> operations = const [
    {"fileName": "sentiment_analysis", "text": "Duygu Analizi"},
    {"fileName": "tokenization", "text": "Tokenization"},
    {"fileName": "translation", "text": "Translation (EN ➜ FR)"},
    {"fileName": "named_entity", "text": "Varlık Tanıma (NER)"},
    {"fileName": "question_answer", "text": "Soru Cevaplama"},
    {"fileName": "summarization", "text": "Metin Özetleme"},
    {"fileName": "text_classification", "text": "Metin Sınıflandırma"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NLP App')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: operations.length,
        itemBuilder: (context, index) {
          final op = operations[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomElevatedButton(
              fileName: op['fileName']!,
              text: op['text']!,
            ),
          );
        },
      ),
    );
  }
}
