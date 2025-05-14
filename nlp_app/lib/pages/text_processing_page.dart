import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nlp_app/theme/colors.dart';
import 'package:nlp_app/viewmodels/text_processing_viewmodel.dart';
import 'package:provider/provider.dart';

class TextProcessingPage extends StatefulWidget {
  final String fileName;

  const TextProcessingPage({super.key, required this.fileName});

  @override
  State<TextProcessingPage> createState() => _TextProcessingPageState();
}

class _TextProcessingPageState extends State<TextProcessingPage> {
  final _textController = TextEditingController();
  final _contextController = TextEditingController();
  final _questionController = TextEditingController();
  final _candidateLabelsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<TextProcessingViewModel>(
      context,
      listen: false,
    ).loadModelData(widget.fileName);
  }

  @override
  void dispose() {
    _textController.dispose();
    _contextController.dispose();
    _questionController.dispose();
    _candidateLabelsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TextProcessingViewModel>(
      builder: (context, viewModel, child) {
        final model = viewModel.model;

        return Scaffold(
          appBar: AppBar(title: Text(model?.title ?? 'Yükleniyor...')),
          body:
              model == null
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model.description),
                          const SizedBox(height: 20),

                          if (model.operation != "aq") _buildTextField(model),
                          if (model.operation == "classify")
                            _buildCandidateLabelsField(model),
                          if (model.operation == "aq")
                            _buildContextAndQuestionFields(),

                          const SizedBox(height: 20),
                          _buildSubmitButton(viewModel, model),
                          const SizedBox(height: 20),

                          viewModel.result.isNotEmpty
                              ? _buildResultView(viewModel.result)
                              : Text(model.outputTextPlaceholder),

                          const SizedBox(height: 20),
                          const Text("Python Kodu:"),
                          const SizedBox(height: 10),
                          HighlightView(
                            model.code,
                            language: 'python',
                            theme: monokaiSublimeTheme,
                            padding: const EdgeInsets.all(12),
                          ),
                        ],
                      ),
                    ),
                  ),
        );
      },
    );
  }

  Widget _buildTextField(model) {
    return TextField(
      controller: _textController,
      maxLines: null,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: model.inputTextPlaceholder,
      ),
    );
  }

  Widget _buildCandidateLabelsField(model) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: TextField(
        controller: _candidateLabelsController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: "Etiketleri virgülle ayırarak girin",
        ),
      ),
    );
  }

  Widget _buildContextAndQuestionFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _contextController,
          maxLines: null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Context",
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _questionController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Question",
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(TextProcessingViewModel viewModel, model) {
    return ElevatedButton(
      onPressed:
          viewModel.isLoading ? null : () => _onSubmitPressed(viewModel, model),
      child:
          viewModel.isLoading
              ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
              : const Text('Gönder'),
    );
  }

  Future<void> _onSubmitPressed(
    TextProcessingViewModel viewModel,
    model,
  ) async {
    FocusScope.of(context).unfocus(); //klavyeyi gizle

    final text = _textController.text.trim();
    final contextText = _contextController.text.trim();
    final question = _questionController.text.trim();
    final labelsText = _candidateLabelsController.text.trim();

    try {
      if (model.operation == "aq") {
        if (contextText.isEmpty || question.isEmpty) {
          Fluttertoast.showToast(msg: "Context ve soru alanlarını doldurunuz.");
          return;
        }
        await viewModel.analyzeText(
          operation: model.operation,
          context: contextText,
          question: question,
        );
      } else if (model.operation == "classify") {
        if (text.isEmpty || labelsText.isEmpty) {
          Fluttertoast.showToast(msg: "Metin ve etiket alanları boş olamaz.");
          return;
        }
        final labels = labelsText.split(',').map((e) => e.trim()).toList();
        await viewModel.analyzeText(
          operation: model.operation,
          inputText: text,
          candidateLabels: labels,
        );
      } else {
        if (text.isEmpty) {
          Fluttertoast.showToast(msg: "Lütfen metin giriniz.");
          return;
        }
        await viewModel.analyzeText(
          operation: model.operation,
          inputText: text,
        );
      }
      Fluttertoast.showToast(msg: "Gönderildi");
    } catch (e) {
      Fluttertoast.showToast(msg: "Hata: $e");
    }
  }

  Widget _buildResultView(String result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Çıktı:", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: primaryAccent, width: 1.5),
          ),
          child: Text(result, style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
