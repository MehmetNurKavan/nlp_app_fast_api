import 'package:flutter/material.dart';
import 'package:nlp_app/models/text_processing_models.dart'
    show TextProcessingModel;
import 'package:nlp_app/services/text_processing_service.dart';

class TextProcessingViewModel extends ChangeNotifier {
  final _service = TextProcessingService();

  TextProcessingModel? _model;
  String _result = '';
  bool _loading = false;
  String _error = '';

  TextProcessingModel? get model => _model;
  String get result => _result;
  bool get isLoading => _loading;
  String get error => _error;

  Future<void> loadModelData(String fileName) async {
    try {
      final data = await _service.loadJson(fileName);
      _model = TextProcessingModel.fromJson(data);
      _error = '';
      _result = '';
    } catch (e) {
      _error = 'Model verisi yüklenemedi: $e';
    }
    notifyListeners();
  }

  Future<void> analyzeText({
    required String operation,
    required String inputText,
    List<String>? candidateLabels,
    String? context,
    String? question,
  }) async {
    _loading = true;
    _error = '';
    _result = '';
    notifyListeners();
    try {
      _result = await _service.sendText(
        inputText: inputText,
        operation: operation,
        candidateLabels: candidateLabels,
        context: context,
        question: question,
      );
    } catch (e) {
      _error = 'Metin analizi başarısız oldu: $e';
    }
    _loading = false;
    notifyListeners();
  }
}
