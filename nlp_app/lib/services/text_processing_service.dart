import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class TextProcessingService {
  Future<Map<String, dynamic>> loadJson(String fileName) async {
    final jsonString = await rootBundle.loadString(
      'assets/models/$fileName.json',
    );
    return json.decode(jsonString);
  }

  Future<String> sendText({
    required String inputText,
    required String operation,
    List<String>? candidateLabels,
    String? context,
    String? question,
  }) async {
    // Temel veri
    Map<String, dynamic> requestData = {
      "input_text": inputText,
      "operation": operation,
    };

    // Ek alanlar (operation'a göre ekleniyor)
    if (operation == "classify" && candidateLabels != null) {
      requestData["candidate_labels"] = candidateLabels;
    }

    if (operation == "aq" && context != null && question != null) {
      requestData["context"] = context;
      requestData["question"] = question;
    }

    // İstek gönderme
    final response = await http.post(
      Uri.parse("http://10.0.0.105:8000/nlp/process-text"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['output_text'];
    } else {
      throw Exception('İstek başarısız oldu: ${response.body}');
    }
  }
}
