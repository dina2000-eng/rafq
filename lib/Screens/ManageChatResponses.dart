import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageChatResponses extends StatefulWidget {
  @override
  _ManageChatResponsesState createState() => _ManageChatResponsesState();
}

class _ManageChatResponsesState extends State<ManageChatResponses> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  // Function to add a new chat response
  Future<void> _addChatResponse() async {
    if (_questionController.text.isNotEmpty && _answerController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('chat_responses').add({
        'question': _questionController.text.trim(),
        'answer': _answerController.text.trim(),
      });
      _questionController.clear();
      _answerController.clear();
    }
  }

  // Function to move a question from unanswered to answered
  Future<void> _answerUnansweredQuestion(String docId, String question) async {
    if (_answerController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('chat_responses').add({
        'question': question,
        'answer': _answerController.text.trim(),
      });
      await FirebaseFirestore.instance.collection('unanswered_questions').doc(docId).delete();
      _answerController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Chat Responses',style: TextStyle(fontFamily: 'Tajawal',),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Question'),
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(labelText: 'Answer'),
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addChatResponse,
              child: Text('Add Chat Response',style: TextStyle(fontFamily: 'Tajawal',),),
            ),
            SizedBox(height: 24),
            Text('Unanswered Questions:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',)),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('unanswered_questions').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                  if (snapshot.connectionState == ConnectionState.waiting) return CircularProgressIndicator();

                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      return ListTile(
                        title: Text(document['question'],style: TextStyle(fontFamily: 'Tajawal',),),
                        trailing: IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () => _answerUnansweredQuestion(document.id, document['question']),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
