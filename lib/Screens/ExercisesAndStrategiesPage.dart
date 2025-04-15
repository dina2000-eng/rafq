import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rafq1/Screens/ExerciseDetailPage.dart';

class ExercisesAndStrategiesPage extends StatelessWidget {
  const ExercisesAndStrategiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "تمارين واستراتيجيات"
            : "Exercises and strategies",style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.purple.shade100,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context.locale.languageCode == 'ar'
                ? "تمارين التأمل"
                : "Meditation Exercises"),
            _divider(),
            _buildExerciseCard(
              title: context.locale.languageCode == 'ar'
                  ? "تأمل اليقظة الذهنية"
                  : "Mindfulness Meditation",
              description: context.locale.languageCode == 'ar'
                  ? "تمارين تركز على توجيه الانتباه للحظة الحالية دون إصدار أحكام."
                  : "Exercises that focus on directing attention to the present moment without judgment.",
              fullDescription: context.locale.languageCode == 'ar'
                  ? '''
1. اجلس في مكان هادئ ومريح.
2. أغلق عينيك وابدأ في التركيز على تنفسك.
3. لاحظ كل نفس يدخل ويخرج من جسمك، دون إصدار أحكام عليه.
4. عندما تلاحظ أفكارًا تطرأ، ببساطة أعد تركيزك إلى تنفسك.
5. استمر في ذلك لمدة 10 دقائق.
'''
                  : '''
1. Sit in a quiet and comfortable place.
2. Close your eyes and start focusing on your breath.
3. Notice each inhale and exhale without judging it.
4. If thoughts arise, gently bring your focus back to your breath.
5. Continue for 10 minutes.
''',
              duration: context.locale.languageCode == 'ar'
                  ? "١٠ دقائق"
                  : "10 minutes",
              imageUrl: 'assets/meditation.png',
              context: context,
            ),
            _buildExerciseCard(
              title: context.locale.languageCode == 'ar'
                  ? "تأمل التنفس"
                  : "Breathing Meditation",
              description: context.locale.languageCode == 'ar'
                  ? "تمارين تركز على مراقبة التنفس والتحكم فيه لتهدئة العقل والجسم."
                  : "Exercises that focus on observing and controlling your breathing to calm the mind and body.",
              fullDescription: context.locale.languageCode == 'ar'
                  ? '''
1. اجلس في مكان هادئ ومريح.
2. ضع يديك على بطنك وابدأ في التنفس ببطء.
3. خذ نفسًا عميقًا من خلال الأنف، وافتح بطنك أثناء الشهيق.
4. أخرج النفس ببطء من خلال الفم، مع محاولة إفراغ الرئتين بالكامل.
5. كرر هذا التنفس العميق لمدة 8 دقائق.
'''
                  : '''
1. Sit in a quiet and comfortable place.
2. Place your hands on your belly and start breathing slowly.
3. Inhale deeply through your nose, expanding your belly.
4. Exhale slowly through your mouth, trying to empty your lungs completely.
5. Repeat this deep breathing for 8 minutes.
''',
              duration: context.locale.languageCode == 'ar'
                ? "٨دقائق"
                : "8 minutes",
              imageUrl: 'assets/breathing.png',
              context: context,
            ),
            _divider(),
            _buildSectionTitle(context.locale.languageCode == 'ar'
                ? "تمارين الاسترخاء"
                : "Relaxation Exercises",),
            _divider(),
            _buildExerciseCard(
              title: context.locale.languageCode == 'ar'
                  ? "الاسترخاء العضلي التدريجي"
                  : "Progressive Muscle Relaxation",
              description: context.locale.languageCode == 'ar'
                  ? "تمارين تتضمن شد وإرخاء مجموعات عضلية مختلفة لتقليل التوتر"
                  : "Exercises that involve tensing and relaxing different muscle groups to reduce Tension.",
                fullDescription: context.locale.languageCode == 'ar'
                    ? '''
1. استلقِ في مكان مريح وأغمض عينيك.
2. ابدأ بشد عضلات القدمين لمدة 5 ثواني ثم استرخِ.
3. انتقل إلى عضلات الساقين، شدها لمدة 5 ثواني ثم استرخِ.
4. كرر العملية مع باقي العضلات: الفخذين، البطن، الذراعين، الكتفين، الوجه.
5. في كل مرة، حاول أن تشعر بالفرق بين الشد والاسترخاء.
6. استمر في ذلك لمدة 12 دقيقة.
'''
                    : '''
1. Lie down in a comfortable place and close your eyes.
2. Start by tensing your foot muscles for 5 seconds, then relax.
3. Move to your leg muscles, tense them for 5 seconds, then relax.
4. Repeat the process for other muscles: thighs, abdomen, arms, shoulders, face.
5. Each time, try to feel the difference between tension and relaxation.
6. Continue for 12 minutes.
''',
              duration: context.locale.languageCode == 'ar'
                ? " ١٢دقيقه"
                : "12 minutes",
              imageUrl: 'assets/relaxation.png',
              context: context,
            ),
            _divider(),
            _buildSectionTitle(context.locale.languageCode == 'ar'
                ? "تمارين التنفس العميق"
                : "Deep Breathing Exercises",),
            _divider(),
            _buildExerciseCard(
              title: context.locale.languageCode == 'ar'
                  ? "تنفس البطن"
                  : "Abdominal Breathing",
              description: context.locale.languageCode == 'ar'
                  ? "تمرين يركز على استخدام الحجاب الحاجز للتنفس بشكل أعمق"
                  : "An exercise that focuses on using the diaphragm to breathe more deeply.",
              fullDescription: context.locale.languageCode == 'ar'
                  ? '''
1. استلقِ على ظهرك في مكان مريح.
2. ضع يدك على بطنك لتشعر بحركة تنفسك.
3. خذ نفسًا عميقًا من خلال الأنف، مما يملأ بطنك بالهواء.
4. ثم أخرج النفس ببطء عبر الفم، مع محاولة إفراغ بطنك بالكامل.
5. استمر في هذا التمرين لمدة 5 دقائق.
'''
                  : '''
1. Lie on your back in a comfortable place.
2. Place your hand on your belly to feel your breathing movement.
3. Take a deep breath through your nose, filling your belly with air.
4. Then exhale slowly through your mouth, trying to empty your belly completely.
5. Continue this exercise for 5 minutes.
''',
              duration: context.locale.languageCode == 'ar'
                ? " 5 دقائق."
                : "5 minutes",
              imageUrl: 'assets/deepbreath.png',
              context: context,
            ),
            _divider(),
            _buildSectionTitle(context.locale.languageCode == 'ar'
                ? "استراتيجيات إدارة التوتر والقلق"
                : "Stress and Anxiety Management Strategies",),
            _divider(),
            _buildExerciseCard(
              title: context.locale.languageCode == 'ar'
                  ? "كتابة اليوميات"
                  : "Journal Writing",
              description: context.locale.languageCode == 'ar'
                  ? "تشجيع المستخدمين على كتابة أفكارهم ومشاعرهم"
                  : "Encourage users to write down their thoughts and feelings",
              fullDescription: context.locale.languageCode == 'ar'
                  ? '''
1. خصص 10 دقائق يوميًا لكتابة أفكارك.
2. اكتب مشاعرك الحالية بدون تقييم أو حكم.
3. يمكنك الكتابة عن أي موضوع يشغل بالك في اللحظة.
4. تذكر أن تكون صادقًا مع نفسك في الكتابة.
5. قم بتدوين أي أفكار تأتي إلى ذهنك بدون أن تشعر بالضغط.
6. حاول فعل ذلك يوميًا لتخفيف التوتر والمشاعر السلبية.
'''
                  : '''
1. Dedicate 10 minutes daily to writing your thoughts.
2. Write about your current emotions without judgment.
3. You can write about any topic that’s on your mind at the moment.
4. Remember to be honest with yourself in your writing.
5. Jot down any thoughts that come to mind without pressure.
6. Try to do this daily to relieve stress and negative emotions.
''',
              duration:context.locale.languageCode == 'ar'
                ? "قليل من الوقت يومي"
                : "A little time every day",
              imageUrl: 'assets/journal.png',
              context: context,
            ),
            _divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        fontFamily: 'Tajawal',
      ),
    );
  }

  Widget _divider() {
    return Divider(
      color: Colors.orange.shade100,
      thickness: 1,
    );
  }

  Widget _buildExerciseCard({
    required String title,
    required String description,
    required String fullDescription,
    required String duration,
    required BuildContext context,
    required String imageUrl,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseDetailPage(
              title: title,
              description: description,
              fullDescription: fullDescription,
              duration: duration,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 6,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink.shade100, Colors.orange.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Image.asset(imageUrl, height: 50, width: 50),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      context.locale.languageCode == 'ar'
                          ? 'المدة: $duration دقيقة'
                          : 'Duration: $duration ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
