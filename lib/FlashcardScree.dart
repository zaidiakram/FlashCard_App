import 'package:flash_card/AddEditFlashcardScreen.dart';
import 'package:flash_card/model/Flashcard.dart';
import 'package:flutter/material.dart';

class FlashcardScreen extends StatefulWidget {
  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  List<Flashcard> flashcards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 91, 139, 221),
appBar: AppBar(
     backgroundColor: Colors.black,
  elevation: 0,
  title: Text('Flashcards',
  style: TextStyle(color: Colors.blue,fontSize: 30,
        fontWeight: FontWeight.w600),
        ),
        ),
    
      body: ListView.builder(
        itemCount: flashcards.length,
        itemBuilder: (context, index) {
          final flashcard = flashcards[index];
          return Card(
            color: Colors.black,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              title: Text(flashcard.question,style: TextStyle(
                color: Colors.white,
              ),),
              onTap: () {
                _showAnswerDialog(flashcard);
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit,color: Colors.white,),
                    onPressed: () {
                      _editFlashcard(index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete,color: Colors.red,),
                    onPressed: () {
                      _confirmDelete(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
        
          shape: CircleBorder(
            
          ),
            
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          onPressed: _addFlashcard,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _showAnswerDialog(Flashcard flashcard) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Answer'),
          content: Text(flashcard.answer),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _addFlashcard() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEditFlashcardScreen(
        onSave: (question, answer) {
          setState(() {
            flashcards.add(Flashcard(question: question, answer: answer));
          });
        },
      )),
    );
  }

  void _editFlashcard(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEditFlashcardScreen(
        flashcard: flashcards[index],
        onSave: (question, answer) {
          setState(() {
            flashcards[index] = Flashcard(question: question, answer: answer);
          });
        },
      )),
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Flashcard'),
          content: Text('Are you sure you want to delete this flashcard?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  flashcards.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}