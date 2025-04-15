import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rafq1/Screens/HomePage.dart';

class AdminPanel extends StatelessWidget {
  final CollectionReference faqsRef =
  FirebaseFirestore.instance.collection('faqs');

  @override
  Widget build(BuildContext context) {
    String langCode = context.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          langCode == 'ar' ? "لوحة تحكم الأسئلة" : "Questions Dashboard",
          style: TextStyle(fontFamily: 'Tajawal'),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage(forumId: '')),
                    (Route<dynamic> route) => false,
              );
            },
            child: Text(
              langCode == 'ar' ? "العودة للرئيسية" : "Back to Home",
              style: TextStyle(fontFamily: 'Tajawal'),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: faqsRef.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                langCode == 'ar' ? "لا توجد أسئلة." : "No questions.",
                style: TextStyle(fontFamily: 'Tajawal'),
              ),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              String question = doc['question_$langCode'] ?? '';
              String answer = doc['answer_$langCode'] ?? '';

              return ListTile(
                title: Text(
                  langCode == 'ar' ? 'س: $question' : 'Q: $question',
                  style: TextStyle(fontFamily: 'Tajawal'),
                ),
                subtitle: Text(
                  langCode == 'ar' ? 'ج: $answer' : 'A: $answer',
                  style: TextStyle(fontFamily: 'Tajawal'),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showEditDialog(context, doc, langCode, answer);
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, QueryDocumentSnapshot doc, String langCode, String currentAnswer) {
    TextEditingController _answerController =
    TextEditingController(text: currentAnswer);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          langCode == 'ar' ? "تعديل الرد" : "Edit reply",
          style: TextStyle(fontFamily: 'Tajawal'),
        ),
        content: TextField(
          controller: _answerController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: langCode == 'ar' ? "الرد الجديد" : "New reply",
            labelStyle: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              langCode == 'ar' ? "إلغاء" : "Cancel",
              style: TextStyle(fontFamily: 'Tajawal'),
            ),
          ),
          TextButton(
            onPressed: () async {
              String newAnswer = _answerController.text.trim();
              if (newAnswer.isNotEmpty) {
                await doc.reference.update({
                  'answer_$langCode': newAnswer,
                });
              }
              Navigator.pop(context);
            },
            child: Text(
              langCode == 'ar' ? "حفظ" : "Save",
              style: TextStyle(fontFamily: 'Tajawal'),
            ),
          ),
        ],
      ),
    );
  }
}
