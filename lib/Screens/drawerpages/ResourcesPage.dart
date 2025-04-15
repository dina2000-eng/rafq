import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ResourcesPage extends StatelessWidget {
  // final List<String> categories = [
  //   context.locale.languageCode == 'ar'
  //       ? "القلق والتوتر"
  //       : "Anxiety and Stress",
  //   context.locale.languageCode == 'ar'
  //       ? "الاكتئاب"
  //       : "Depression",
  //   context.locale.languageCode == 'ar'
  //       ? "اضطرابات النوم"
  //       : "Sleep Disorders",
  //   context.locale.languageCode == 'ar'
  //       ? "إدارة الضغوط"
  //       : "Stress Management",
  //   context.locale.languageCode == 'ar'
  //       ? "العلاقات الاجتماعية"
  //       : "Social Relationships",
  //   context.locale.languageCode == 'ar'
  //       ? "تقدير الذات والثقة بالنفس"
  //       : "Self-Esteem and Confidence",
  //   context.locale.languageCode == 'ar'
  //       ? "الصحة النفسية للأطفال والمراهقين"
  //       : "Mental Health for Children and Adolescents",
  //   context.locale.languageCode == 'ar'
  //       ? "الصحة النفسية لكبار السن"
  //       : "Mental Health for Seniors",
  //   context.locale.languageCode == 'ar'
  //       ? "الصدمات النفسية والتعافي منها"
  //       : "Psychological Trauma and Recovery",
  //   context.locale.languageCode == 'ar'
  //       ? "التغذية والصحة النفسية"
  //       : "Nutrition and Mental Health",
  //   context.locale.languageCode == 'ar'
  //       ? "اليقظة الذهنية، التأمل، الاسترخاء"
  //       : "Mindfulness, Meditation, and Relaxation",
  // ];
  //
  // final List<Map<String, String>> articles = [
  //   {
  //     'title': context.locale.languageCode == 'ar'
  //         ? 'كيفية التعامل مع القلق'
  //         : 'How to Deal with Anxiety',
  //     'description': context.locale.languageCode == 'ar'
  //         ? 'نصائح عملية للتعامل مع القلق والتوتر اليومي.'
  //         : 'Practical tips for managing daily anxiety and stress.',
  //     'category': context.locale.languageCode == 'ar'
  //         ? 'القلق والتوتر'
  //         : 'Anxiety and Stress',
  //     'image': 'assets/anxiety.webp',
  //     'content': context.locale.languageCode == 'ar'
  //         ? '1. تدرب على التفكير الإيجابي\n'
  //         '2. استخدم التدوين لإخراج مشاعرك\n'
  //         '3. جرب العقلانية\n'
  //         '4. تهدئة الجهاز العصبي باستخدام التنفس الحجابي (التنفس العميق).\n'
  //         '5. تغلبْ على الخوف من خلال التحدث بلطف إلى نفسك للخروج من هذه الحالة.'
  //         : '1. Practice positive thinking\n'
  //         '2. Use journaling to express your feelings\n'
  //         '3. Try rational thinking\n'
  //         '4. Calm your nervous system using diaphragmatic breathing (deep breathing)\n'
  //         '5. Overcome fear by speaking kindly to yourself to break out of the anxious state.'
  //   },
  //   {
  //     'title': context.locale.languageCode == 'ar'
  //         ? 'أهمية النوم الجيد للصحة النفسية'
  //         : 'The Importance of Good Sleep for Mental Health',
  //     'description': context.locale.languageCode == 'ar'
  //         ? 'كيف يؤثر النوم الجيد على صحتنا النفسية.'
  //         : 'How quality sleep affects our mental well-being.',
  //     'category': context.locale.languageCode == 'ar'
  //         ? 'اضطرابات النوم'
  //         : 'Sleep Disorders',
  //     'image': 'assets/sleep.webp',
  //     'content': context.locale.languageCode == 'ar'
  //         ? '* لساعات النوم أهمية كبيرة في حياة أي إنسان منذ لحظة ولادته. في الواقع، يعد النوم ضروريًا لنمو الأطفال والرضع بشكل صحيح ونموهم الجسدي والنفسي.\n'
  //         '* لدى البالغين، تؤثر نوعية النوم بشكل مباشر على أنشطتهم المعتادة، حيث تحدث الراحة واسترخاء العضلات خلال ساعات النوم، ويقلل من معدل التنفس. علاوة على ذلك، يرتبط النوم بالمزاج، مع ملاحظة أن الاضطرابات النفسية مثل القلق أو الاكتئاب تكون أكثر شيوعًا لدى الأشخاص الذين يعانون من ضعف نوعية النوم.\n'
  //         '* يتأثر النوم بهرمونين رئيسيين: الكورتيزول والميلاتونين. الأول هو هرمون التوتر، ويتركز في الدم خلال الساعات الأولى من الصباح، مما يجعل الإنسان نشيطاً. إلا أن الميلاتونين هو هرمون النوم، ويزداد التركيز عند حلول الليل، مما يجعل الإنسان في حالة من الاسترخاء. هذا التوازن في الهرمونات ضروري للناس للحصول على نوم جيد.\n'
  //         : '* Sleep hours play a significant role in every person’s life from birth. In fact, sleep is essential for the proper physical and psychological growth of infants and children.\n'
  //         '* For adults, sleep quality directly affects their daily activities, as relaxation and muscle recovery occur during sleep hours, reducing the respiratory rate. Additionally, sleep is closely linked to mood, with psychological disorders like anxiety and depression being more common among those with poor sleep quality.\n'
  //         '* Sleep is influenced by two key hormones: cortisol and melatonin. Cortisol, the stress hormone, is at its highest in the early morning, keeping people alert. On the other hand, melatonin, the sleep hormone, increases at night, inducing relaxation. This hormonal balance is crucial for achieving good sleep.\n'
  //   },
  // ];

  ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      context.locale.languageCode == 'ar' ? "القلق والتوتر" : "Anxiety and Stress",
      context.locale.languageCode == 'ar' ? "الاكتئاب" : "Depression",
      context.locale.languageCode == 'ar' ? "اضطرابات النوم" : "Sleep Disorders",
      context.locale.languageCode == 'ar' ? "إدارة الضغوط" : "Stress Management",
      context.locale.languageCode == 'ar' ? "العلاقات الاجتماعية" : "Social Relationships",
      context.locale.languageCode == 'ar' ? "تقدير الذات والثقة بالنفس" : "Self-Esteem and Confidence",
      context.locale.languageCode == 'ar' ? "الصحة النفسية للأطفال والمراهقين" : "Mental Health for Children and Adolescents",
      context.locale.languageCode == 'ar' ? "الصحة النفسية لكبار السن" : "Mental Health for Seniors",
      context.locale.languageCode == 'ar' ? "الصدمات النفسية والتعافي منها" : "Psychological Trauma and Recovery",
      context.locale.languageCode == 'ar' ? "التغذية والصحة النفسية" : "Nutrition and Mental Health",
      context.locale.languageCode == 'ar' ? "اليقظة الذهنية، التأمل، الاسترخاء" : "Mindfulness, Meditation, and Relaxation",
    ];

    final List<Map<String, String>> articles = [
      {
        'title': context.locale.languageCode == 'ar' ? 'كيفية التعامل مع القلق' : 'How to Deal with Anxiety',
        'description': context.locale.languageCode == 'ar' ? 'نصائح عملية للتعامل مع القلق والتوتر اليومي.' : 'Practical tips for managing daily anxiety and stress.',
        'category': context.locale.languageCode == 'ar' ? 'القلق والتوتر' : 'Anxiety and Stress',
        'image': 'assets/anxiety.webp',
        'content': context.locale.languageCode == 'ar'
            ? '1. تدرب على التفكير الإيجابي\n2. استخدم التدوين لإخراج مشاعرك\n3. جرب العقلانية\n4. تهدئة الجهاز العصبي باستخدام التنفس الحجابي (التنفس العميق).\n5. تغلبْ على الخوف من خلال التحدث بلطف إلى نفسك للخروج من هذه الحالة.'
            : '1. Practice positive thinking\n2. Use journaling to express your feelings\n3. Try rational thinking\n4. Calm your nervous system using diaphragmatic breathing (deep breathing)\n5. Overcome fear by speaking kindly to yourself to break out of the anxious state.'
      },
      {
        'title': context.locale.languageCode == 'ar' ? 'أهمية النوم الجيد للصحة النفسية' : 'The Importance of Good Sleep for Mental Health',
        'description': context.locale.languageCode == 'ar' ? 'كيف يؤثر النوم الجيد على صحتنا النفسية.' : 'How quality sleep affects our mental well-being.',
        'category': context.locale.languageCode == 'ar' ? 'اضطرابات النوم' : 'Sleep Disorders',
        'image': 'assets/sleep.webp',
        'content': context.locale.languageCode == 'ar'
            ? '* لساعات النوم أهمية كبيرة في حياة أي إنسان منذ لحظة ولادته. في الواقع، يعد النوم ضروريًا لنمو الأطفال والرضع بشكل صحيح ونموهم الجسدي والنفسي.\n* لدى البالغين، تؤثر نوعية النوم بشكل مباشر على أنشطتهم المعتادة، حيث تحدث الراحة واسترخاء العضلات خلال ساعات النوم، ويقلل من معدل التنفس. علاوة على ذلك، يرتبط النوم بالمزاج، مع ملاحظة أن الاضطرابات النفسية مثل القلق أو الاكتئاب تكون أكثر شيوعًا لدى الأشخاص الذين يعانون من ضعف نوعية النوم.\n* يتأثر النوم بهرمونين رئيسيين: الكورتيزول والميلاتونين. الأول هو هرمون التوتر، ويتركز في الدم خلال الساعات الأولى من الصباح، مما يجعل الإنسان نشيطاً. إلا أن الميلاتونين هو هرمون النوم، ويزداد التركيز عند حلول الليل، مما يجعل الإنسان في حالة من الاسترخاء. هذا التوازن في الهرمونات ضروري للناس للحصول على نوم جيد.'
            : '* Sleep hours play a significant role in every person’s life from birth. In fact, sleep is essential for the proper physical and psychological growth of infants and children.\n* For adults, sleep quality directly affects their daily activities, as relaxation and muscle recovery occur during sleep hours, reducing the respiratory rate. Additionally, sleep is closely linked to mood, with psychological disorders like anxiety and depression being more common among those with poor sleep quality.\n* Sleep is influenced by two key hormones: cortisol and melatonin. Cortisol, the stress hormone, is at its highest in the early morning, keeping people alert. On the other hand, melatonin, the sleep hormone, increases at night, inducing relaxation. This hormonal balance is crucial for achieving good sleep.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "الموارد والمقالات"
            : "Resources and articles",style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.teal,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {
        //     },
        //   ),
       // ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              context.locale.languageCode == 'ar'
                  ? "تصنيفات المقالات"
                  : "Article Categories",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal,fontFamily: 'Tajawal',),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryPage(category: categories[index], content: '',),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.teal[50],
                    child: Center(
                      child: Text(
                        categories[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.black87,fontFamily: 'Tajawal',),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              context.locale.languageCode == 'ar'
                  ? "المقالات الموصى بها"
                  : "Recommended Articles",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal,fontFamily: 'Tajawal',),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticlePage(article: articles[index]),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    child: ListTile(
                      leading: Image.asset(
                        articles[index]['image']!,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                      title: Text(articles[index]['title']!, style: TextStyle(fontSize: 14,fontFamily: 'Tajawal',)),
                      subtitle: Text(articles[index]['description']!, style: TextStyle(fontSize: 12,fontFamily: 'Tajawal',)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String category;
  final String content;

  CategoryPage({required this.category, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category',style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content,
                style: TextStyle(fontSize: 18,fontFamily: 'Tajawal',),
              ),
              if (category == 'القلق والتوتر'.tr()) ...[
                Text(
                  context.locale.languageCode == 'ar'
                      ? "القلق والتوتر هما من أكثر الحالات النفسية شيوعًا. يمكن أن يحدث القلق بسبب الخوف من المستقبل أو مواقف غير معروفة. أما التوتر فيحدث بسبب ضغوط الحياة اليومية. من المهم تعلم تقنيات الاسترخاء مثل التنفس العميق، اليوغا، أو التأمل لتقليل الأعراض.\n"
                      "يعد التوتر جزء طبيعي من الحياة، وقد يكون ناتجاً عن عوامل بيئية أو جسمية أو فكرية. ولا يشترط أن يكون التوتر أمر سلبي، بل إن التغيرات الإيجابية في الحياة مثل الحصول على ترقية، أو ولادة الطفل قد تؤدي إلى حدوث التوتر النفسي.\n"
                      "تنتج اضطرابات القلق، مثل سائر حالات الصحة النفسية، عن تفاعل معقَّد بين عوامل اجتماعية ونفسية وبيولوجية. ويمكن لأي شخص أن يُصَاب بأحد أنواع اضطرابات القلق، لكن الأشخاص الذين مروا بتجارب من سوء المعاملة أو الخسائر الفادحة أو غيرها من التجارب السلبية يكونون أكثر عرضة للإصابة بأحد هذه الاضطرابات.\n"
                      "يمكن أن تؤدي الرعاية الذاتية دوراً مهماً في العلاج الداعم. ولكي يكون لك دور مساعد في التدبير العلاجي لأعراض القلق لديك وتحسين سلامتك النفسية عموماً، يمكنك اتباع ما يأتي:\n"
                      "* تجنب الكحول أو التقليل منه، وعدم تعاطي المخدرات غير المشروعة التي قد تؤدي إلى تفاقم الشعور بالقلق;\n"
                      "* ممارسة الرياضة بانتظام، حتى لو كان ذلك مجرد المشي مسافة قصيرة;\n"
                      "* اكتساب عادة التأمل عن طريق اليقظة الذهنية، حتى لو كان ذلك لبضع دقائق يوماً."
                      : "Anxiety and stress are among the most common mental health conditions. Anxiety can occur due to fear of the future or unknown situations. Stress, on the other hand, occurs due to the pressures of daily life. It's important to learn relaxation techniques such as deep breathing, yoga, or meditation to reduce symptoms.\n"
                      "Stress is a normal part of life and can be caused by environmental, physical, or mental factors. Stress is not necessarily negative; in fact, positive changes in life, such as getting a promotion or having a baby, can lead to psychological stress.\n"
                      "Anxiety disorders, like other mental health conditions, are caused by a complex interaction of social, psychological, and biological factors. Anyone can experience an anxiety disorder, but people who have gone through experiences of abuse, loss, or other negative events are more likely to develop one.\n"
                      "Self-care can play an important role in supportive treatment. To assist in managing anxiety symptoms and improving your overall mental well-being, consider the following:\n"
                      "* Avoid alcohol or reduce intake, and refrain from using illegal drugs that can worsen anxiety;\n"
                      "* Exercise regularly, even if it's just a short walk;\n"
                      "* Develop a mindfulness meditation habit, even if it's just for a few minutes a day.",
                  style: TextStyle(fontSize: 18,fontFamily: 'Tajawal',),
                )
              ],
              if (category == 'الاكتئاب'.tr()) ...[
                Text(
                  context.locale.languageCode == 'ar'
                      ? "الاكتئاب هو حالة نفسية تتميز بالحزن العميق وفقدان الاهتمام بالأشياء. قد يؤدي الاكتئاب إلى تدهور الأداء اليومي وصعوبة التفاعل مع البيئة المحيطة. العلاج يتضمن العلاج النفسي، الأدوية، وتغيير نمط الحياة مثل ممارسة الرياضة والنوم الجيد.\n"
                      "يعاني المكتئب خلال نوبة الاكتئاب من تكدّر المزاج (الشعور بالحزن وسرعة الغضب والفراغ). وقد يشعر بفقدان الاستمتاع أو الاهتمام بالأنشطة.\n"
                      "وتختلف نوبة الاكتئاب عن تقلبات المزاج المعتادة. وتستمر معظم اليوم، وتحدث كل يوم تقريباً، لمدة أسبوعين على الأقل.\n"
                      "وهناك أيضاً أعراض أخرى للاكتئاب، منها ما يلي:\n"
                      "1. ضعف التركيز\n"
                      "2. الإفراط في الشعور بالذنب أو ضعف تقدير الذات\n"
                      "3. تقلبات الشهية أو الوزن\n"
                      "* من شأن الرعاية الذاتية أن تؤدي دوراً مهماً في معالجة أعراض الاكتئاب وأن تُعزّز العافية في العموم، هذا ما يمكننا فعله:\n"
                      "حاول أن تستمر في الأنشطة التي اعتدت أن تستمتع بها\n"
                      "التزم بعادات الأكل والنوم المنتظمة قدر الإمكان\n"
                      "تحدث إلى شخص تثق به عن مشاعرك\n"
                      : "Depression is a mental health condition characterized by deep sadness and a loss of interest in things. It may lead to a decline in daily functioning and difficulty interacting with the surrounding environment. Treatment includes psychotherapy, medications, and lifestyle changes like exercise and adequate sleep.\n"
                      "During a depressive episode, the individual may experience mood disturbances (feeling sad, irritable, or empty). They may also lose interest in activities that were once enjoyable.\n"
                      "Depressive episodes differ from regular mood swings. They last most of the day and occur nearly every day for at least two weeks.\n"
                      "Other symptoms of depression may include:\n"
                      "1. Difficulty concentrating\n"
                      "2. Excessive feelings of guilt or low self-esteem\n"
                      "3. Changes in appetite or weight\n"
                      "Self-care plays an important role in managing depression symptoms and enhancing overall well-being. Here’s what can help:\n"
                      "Continue doing activities you once enjoyed\n"
                      "Stick to regular eating and sleeping habits as much as possible\n"
                      "Talk to someone you trust about your feelings\n",
                  style: TextStyle(fontSize: 18,fontFamily: 'Tajawal',),
                ),
],
    if (category == 'اضطرابات النوم'.tr()) ...[
    Text(
    context.locale.languageCode == 'ar'
    ? "اضطرابات النوم هي مشكلة تؤثر على جودة النوم. تشمل الأعراض صعوبة النوم أو الاستيقاظ المتكرر أثناء الليل. لعلاج اضطرابات النوم يجب اتباع نظام نوم منتظم، تجنب المنبهات قبل النوم، والابتعاد عن الشاشات في الليل.\n"
    "اضطراب النوم يمكنه التأثير في صحتك العامة وسلامتك وجودة حياتك. يمكن أن يؤثر عدم الحصول على قدرٍ كافٍ من النوم ليلاً في قدرتك على القيادة أو العمل بأمان. كما قد يزيد من خطر إصابتك بمشكلات صحية أخرى. لكن يمكن أن يساعدك العلاج على الحصول على قسط النوم الذي تحتاج إليه.\n"
    "تتضمن أعراض اضطرابات النوم الشائعة ما يأتي:\n"
    "1. الشعور بالنعاس الشديد خلال ساعات النهار. قد تنام في أوقات ليست طبيعية، مثل أثناء القيادة أو أثناء العمل على مكتبك.\n"
    "2. التنفس بطريقة غير طبيعية. قد يشمل ذلك الغطيط، أو الشخير، أو الشهيق، أو الاختناق، أو توقف التنفس مؤقتًا.\n"
    "3. الحركة كثيرًا أو فعل بحركات تزعجك أثناء النوم، مثل حركة الذراعين والساقين أو صرير الأسنان.\n"
    "الحالات التي تستلزم استشارة الطبيب:\n"
    "يمكن أن يمر أي شخص بليلة لا ينام فيها بشكل جيد من حين إلى آخر. ولكن تحدث إلى الطبيب أو اختصاصي الرعاية الصحية إذا كنت تواجه صعوبة مستمرة في الحصول على قسط كافٍ من النوم، أو إذا لم تشعر بالراحة عند الاستيقاظ، أو إذا كنت تشعر بالنعاس المفرط خلال النهار."
        : "Sleep disorders are an issue that affects sleep quality. Symptoms include difficulty sleeping or frequent waking during the night. To treat sleep disorders, it is important to follow a regular sleep schedule, avoid stimulants before bed, and stay away from screens at night.\n"
    "Sleep disorders can affect your overall health, safety, and quality of life. Not getting enough sleep at night can affect your ability to drive or work safely. It may also increase the risk of other health problems. Treatment can help you get the sleep you need.\n"
    "Common symptoms of sleep disorders include:\n"
    "1. Excessive daytime drowsiness. You might sleep at unusual times, such as while driving or at your desk.\n"
    "2. Abnormal breathing. This can include snoring, gasping, choking, or temporary cessation of breathing.\n"
    "3. Excessive movement or actions during sleep, like leg and arm movements or teeth grinding.\n"
    "When to see a doctor:\n"
    "Anyone can experience a night of poor sleep from time to time, but see a doctor if you have trouble getting enough sleep consistently, if you don't feel refreshed when waking up, or if you're excessively drowsy during the day.",
    style: TextStyle(fontSize: 18,fontFamily: 'Tajawal',),
    ),
    ],

    if (category == 'إدارة الضغوط'.tr()) ...[
    Text(
    context.locale.languageCode == 'ar'
    ? "إدارة الضغوط هي مهارة أساسية للحفاظ على الصحة النفسية. تقنيات مثل التنفس العميق، ممارسة الرياضة، تخصيص وقت للاسترخاء، وتنظيم الوقت يمكن أن تساعد في تقليل الضغوط اليومية وتحسين الحالة النفسية.\n"
    "أول علامات الضغط النفسي هي:\n"
    " الانفعالية\n"
    "مشاكل النوم\n"
    "نصائح للتخلص من الضغوطات النفسية عبر المساعدة الذاتية\n"
    "الفترات القصيرة من التوتر تعد طبيعية وغالبا ما يمكن حلها من خلال شيء بسيط، مثل استكمال مهمة (وبالتالي الحد من عبء العمل)، أو من خلال التحدث إلى الآخرين وأخذ الوقت للاسترخاء. واحد أو أكثر من الاقتراحات التالية قد يساعد:\n"
    "• قم بتقييم ما في حياتك بالضبط لتعرف مصدر قلقك. فعلى سبيل المثال، هل أنت قلق بشأن الامتحانات أم المال أم المشاكل المتعلقة بالعلاقات؟ انظر ما إن كان يمكنك تغيير ظروفك لتخفيف الضغط عن نفسك.\n"
    "• تعلم الاسترخاء. فإن أصبت بنوبة هلع أو بضغط نفسي، فحاول التركيز على شيء خارج نفسك، أو قم بمشاهدة التلفزيون أو التحدث إلى شخص ما. قد يساعد الاسترخاء وتمارين التنفس في ذلك\n"
    "• حاول القيام بحل المشاكل الشخصية من خلال التحدث إلى أحد الأصدقاء أو أستاذك أو أحد أفراد عائلتك.\n"
        : "Stress management is an essential skill for maintaining mental health. Techniques such as deep breathing, exercise, setting aside time for relaxation, and time management can help reduce daily stress and improve mental well-being.\n"
    "The first signs of stress are:\n"
    " Emotional reactions\n"
    "Sleep problems\n"
    "Tips for self-help in dealing with stress\n"
    "Short periods of stress are normal and can often be resolved by something simple, like completing a task (thus reducing your workload) or talking to others and taking time to relax. One or more of the following suggestions may help:\n"
    "• Assess what's specifically in your life to know your stress source. For example, are you worried about exams, money, or relationship problems? See if you can change your circumstances to ease the pressure on yourself.\n"
    "• Learn to relax. If you're having a panic attack or stressed, try focusing on something outside yourself, or watching TV or talking to someone. Relaxation and breathing exercises can help.\n"
    "• Try solving personal issues by talking to a friend, a teacher, or a family member.",
    style: TextStyle(fontSize: 18,fontFamily: 'Tajawal',),
    ),
    ],

    if (category == 'العلاقات الاجتماعية'.tr()) ...[
    Text(
    context.locale.languageCode == 'ar'
    ? "العلاقات الاجتماعية الجيدة ضرورية للصحة النفسية. تعزيز العلاقات مع الأصدقاء والعائلة، والتواصل المفتوح، ودعم الآخرين يمكن أن يقلل من التوتر ويعزز من الشعور بالانتماء.\n"
    ":العلاقات الاجتماعية الجيّدة لها العديد من الفوائد، ونذكر منها ما يأتي\n"
    "1. تقليل خطر الإصابة بالقلق والاكتئاب\n"
    "2. تعزيز احتراك النفس.\n"
    "3. تحسين العاطفة بين الأفراد\n"
    "4. تعزيز الثقة والعلاقات التعاونية\n"
        : "Good social relationships are essential for mental health. Strengthening relationships with friends and family, maintaining open communication, and supporting others can reduce stress and enhance the feeling of belonging.\n"
    "Good social relationships have many benefits, including:\n"
    "1. Reducing the risk of anxiety and depression\n"
    "2. Enhancing self-esteem\n"
    "3. Improving emotional bonds between individuals\n"
    "4. Boosting trust and collaborative relationships",
    style: TextStyle(fontSize: 18,fontFamily: 'Tajawal',),
    ),
    ],

    if (category == 'تقدير الذات والثقة بالنفس'.tr()) ...[
    Text(
    context.locale.languageCode == 'ar'
    ? "تقدير الذات والثقة بالنفس هما الأساس للنجاح الشخصي والصحة النفسية. بناء الثقة بالنفس يتطلب العمل على تقوية مهارات الفرد، التفكير الإيجابي، والاعتناء بالنفس.\n"
    "للثقة بالنفس وتقدير الذات أهمية كبيرة في حياة الفرد النفسية والاجتماعية، وذُكرت هذه الأهمية على النحو الآتي\n"
    "* تحقيق التوافق النفسي\n"
    "* اكتساب الخبرات\n"
    "* النجاح في العمل\n"
    "* محبة المجتمع\n"
    "* مواجهة المشكلات\n"
    "الثقة بالنفس وتقدير الذات هما من أهم السمات الشخصية التي يجب أن يتمتع بها الفرد، فهما الطريق للنجاح الذاتي وتحقيق التوافق الاجتماعي، إلا أنه توجد الكثير من المعوقات التي من شأنها أن تؤثر على معدل ثقة الفرد بنفسه وتقديرها، منها:\n"
    "* المعوقات الصحية\n"
    "* المعوقات الوجدانية\n"
    "* المعوقات العقلية\n"
    "* المعوقات الاقتصادية\n"
        : "Self-esteem and self-confidence are the foundation for personal success and mental health. Building self-confidence requires working on strengthening one's skills, positive thinking, and self-care.\n"
    "Self-confidence and self-esteem are crucial in an individual's psychological and social life, with the following importance:\n"
    "* Achieving psychological alignment\n"
    "* Gaining experiences\n"
    "* Success in work\n"
    "* Community affection\n"
    "* Facing problems\n"
    "Self-confidence and self-esteem are two of the most important personality traits a person must possess, as they are the path to personal success and achieving social harmony. However, there are many obstacles that can affect a person's confidence and self-esteem, including:\n"
    "* Health obstacles\n"
    "* Emotional obstacles\n"
    "* Mental obstacles\n"
    "* Economic obstacles\n",
    style: TextStyle(fontSize: 18,fontFamily: 'Tajawal',),
    ),
    ],

    if (category == 'الصحة النفسية للأطفال والمراهقين'.tr()) ...[
    Text(
    context.locale.languageCode == 'ar'
    ? "الصحة النفسية للأطفال والمراهقين هي جزء أساسي من نموهم الشامل. تربية الطفل على مهارات التعامل مع التوتر، وتعزيز ثقته بنفسه، والاهتمام بتعليمه كيف يواجه التحديات العاطفية يمكن أن يعزز صحته النفسية.\n"
    "كما أن: تحسين صحة الأطفال والمراهقين النفسية هو جزء من الجهود الكبيرة للحفاظ على رفاهية الأطفال والمجتمع.\n"
    "إليك بعض التوجيهات لتحسين الصحة النفسية للأطفال والمراهقين:\n"
    "1. تعلم التعامل مع القلق والخوف.\n"
    "2. تعزيز مهارات التواصل.\n"
    "3. تعليمهم تقنيات التنفس والاسترخاء.\n"
    "4. الاهتمام بالحياة الاجتماعية والأنشطة الترفيهية.\n"
    "5. الدعم العاطفي من الأهل والأصدقاء.\n"
        : "Mental health for children and adolescents is a crucial part of their overall growth. Teaching children how to manage stress, enhancing their self-confidence, and educating them on how to cope with emotional challenges can improve their mental well-being.\n"
    "Furthermore, improving the mental health of children and adolescents is part of the larger efforts to ensure the well-being of children and the community.\n"
    "Here are some guidelines to enhance mental health for children and adolescents:\n"
    "1. Learn to deal with anxiety and fear.\n"
    "2. Enhance communication skills.\n"
    "3. Teach breathing and relaxation techniques.\n"
    "4. Support social life and recreational activities.\n"
    "5. Emotional support from family and friends.",
    style: TextStyle(fontSize: 18,fontFamily: 'Tajawal',),
    ),
    ],
              if (category == 'الصحة النفسية لكبار السن'.tr()) ...[
                Text(
                  context.locale.languageCode == 'ar'
                      ? "تُعتبر الصحة النفسية لكبار السن من الأمور الحيوية للحفاظ على جودة الحياة. مع التقدم في العمر، يواجه الأشخاص تحديات نفسية واجتماعية تتطلب اهتماماً خاصاً، مثل الشعور بالوحدة والتغيرات الجسدية والانعزال الاجتماعي. من المهم دعم كبار السن من خلال:\n"
                      "• توفير بيئة اجتماعية مشجعة وآمنة\n"
                      "• تشجيع الأنشطة البدنية والذهنية\n"
                      "• تقديم الدعم النفسي والاستشارات عند الحاجة\n"
                      : "Mental health in older adults is crucial for maintaining a good quality of life. As people age, they face psychological and social challenges such as loneliness, physical changes, and social isolation. It is important to support older adults by:\n"
                      "• Providing a supportive and safe social environment\n"
                      "• Encouraging physical and mental activities\n"
                      "• Offering psychological support and counseling when needed",
                  style: TextStyle(fontSize: 18, fontFamily: 'Tajawal'),
                )
              ],
              if (category == 'الصدمات النفسية والتعافي منها'.tr()) ...[
                Text(
                  context.locale.languageCode == 'ar'
                      ? "الصدمات النفسية يمكن أن تترك أثراً عميقاً على الصحة النفسية، لكن التعافي منها ممكن بدعم مناسب واتباع استراتيجيات علاجية فعالة. يعتمد التعافي على:\n"
                      "• قبول الصدمة والتعبير عن المشاعر\n"
                      "• تلقي الدعم النفسي من مختصين أو من الدائرة الاجتماعية\n"
                      "• استخدام تقنيات العلاج مثل العلاج السلوكي المعرفي والعلاج بالتعرض\n"
                      "• ممارسة تقنيات الاسترخاء والتنفس العميق\n"
                      : "Psychological trauma can deeply impact mental health, but recovery is possible with proper support and effective treatment strategies. Recovery relies on:\n"
                      "• Accepting the trauma and expressing emotions\n"
                      "• Receiving psychological support from professionals or social circles\n"
                      "• Using therapeutic techniques such as cognitive-behavioral therapy and exposure therapy\n"
                      "• Practicing relaxation and deep breathing techniques",
                  style: TextStyle(fontSize: 18, fontFamily: 'Tajawal'),
                )
              ],
              if (category == 'التغذية والصحة النفسية'.tr()) ...[
                Text(
                  context.locale.languageCode == 'ar'
                      ? "تلعب التغذية دوراً مهماً في دعم الصحة النفسية، إذ أن النظام الغذائي المتوازن يساعد في تحسين المزاج وتقليل التوتر. يُنصح باتباع نظام غذائي يحتوي على:\n"
                      "• أطعمة غنية بالأوميغا-3 مثل الأسماك والمكسرات\n"
                      "• الفواكه والخضروات الطازجة التي تزود الجسم بالفيتامينات والمعادن\n"
                      "• تقليل تناول السكر والكافيين الذي قد يؤدي لارتفاع مستويات القلق\n"
                      : "Nutrition plays an important role in supporting mental health, as a balanced diet helps improve mood and reduce stress. It is advisable to follow a diet that includes:\n"
                      "• Omega-3 rich foods like fish and nuts\n"
                      "• Fresh fruits and vegetables that provide essential vitamins and minerals\n"
                      "• Reducing the intake of sugar and caffeine, which can lead to increased anxiety",
                  style: TextStyle(fontSize: 18, fontFamily: 'Tajawal'),
                )
              ],
              if (category == 'اليقظة الذهنية، التأمل، الاسترخاء'.tr()) ...[
                Text(
                  context.locale.languageCode == 'ar'
                      ? "ليقظة الذهنية والتأمل والاسترخاء هي أدوات فعالة لتحسين الصحة النفسية وتقليل مستويات التوتر. تساعد هذه الممارسات على توجيه الانتباه للحظة الحالية وتخفيف الأفكار السلبية. من بين الفوائد:\n"
                      "• تحسين التركيز والذاكرة\n"
                      "• تقليل القلق والتوتر\n"
                      "• تعزيز الشعور بالسلام الداخلي والتوازن العاطفي\n"
                      "يمكن بدء ممارسة التأمل واليقظة ببساطة من خلال تخصيص بضع دقائق يومياً لملاحظة التنفس ومراقبة الأفكار دون الحكم عليها.\n"
                      : "Mindfulness, meditation, and relaxation are effective tools for enhancing mental health and reducing stress levels. These practices help direct attention to the present moment and alleviate negative thoughts. Benefits include:\n"
                      "• Improved concentration and memory\n"
                      "• Reduced anxiety and stress\n"
                      "• Enhanced sense of inner peace and emotional balance\n"
                      "You can start practicing meditation and mindfulness by dedicating a few minutes each day to observe your breath and watch your thoughts without judgment.",
                  style: TextStyle(fontSize: 18, fontFamily: 'Tajawal'),
                )
              ],

            ], ),
        ),
      ),
    );
  }
}

class ArticlesPage extends StatelessWidget {
  final String category;

  final List<Map<String, String>> articles = [
    {
      'title': 'كيفية التعامل مع القلق'.tr(),
      'description': 'نصائح عملية للتعامل مع القلق والتوتر اليومي.'.tr(),
      'category': 'القلق والتوتر'.tr(),
      'image': 'assets/anxiety.webp',
      'content': 'تدرب على التفكير الإيجابي '
          'استخدم التدوين لإخراج مشاعرك'
          'جرب العقلانية'
          'تهدئة الجهاز العصبي باستخدام التنفس الحجابي (التنفس العميق).'
          'تغلبْ على الخوف من خلال التحدث بلطف إلى نفسك للخروج من هذه الحالة.'
    },
    {
      'title': 'أهمية النوم الجيد للصحة النفسية'.tr(),
      'description': 'كيف يؤثر النوم الجيد على صحتنا النفسية.'.tr(),
      'category': 'اضطرابات النوم'.tr(),
      'image': 'assets/sleep.webp',
      'content': 'محتوى المقالة: النوم الجيد يعد من أساسيات الحفاظ على الصحة النفسية...'
    },
    {
      'title': 'التغذية والصحة النفسية'.tr(),
      'description': 'أهمية التغذية السليمة للصحة النفسية.'.tr(),
      'category': 'التغذية والصحة النفسية'.tr(),
      'image': 'assets/nutrition.webp',
      'content': 'محتوى المقالة: التغذية السليمة تلعب دورًا مهمًا في تعزيز صحتنا النفسية...'
    },
  ];

  ArticlesPage({required this.category});

  @override
  Widget build(BuildContext context) {
    final filteredArticles = articles.where((article) => article['category'] == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(' $category',style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: filteredArticles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticlePage(article: filteredArticles[index]),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 4,
              child: ListTile(
                leading: Image.asset(
                  filteredArticles[index]['image']!,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
                title: Text(filteredArticles[index]['title']!, style: TextStyle(fontSize: 14,fontFamily: 'Tajawal',)),
                subtitle: Text(filteredArticles[index]['description']!, style: TextStyle(fontSize: 12,fontFamily: 'Tajawal',)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ArticlePage extends StatelessWidget {
  final Map<String, String> article;

  ArticlePage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article['title']!,style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(article['image']!),
              SizedBox(height: 10),
              Text(
                article['description']!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
              ),
              SizedBox(height: 20),
              Text(
                article['content']!,
                style: TextStyle(fontSize: 14,fontFamily: 'Tajawal',),
              ),
            ],
          ),
        ),
      ),
    );
  }
}