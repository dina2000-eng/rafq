import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final Map<String, TextEditingController> _controllers = {};

  void updateAnswer(String docId, String newAnswer, String langCode) async {
    final field = langCode == 'ar' ? 'answer_ar' : 'answer_en';
    await FirebaseFirestore.instance.collection('faq').doc(docId).update({
      field: newAnswer,
    });
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.locale.languageCode;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('faq').orderBy('timestamp', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        var docs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            var doc = docs[index];
            var question = doc['question_${langCode}'] ?? '';
            var answer = doc['answer_${langCode}'] ?? '';
            var docId = doc.id;

            // Create a controller for each document
            _controllers[docId] ??= TextEditingController(text: answer);

            return Card(
              margin: EdgeInsets.all(12),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(question,
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 8),
                    TextField(
                      controller: _controllers[docId],
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: langCode == 'ar'
                            ? "اكتب الإجابة هنا"
                            : "Write your answer here",
                        labelStyle: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        updateAnswer(docId, _controllers[docId]!.text, langCode);
                      },
                      child: Text(
                        langCode == 'ar' ? "حفظ التعديلات" : "Save changes",
                        style: TextStyle(fontFamily: 'Tajawal'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
