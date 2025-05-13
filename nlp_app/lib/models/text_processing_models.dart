class TextProcessingModel {
  final String title;
  final String description;
  final String inputTextPlaceholder;
  final String outputTextPlaceholder;
  final String operation;
  final String fileName;
  final String code;

  TextProcessingModel({
    required this.title,
    required this.description,
    required this.inputTextPlaceholder,
    required this.outputTextPlaceholder,
    required this.operation,
    required this.fileName,
    required this.code,
  });

  factory TextProcessingModel.fromJson(Map<String, dynamic> json) {
    return TextProcessingModel(
      title: json['title'],
      description: json['description'],
      inputTextPlaceholder: json['input_text_placeholder'],
      outputTextPlaceholder: json['output_text_placeholder'],
      operation: json['operation'],
      fileName: json['fileName'],
      code: json['code'],
    );
  }
}
