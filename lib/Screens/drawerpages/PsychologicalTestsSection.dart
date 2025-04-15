import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PsychologicalTestsSection extends StatelessWidget {
  const PsychologicalTestsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentLanguage = context.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentLanguage == 'ar'
            ? "الاختبارات النفسيه"
            : "Psychological Tests",style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('psychological_tests')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('حدث خطأ: ${snapshot.error}'.tr()),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(currentLanguage == 'ar'
                  ? "لا توجد اختبارات متاحة"
                  : "No tests are available",style: TextStyle(fontFamily: 'Tajawal',),),
            );
          }

          var tests = snapshot.data!.docs;
          return ListView.builder(
            itemCount: tests.length,
            itemBuilder: (context, index) {
              var testData = tests[index].data() as Map<String, dynamic>;
              String testName = currentLanguage == 'ar'
                  ? (testData['name_ar'] ?? "اختبار بدون اسم")
                  : (testData['name_en'] ?? "Test without a name");

              String testDescription = currentLanguage == 'ar'
                  ? (testData['description_ar'] ?? "لا يوجد وصف")
                  : (testData['description_en'] ?? "No description");

              return TestCard(
                testId: tests[index].id,
                testName: testName,
                testDescription: testDescription,
                onTap: () => _navigateToTestPage(context, tests[index].id),
              );
            },
          );
        },
      ),
    );
  }

  void _navigateToTestPage(BuildContext context, String testId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestDetailPage(testId: testId),
      ),
    );
  }
}

class TestDetailPage extends StatefulWidget {
  final String testId;

  const TestDetailPage({Key? key, required this.testId}) : super(key: key);

  @override
  _TestDetailPageState createState() => _TestDetailPageState();
}

class _TestDetailPageState extends State<TestDetailPage> {
  Map<int, String> userAnswers = {};

  @override
  Widget build(BuildContext context) {
    final currentLanguage = context.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentLanguage == 'ar'
            ? "تفاصيل الاختبار"
            : "Test Details",style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('psychological_tests')
            .doc(widget.testId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('حدث خطأ: ${snapshot.error}'.tr()),
            );
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text(currentLanguage == 'ar'
                  ? "لا توجد بيانات للاختبار"
                  : "No data for the test",style: TextStyle(fontFamily: 'Tajawal',),),
            );
          }

          var testData = snapshot.data!.data() as Map<String, dynamic>?;
          if (testData == null) return const SizedBox();

          String testName = currentLanguage == 'ar'
              ? (testData['name_ar'] ?? "اختبار بدون اسم")
              : (testData['name_en'] ?? "Test without a name");

          String testDescription = currentLanguage == 'ar'
              ? (testData['description_ar'] ?? "لا يوجد وصف")
              : (testData['description_en'] ?? "No description");

          var questionsData = testData['questions'];
          List<dynamic> questionsList = [];
          if (questionsData is Map<String, dynamic>) {
            questionsList = questionsData.values.toList();
          } else if (questionsData is List) {
            questionsList = questionsData;
          } else {
            return Center(
              child: Text(currentLanguage == 'ar'
                  ? "⚠ تنسيق البيانات غير صحيح! تأكد من أن الأسئلة على شكل قائمة."
                  : "⚠ Invalid data format! Make sure questions are a list.",style: TextStyle(fontFamily: 'Tajawal',),),
            );
          }

          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  testName,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  testDescription,
                  style: const TextStyle(fontSize: 16,fontFamily: 'Tajawal',),
                ),
              ),
              const Divider(thickness: 1),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: questionsList.length,
                itemBuilder: (context, index) {
                  var question = questionsList[index];
                  if (question is! Map ||
                      question['options'] == null ||
                      (question['text_ar'] == null && question['text_en'] == null)) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(currentLanguage == 'ar'
                          ? "⚠ سؤال غير مكتمل أو يحتوي على بيانات غير صحيحة!"
                          : "⚠ Incomplete question or contains incorrect data!",style: TextStyle(fontFamily: 'Tajawal',),),
                    );
                  }

                  String questionText = currentLanguage == 'ar'
                      ? question['text_ar'] ?? "سؤال غير متوفر"
                      : question['text_en'] ?? "Question not available";

                  var options = question['options'];
                  List<MapEntry> optionEntries = [];
                  if (options is Map) {
                    optionEntries = options.entries.toList();
                  } else if (options is List) {
                    optionEntries = options.asMap().entries.toList();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(currentLanguage == 'ar'
                          ? "⚠ تنسيق الخيارات غير صحيح!"
                          : "⚠ Invalid options format!",style: TextStyle(fontFamily: 'Tajawal',),),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          questionText,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
                        ),
                      ),
                  Wrap(
                  spacing: 10,
                  children: optionEntries.map<Widget>((entry) {
                  String optionKey = entry.key.toString();
                  var optionValue = entry.value;
                  Map optionData;
                  if (optionValue is Map) {
                  optionData = optionValue;
                  } else if (optionValue is String) {
                  optionData = {'text_ar': optionValue, 'text_en': optionValue};
                  } else {
                  optionData = {};
                  }
                  String optionText = currentLanguage == 'ar'
                  ? optionData['text_ar'] ?? ""
                      : optionData['text_en'] ?? "";
                  bool isSelected = userAnswers[index] == optionKey;
                  return ElevatedButton(
                  onPressed: () {
                  setState(() {
                  userAnswers[index] = optionKey;
                  });
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected ? Colors.green : Colors.lightBlueAccent,
                  ),
                  child: Text(optionText,style: TextStyle(fontFamily: 'Tajawal',),),
                  );
                  }).toList(),
                  ),
                      const Divider(thickness: 1),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _evaluateTest,
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(Icons.send),
      ),
    );
  }

  String _getResult(int score, int totalQuestions) {
    double percentage = (score / (totalQuestions * 3)) * 100;
    if (percentage > 70) {
      return context.locale.languageCode == 'ar'
          ? "مستوى القلق: مرتفع. نوصيك بحجز موعد مع مختص نفسي."
          : "Anxiety Level: High. We recommend you book an appointment with a mental health professional.";
    } else if (percentage > 40) {
      return context.locale.languageCode == 'ar'
          ? "مستوى القلق: متوسط. جرب تمارين الاسترخاء وتقنيات التأمل."
          : "Anxiety Level: Moderate. Try relaxation exercises and meditation techniques.";
    } else {
      return context.locale.languageCode == 'ar'
          ? "مستوى القلق: منخفض. أحسنت في إدارة مشاعرك!"
          : "Anxiety Level: Low. Good job managing your emotions!";
    }
  }

  void _evaluateTest() async {
    var testSnapshot = await FirebaseFirestore.instance
        .collection('psychological_tests')
        .doc(widget.testId)
        .get();
    if (!testSnapshot.exists) return;

    var testData = testSnapshot.data();
    var questions = testData?['questions'] ?? [];
    if (questions is Map<String, dynamic>) {
      questions = questions.values.toList();
    }

    int anxietyScore = 0;
    for (var i = 0; i < questions.length; i++) {
      var question = questions[i];
      if (question == null ||
          question['options'] == null ||
          question['options'].isEmpty) continue;
      var userAnswer = userAnswers[i];
      if (userAnswer != null) {
        int answerValue = int.tryParse(userAnswer) ?? 0;
        anxietyScore += answerValue;
      }
    }

    String result = _getResult(anxietyScore, questions.length);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.locale.languageCode == 'ar'
            ? "نتيجة الاختبار"
            : "Test Result",style: TextStyle(fontFamily: 'Tajawal',),),
        content: Text(result),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.locale.languageCode == 'ar'
                ? "حسناً"
                : "Okay",style: TextStyle(fontFamily: 'Tajawal',),),
          ),
        ],
      ),
    );
  }
}

class TestCard extends StatelessWidget {
  final String testId;
  final String testName;
  final String testDescription;
  final VoidCallback onTap;

  const TestCard({
    Key? key,
    required this.testId,
    required this.testName,
    required this.testDescription,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          testName,
          style: const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
        ),
        subtitle: Text(testDescription,style: TextStyle(fontFamily: 'Tajawal',),),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
