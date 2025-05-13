import 'package:flutter/material.dart';
import 'package:nlp_app/pages/my_home_page.dart';
import 'package:provider/provider.dart';
import 'viewmodels/text_processing_viewmodel.dart';
import 'pages/text_processing_page.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
      create: (_) => TextProcessingViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NLP App',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      routes: _routes(),
    );
  }

  Map<String, WidgetBuilder> _routes() {
    return {
      '/tokenization':
          (context) => const TextProcessingPage(fileName: 'tokenization'),
      '/sentiment':
          (context) => const TextProcessingPage(fileName: 'sentiment_analysis'),
      '/translate':
          (context) => const TextProcessingPage(fileName: 'translation'),
      '/aq': (context) => const TextProcessingPage(fileName: 'question_answer'),
      '/recognize_entities':
          (context) => const TextProcessingPage(fileName: 'named_entity'),
      '/classify':
          (context) =>
              const TextProcessingPage(fileName: 'text_classification'),
      '/summarization':
          (context) => const TextProcessingPage(fileName: 'summarization'),
    };
  }
}
