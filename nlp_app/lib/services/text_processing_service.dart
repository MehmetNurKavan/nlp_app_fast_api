import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

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
    try {
      // API URL'ini kontrol et
      final apiUrl = dotenv.env['API_URL'];
      debugPrint('🔗 API URL: $apiUrl'); // URL'i logla

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

      debugPrint('📤 Gönderilen veri: $requestData'); // İstek verisini logla

      // İstek gönderme
      final response = await http.post(
        Uri.parse('$apiUrl/nlp/process-text'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      debugPrint(
        '📥 Yanıt durumu: ${response.statusCode}',
      ); // Status code'u logla
      debugPrint('📦 Yanıt gövdesi: ${response.body}'); // Yanıt gövdesini logla

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        debugPrint(
          '🔍 Decode edilmiş veri: $data',
        ); // Decode edilmiş veriyi logla

        if (data.containsKey('output_text')) {
          final result = data['output_text'];
          debugPrint('✅ Sonuç: $result'); // Sonucu logla
          return result;
        } else {
          debugPrint('❌ API yanıtında output_text alanı bulunamadı');
          throw Exception(
            'API yanıtında output_text alanı bulunamadı: ${response.body}',
          );
        }
      } else {
        debugPrint('❌ API isteği başarısız oldu');
        throw Exception(
          'API isteği başarısız oldu. Durum kodu: ${response.statusCode}, Yanıt: ${response.body}',
        );
      }
    } catch (e) {
      debugPrint('❌ Hata oluştu: $e'); // Hataları logla
      throw Exception('İstek sırasında bir hata oluştu: $e');
    }
  }
}
