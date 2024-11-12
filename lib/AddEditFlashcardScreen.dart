
import 'package:flash_card/model/Flashcard.dart';
import 'package:flutter/material.dart';


class AddEditFlashcardScreen extends StatefulWidget {
  final Flashcard? flashcard;
  final Function(String, String) onSave;

  AddEditFlashcardScreen({this.flashcard, required this.onSave});

  @override
  _AddEditFlashcardScreenState createState() => _AddEditFlashcardScreenState();
}

class _AddEditFlashcardScreenState extends State<AddEditFlashcardScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController;
  late TextEditingController _answerController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the current flashcard data if available
    _questionController = TextEditingController(text: widget.flashcard?.question ?? '');
    _answerController = TextEditingController(text: widget.flashcard?.answer ?? '');
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.flashcard == null ? 'Add Flashcard' : 'Edit Flashcard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(labelText: 'Question'),
                validator: (value) => value!.isEmpty ? 'Question cannot be empty' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _answerController,
                decoration: InputDecoration(labelText: 'Answer'),
                validator: (value) => value!.isEmpty ? 'Answer cannot be empty' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Validate form and save flashcard data if valid
                  if (_formKey.currentState!.validate()) {
                    widget.onSave(
                      _questionController.text,
                      _answerController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.flashcard == null ? 'Add' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
