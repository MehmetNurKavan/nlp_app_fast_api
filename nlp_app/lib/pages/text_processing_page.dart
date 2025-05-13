import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nlp_app/viewmodels/text_processing_viewmodel.dart';
import 'package:provider/provider.dart';

class TextProcessingPage extends StatefulWidget {
  final String fileName;

  const TextProcessingPage({super.key, required this.fileName});

  @override
  State<TextProcessingPage> createState() => _TextProcessingPageState();
}

class _TextProcessingPageState extends State<TextProcessingPage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _contextController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _candidateLabelsController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<TextProcessingViewModel>(
      context,
      listen: false,
    );
    viewModel.loadModelData(widget.fileName);
  }

  @override
  void dispose() {
    // TextEditingController'ları dispose etmek
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
                          if (model.operation != "aq") ...[
                            _buildInputTextField(model),
                            const SizedBox(height: 20),
                          ],
                          const SizedBox(height: 20),
                          if (model.operation == "classify")
                            _buildCandidateLabelsField(),
                          if (model.operation == "aq")
                            _buildContextAndQuestionFields(),
                          _buildSubmitButton(viewModel, model),
                          const SizedBox(height: 20),
                          if (viewModel.result.isNotEmpty)
                            _buildResultView(viewModel),
                          const SizedBox(height: 20),
                          const Text("Python Kodu:"),
                          const SizedBox(height: 15),
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

  // Text Input alanını oluşturuyoruz
  Widget _buildInputTextField(model) {
    return TextField(
      controller: _textController,
      maxLines: null,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: model.inputTextPlaceholder,
      ),
    );
  }

  // "classify" operation'ı için candidate_labels alanını oluşturuyoruz
  Widget _buildCandidateLabelsField() {
    return TextField(
      controller: _candidateLabelsController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Candidate Labels (comma separated)",
      ),
    );
  }

  // "aq" operation'ı için context ve question alanlarını oluşturuyoruz
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
        const SizedBox(height: 20),
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

  // Gönder butonunu oluşturuyoruz
  Widget _buildSubmitButton(viewModel, model) {
    return ElevatedButton(
      onPressed:
          viewModel.isLoading
              ? null
              : () async {
                // Yükleniyor göstergesi
                setState(() {
                  viewModel._loading = true;
                });

                try {
                  // Farklı işlemler için farklı parametreleri geçir
                  if (model.operation == "classify") {
                    final candidateLabels = _candidateLabelsController.text
                        .split(',');
                    await viewModel.analyzeText(
                      operation: model.operation,
                      inputText: _textController.text,
                      candidateLabels: candidateLabels,
                    );
                  } else if (model.operation == "aq") {
                    await viewModel.analyzeText(
                      operation: model.operation,
                      inputText: _textController.text,
                      context: _contextController.text,
                      question: _questionController.text,
                    );
                  } else {
                    await viewModel.analyzeText(
                      operation: model.operation,
                      inputText: _textController.text,
                    );
                  }
                  // Başarı durumunda
                  Fluttertoast.showToast(
                    msg: "İşlem başarılı!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                } catch (e) {
                  // Hata durumunda
                  Fluttertoast.showToast(
                    msg: "Hata: $e",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                } finally {
                  // Yükleniyor göstergesi kaldırma
                  setState(() {
                    viewModel._loading = false;
                  });
                }
              },
      child:
          viewModel.isLoading
              ? const CircularProgressIndicator()
              : const Text('Gönder'),
    );
  }

  // Sonuçları ekrana yazdıran widget
  Widget _buildResultView(viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Çıktı:", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(viewModel.result),
      ],
    );
  }
}
