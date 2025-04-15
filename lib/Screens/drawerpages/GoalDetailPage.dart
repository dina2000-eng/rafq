import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalDetailPage extends StatefulWidget {
  final int goalIndex;

  GoalDetailPage({required this.goalIndex});

  @override
  _GoalDetailPageState createState() => _GoalDetailPageState();
}

class _GoalDetailPageState extends State<GoalDetailPage> {
  double goalProgress = 0.0;
  int currentStep = 0;

  List<String> goalTitles(BuildContext context) {
    return [
      context.locale.languageCode == 'ar'
          ? 'ممارسة التأمل لمدة 10 دقائق يوميًا'
          : 'Meditate for 10 minutes daily',
      context.locale.languageCode == 'ar'
          ? 'كتابة مشاعرك في دفتر يومياتك'
          : 'Write your feelings in your journal',
      context.locale.languageCode == 'ar'
          ? 'قراءة كتاب أسبوعيًا'
          : 'Read a book weekly',
      context.locale.languageCode == 'ar'
          ? 'ممارسة الرياضة 3 مرات في الأسبوع'
          : 'Exercise 3 times a week',
    ];
  }

  List<String> goalDetails(BuildContext context) {
    return [
      context.locale.languageCode == 'ar'
          ? 'تخصيص وقت كل يوم لمدة 10 دقائق لتأمل التنفس أو التأمل الذهني.'
          : 'Dedicate 10 minutes daily to breathing meditation or mindfulness meditation.',
      context.locale.languageCode == 'ar'
          ? 'خصص 10 دقائق يوميًا لكتابة مشاعرك وأفكارك في دفتر يومياتك. يمكن أن تساعد هذه العادة في تحسين صحتك النفسية.'
          : 'Spend 10 minutes each day writing your feelings and thoughts in your journal. This habit can help improve your mental health.',
      context.locale.languageCode == 'ar'
          ? 'اختيار كتاب وقراءة فصل واحد على الأقل أسبوعيًا لتطوير المهارات الشخصية.'
          : 'Choose a book and read at least one chapter per week to develop personal skills.',
      context.locale.languageCode == 'ar'
          ? 'القيام بتدريبات رياضية مثل المشي أو الركض لمدة 30 دقيقة في كل مرة.'
          : 'Engage in physical exercise like walking or jogging for 30 minutes each time.',
    ];
  }

  List<String> additionalDetails(BuildContext context) {
    return [
      context.locale.languageCode == 'ar'
          ? 'خذ نفسًا عميقًا، إغلق عينيك، وركز على تنفسك لمدة 10 دقائق. يمكنك استخدام تطبيقات مثل Headspace أو Calm.'
          : 'Take a deep breath, close your eyes, and focus on your breathing for 10 minutes. You can use apps like Headspace or Calm.',
      context.locale.languageCode == 'ar'
          ? 'اكتب كل ما يخطر ببالك في دفتر يومياتك، حتى لو كانت أفكارك عشوائية. سيساعدك ذلك على تنظيم مشاعرك وتقليل التوتر.'
          : 'Write down whatever comes to your mind in your journal, even if your thoughts are random. This will help organize your emotions and reduce stress.',
      context.locale.languageCode == 'ar'
          ? 'اختر كتابًا يثير اهتمامك وابدأ بقراءة فصل واحد. حاول أن تخصص وقتًا يوميًا لذلك.'
          : 'Choose a book that interests you and start reading one chapter. Try to set aside daily time for it.',
      context.locale.languageCode == 'ar'
          ? 'ابدأ بالجري السهل أو المشي لمدة 5 دقائق، ثم زد الوقت تدريجيًا كل أسبوع.'
          : 'Start with light jogging or walking for 5 minutes, then gradually increase the duration each week.',
    ];
  }

  _updateProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('goalProgress${widget.goalIndex}', goalProgress);
    await prefs.setInt('currentStep${widget.goalIndex}', currentStep);
  }

  _updateAnalysis() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('analysisProgress${widget.goalIndex}', goalProgress);
  }

  _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      goalProgress = prefs.getDouble('goalProgress${widget.goalIndex}') ?? 0.0;
      currentStep = prefs.getInt('currentStep${widget.goalIndex}') ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "تفاصيل الهدف"
            : "Goal details",style: TextStyle(fontFamily: 'Tajawal',),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              goalTitles(context)[widget.goalIndex],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
            ),
            SizedBox(height: 10),
            Text(
              goalDetails(context)[widget.goalIndex],
              style: TextStyle(fontSize: 16, color: Colors.grey[700],fontFamily: 'Tajawal',),
            ),
            SizedBox(height: 20),
            Text(
              context.locale.languageCode == 'ar'
                  ? "كيفية القيام بالهدف:"
                  : "How to do the goal",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
            ),
            SizedBox(height: 10),
            Text(
              additionalDetails(context)[widget.goalIndex],
              style: TextStyle(fontSize: 16, color: Colors.grey[700],fontFamily: 'Tajawal',),
            ),
            SizedBox(height: 20),
            Text(
              context.locale.languageCode == 'ar'
                  ? "تقدمك:"
                  : "Your progress",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: goalProgress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (currentStep < 10) {
                  setState(() {
                    currentStep++;
                    goalProgress = currentStep / 10;
                  });
                  _updateProgress();
                }

                if (currentStep == 10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.locale.languageCode == 'ar'
                        ? "لقد أكملت الهدف"
                        : "Completed the goal",style: TextStyle(fontFamily: 'Tajawal',),)),
                  );
                  _updateAnalysis();
                }
              },
              child: Text(context.locale.languageCode == 'ar'
                  ? "أكمل الهدف"
                  : "Complete the goal",style: TextStyle(fontFamily: 'Tajawal',),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              tr('current_step', args: [currentStep.toString(), '10']),
              style: TextStyle(fontSize: 16, color: Colors.grey[700],fontFamily: 'Tajawal',),
            ),
          ],
        ),
      ),
    );
  }
}
