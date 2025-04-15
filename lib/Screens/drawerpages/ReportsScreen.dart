import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rafq1/Screens/drawerpages/GoalDetailPage.dart';
import 'package:rafq1/Screens/drawerpages/RecommendationDetailPage.dart';

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  List<bool> goalCompletionStatus = [false, false, false, false];
  List<int> goalProgress = [0, 0, 0, 0]; 
  int meditationSessions = 0;
  int diaryWritingSessions = 0;
  int therapySessions = 0;
  int exerciseSessions = 0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      meditationSessions = prefs.getInt('meditationSessions') ?? 0;
      diaryWritingSessions = prefs.getInt('diaryWritingSessions') ?? 0;
      therapySessions = prefs.getInt('therapySessions') ?? 0;
      exerciseSessions = prefs.getInt('exerciseSessions') ?? 0;

      goalProgress[0] = meditationSessions;
      goalProgress[1] = diaryWritingSessions;
      goalProgress[2] = therapySessions;
      goalProgress[3] = exerciseSessions;
    });
  }

  _updateProgress(int index, bool isCompleted) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (index == 0) {
      await prefs.setInt('meditationSessions', isCompleted ? 100 : 0);
    } else if (index == 1) {
      await prefs.setInt('diaryWritingSessions', isCompleted ? 100 : 0);
    } else if (index == 2) {
      await prefs.setInt('therapySessions', isCompleted ? 100 : 0);
    } else {
      await prefs.setInt('exerciseSessions', isCompleted ? 100 : 0);
    }

    _loadProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "التقارير والتقدم الشخصي"
            : "Reports and personal progress",style: TextStyle(fontFamily: 'Tajawal',),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            SizedBox(height: 20),
            _buildDataAnalysis(),
            SizedBox(height: 20),
            _buildGoalsSection(),
            SizedBox(height: 20),
            _buildRecommendations(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.emoji_events, size: 50, color: Colors.blue[400]),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.locale.languageCode == 'ar'
                        ? "ملخص التقدم"
                        : "Progress Summary",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
                  ),
                  SizedBox(height: 5),
                  Text(
                    context.locale.languageCode == 'ar'
                        ? "لقد أكملت ${meditationSessions + diaryWritingSessions + therapySessions + exerciseSessions} جلسة هذا الشهر، بما في ذلك ${meditationSessions} جلسة تأمل، ${diaryWritingSessions} جلسات كتابة يوميات، ${therapySessions} جلسات دعم نفسي، و${exerciseSessions} جلسات رياضية."
                        : "You have completed ${meditationSessions + diaryWritingSessions + therapySessions + exerciseSessions} sessions this month, including ${meditationSessions} meditation sessions, ${diaryWritingSessions} journaling sessions, ${therapySessions} therapy sessions, and ${exerciseSessions} exercise sessions.",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700],fontFamily: 'Tajawal',),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataAnalysis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.locale.languageCode == 'ar'
            ? "تحليل بياناتك"
            : "Analysis of your data",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',)).tr(),
        SizedBox(height: 10),
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                borderData: FlBorderData(show: true),
                titlesData: FlTitlesData(),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, meditationSessions.toDouble()),
                      FlSpot(1, diaryWritingSessions.toDouble()),
                      FlSpot(2, therapySessions.toDouble()),
                      FlSpot(3, exerciseSessions.toDouble()),
                    ],
                    isCurved: true,
                    barWidth: 4,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoalsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.locale.languageCode == 'ar'
            ? "أهدافك"
            : "Your goals",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',)).tr(),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                leading: Checkbox(
                  value: goalCompletionStatus[index],
                  onChanged: (value) {
                    setState(() {
                      goalCompletionStatus[index] = value!;
                      goalProgress[index] = value ? 100 : 0;
                    });
                    _updateProgress(index, value!);
                  },
                ),
                title: Text(
                  index == 0
                      ? context.locale.languageCode == 'ar'
                      ? "ممارسة التأمل لمدة 10 دقائق يوميًا"
                      : "Practice meditation for 10 minutes daily"
                      : index == 1
                      ? context.locale.languageCode == 'ar'
                      ? "كتابة مشاعرك في دفتر يومياتك"
                      : "Writing your feelings in your journal"
                      : index == 2
                      ? context.locale.languageCode == 'ar'
                      ? "إجراء جلسة دعم نفسي أسبوعيًا"
                      : "Conduct a weekly psychological support session"
                      : context.locale.languageCode == 'ar'
                      ? "ممارسة الرياضة 3 مرات في الأسبوع"
                      : "Exercise 3 times aweek",style: TextStyle(fontFamily: 'Tajawal',),
                ).tr(),
                trailing: CircularProgressIndicator(
                  value: goalProgress[index] / 100.0,
                  color: Colors.blue,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoalDetailPage(goalIndex: index),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.locale.languageCode == 'ar'
            ? "توصيات مخصصة"
            : "Personalized Recommendations",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',)),
        SizedBox(height: 10),
        for (int i = 0; i < goalCompletionStatus.length; i++) ...[
          if (goalCompletionStatus[i] && goalProgress[i] >= 50) ...[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                leading: Icon(Icons.lightbulb, color: Colors.orange),
                title: Text(
                  _getRecommendationForGoal(context, i,),
                  style: TextStyle(fontSize: 16,fontFamily: 'Tajawal'),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    _showRecommendationDetails(context,i);
                  },
                  child: Text(context.locale.languageCode == 'ar'
                      ? "عرض التفاصيل"
                      : "View Details",style: TextStyle(fontFamily: 'Tajawal',),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
        ElevatedButton(
          onPressed: () {
            _showMoreRecommendations();
          },
          child: Text(context.locale.languageCode == 'ar'
              ? "عرض المزيد"
              : "View More",style: TextStyle(color: Colors.white,fontFamily: 'Tajawal',),),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }

  void _showMoreRecommendations() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoreRecommendationsPage(),
      ),
    );
  }

  String _getRecommendationForGoal(BuildContext context, int index) {
  switch (index) {
      case 0:
        return context.locale.languageCode == 'ar'
            ? "نوصيك بممارسة تمرين التنفس العميق بعد كل جلسة تأمل."
            : "We recommend you practice adeep breathing exercise after eachmeditation session";
      case 1:
        return context.locale.languageCode == 'ar'
            ? "ابدأ بتوثيق مشاعرك بشكل يومي لتصبح أكثر وعيًا بتطوراتك العاطفية."
            : "Start documenting your feelings daily to be comemoreaware of your emotional developments";
      case 2:
        return context.locale.languageCode == 'ar'
            ? "ننصحك بإجراء جلسة دعم نفسي إضافية هذا الشهر لتعزيز تطورك."
            : "We recommend you have an additional mental health support session this monthtoenhance your development";
      case 3:
        return context.locale.languageCode == 'ar'
            ? "قم بزيادة مدة تمرينات الرياضة لتحقيق أفضل النتائج."
            : "Increase the duration of your workouts for best results";
      default:
        return context.locale.languageCode == 'ar'
            ? "تابع تقدمك وابق على المسار الصحيح!"
            : "Track your progress and stay on track!";
    }
  }

  void _showRecommendationDetails(BuildContext context, int index) {
    String recommendationDetails = _getRecommendationDetails(context, index);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecommendationDetailPage(
          recommendationTitle: _getRecommendationForGoal(context, index),
          recommendationDetails: recommendationDetails,
        ),
      ),
    );
  }


  String _getRecommendationDetails(BuildContext context, int index) {
    switch (index) {
      case 0:
        return context.locale.languageCode == 'ar'
            ? '''
🌿 **ممارسة التنفس العميق بعد التأمل**

التنفس العميق يعزز الاسترخاء ويقلل التوتر بشكل رائع! جرب هذه الخطوات البسيطة بعد جلسة التأمل:

✅ **الخطوات:**
1. أغلق عينيك وابدأ بالتنفس العميق: استنشق الهواء لمدة 4 ثوانٍ.
2. احبس النفس لمدة 4 ثوانٍ.
3. ازفر ببطء لمدة 4 ثوانٍ.
4. كرر لمدة 5 دقائق يوميًا، وزد المدة تدريجيًا.

✨ **الفوائد:**
- زيادة التركيز الذهني.
- تقليل التوتر المتراكم خلال اليوم.
'''
            : '''
🌿 **Practice Deep Breathing After Meditation**

Deep breathing enhances relaxation and reduces stress remarkably! Try these simple steps after your meditation session:

✅ **Steps:**
1. Close your eyes and start deep breathing: Inhale for 4 seconds.
2. Hold your breath for 4 seconds.
3. Exhale slowly for 4 seconds.
4. Repeat for 5 minutes daily, gradually increasing the duration.

✨ **Benefits:**
- Improved mental focus.
- Reduced accumulated stress throughout the day.
''';

      case 1:
        return context.locale.languageCode == 'ar'
            ? '''
📖 **كتابة المشاعر في دفتر اليوميات**

التعبير الكتابي هو وسيلة رائعة للتخلص من التوتر وفهم مشاعرك بشكل أعمق.

✅ **الخطوات:**
1. خصص 10 دقائق يوميًا للكتابة بحرية ودون قيود.
2. ركز على مشاعرك، وليس على أسلوب الكتابة.
3. اقرأ ما كتبته ولاحظ كيف تشعر بعد ذلك.

✨ **الفوائد:**
- تعزيز الوعي الذاتي.
- تقليل التوتر الداخلي.

👨‍⚕️ **نصيحة:**
جرب الكتابة في أوقات مختلفة (مثل الصباح والمساء) لرؤية تطور مشاعرك خلال اليوم.
'''
            : '''
📖 **Journaling Your Emotions**

Writing is a great way to relieve stress and understand your emotions deeper.

✅ **Steps:**
1. Dedicate 10 minutes daily to free writing without constraints.
2. Focus on your feelings, not on the writing style.
3. Read what you've written and observe how you feel afterward.

✨ **Benefits:**
- Enhanced self-awareness.
- Reduced internal stress.

👨‍⚕️ **Tip:**
Try writing at different times (like morning and evening) to see the progression of your emotions.
''';

      case 2:
        return context.locale.languageCode == 'ar'
            ? '''
🧠 **إجراء جلسات دعم نفسي منتظمة**

الدعم النفسي يفتح لك أبوابًا جديدة لفهم ذاتك والتعامل مع التحديات بشكل صحي.

✅ **الخطوات:**
1. حدد موعدًا أسبوعيًا لجلسات الدعم النفسي.
2. حضّر مواضيع تشعر أنها تؤثر عليك لمناقشتها مع المستشار.
3. سجل ملاحظاتك وراجع تقدمك بعد كل جلسة.

✨ **الفوائد:**
- تعلم استراتيجيات جديدة للتعامل مع الضغوط.
- توفير مساحة آمنة للتعبير عن مشاعرك.

👨‍⚕️ **نصيحة:**
اجعل الجلسات النفسية عادة مستمرة وليست خيارًا مؤجلًا.
'''
            : '''
🧠 **Attend Regular Psychological Support Sessions**

Psychological support opens new doors to understand yourself and manage challenges healthily.

✅ **Steps:**
1. Schedule weekly support sessions.
2. Prepare topics that affect you to discuss with your counselor.
3. Take notes and review your progress after each session.

✨ **Benefits:**
- Learn new strategies to handle stress.
- Create a safe space to express your feelings.

👨‍⚕️ **Tip:**
Make support sessions a consistent habit, not a postponed option.
''';

      case 3:
        return context.locale.languageCode == 'ar'
            ? '''
🏋️ **ممارسة الرياضة بانتظام**

الرياضة ليست فقط لتحسين اللياقة، بل أيضًا لتعزيز صحتك النفسية بشكل فعال.

✅ **الخطوات:**
1. اختر نشاطًا تستمتع به (المشي، الجري، تمارين القوة).
2. خصص وقتًا للرياضة 3 مرات أسبوعيًا على الأقل.
3. اجعلها جزءًا من روتينك اليومي.

✨ **الفوائد:**
- تحسين المزاج عبر إفراز هرمونات السعادة.
- زيادة الطاقة والتركيز خلال اليوم.

👨‍⚕️ **نصيحة:**
ابدأ بأنشطة خفيفة، وزد المستوى تدريجيًا. حتى 15 دقيقة يوميًا تصنع فرقًا كبيرًا!
'''
            : '''
🏋️ **Exercise Regularly**

Exercise is not just for fitness but also for effectively boosting your mental health.

✅ **Steps:**
1. Choose an activity you enjoy (walking, running, strength training).
2. Allocate time for exercise at least 3 times a week.
3. Make it a part of your daily routine.

✨ **Benefits:**
- Improved mood through the release of endorphins.
- Increased energy and focus throughout the day.

👨‍⚕️ **Tip:**
Start with light activities and gradually increase intensity. Even 15 minutes a day can make a significant difference!
''';

      default:
        return context.locale.languageCode == 'ar'
            ? 'تابع تقدمك في هذه الأهداف لتحقيق صحة نفسية أفضل!'
            : 'Keep progressing toward these goals to achieve better mental health!';
    }
  }

}

class MoreRecommendationsPage extends StatelessWidget {
  List<String> getRecommendations(BuildContext context) {
    return [
      context.locale.languageCode == 'ar'
          ? 'ابدأ بتطبيق استراتيجيات التنفس العميق كل يوم لمدة 10 دقائق.'
          : '** Start practicing deep breathing strategies every day for 10 minutes.',
      context.locale.languageCode == 'ar'
          ? 'حاول تخصيص وقت للراحة والاسترخاء في نهاية اليوم.'
          : '** Try to allocate time for rest and relaxation at the end of the day.',
      context.locale.languageCode == 'ar'
          ? 'جرب تمارين التأمل لمدة 5 دقائق يوميًا لزيادة الوعي الذاتي.'
          : '** Try meditation exercises for 5 minutes daily to boost self-awareness.',
      context.locale.languageCode == 'ar'
          ? 'حافظ على نظام غذائي صحي لتقليل التوتر وزيادة الطاقة.'
          : '** Maintain a healthy diet to reduce stress and boost energy.',
      context.locale.languageCode == 'ar'
          ? 'احرص على ممارسة الرياضة بانتظام لتخفيف القلق والتوتر.'
          : '** Ensure regular exercise to alleviate anxiety and stress.',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final recommendations = getRecommendations(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.locale.languageCode == 'ar'
              ? "التوصيات الإضافية"
              : "Additional Recommendations",style: TextStyle(fontFamily: 'Tajawal',),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              recommendations[index],
              style: const TextStyle(fontSize: 16,fontFamily: 'Tajawal'),
            ),
          );
        },
      ),
    );
  }
}