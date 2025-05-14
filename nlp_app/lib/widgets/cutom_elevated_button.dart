import 'package:flutter/material.dart';
import 'package:nlp_app/pages/text_processing_page.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final String fileName;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TextProcessingPage(fileName: fileName),
          ),
        );
      },
      child: Text(text),
    );
  }
}
