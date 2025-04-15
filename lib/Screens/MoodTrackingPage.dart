import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoodTrackingPage extends StatefulWidget {
  const MoodTrackingPage({super.key});

  @override
  _MoodTrackingPageState createState() => _MoodTrackingPageState();
}

class _MoodTrackingPageState extends State<MoodTrackingPage> {
  String _selectedMood = '';
  TextEditingController _notesController = TextEditingController();

  String _moodAdvice = '';

  void _onMoodSelected(String mood) {
    setState(() {
      _selectedMood = mood;

      if (context.locale.languageCode == 'ar') {
        switch (mood) {
          case 'سعيد':
            _moodAdvice = 'استمتع بلحظات السعادة وشاركها مع الآخرين!';
            break;
          case 'حزين':
            _moodAdvice = 'لا بأس، خذ وقتك لتشعر بما تشعر به واهتم بنفسك.';
            break;
          case 'غاضب':
            _moodAdvice = 'حاول أخذ نفس عميق وهدئ نفسك قليلاً قبل اتخاذ أي قرار.';
            break;
          case 'قلق':
            _moodAdvice = 'مارس التنفس العميق وتذكر أن كل شيء سيكون على ما يرام.';
            break;
          default:
            _moodAdvice = '';
        }
      } else {
        switch (mood) {
          case 'Happy':
            _moodAdvice = 'Enjoy your happy moments and share them with others!';
            break;
          case 'Sad':
            _moodAdvice = 'It’s okay, take your time to feel your emotions and take care of yourself.';
            break;
          case 'Angry':
            _moodAdvice = 'Try taking a deep breath and calm yourself before making any decisions.';
            break;
          case 'Anxious':
            _moodAdvice = 'Practice deep breathing and remember that everything will be okay.';
            break;
          default:
            _moodAdvice = '';
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSavedMoodData();
  }
  Future<void> _saveMoodData(String mood, String notes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedMood', mood);
    await prefs.setString('moodNotes', notes);
  }

  Future<void> _loadSavedMoodData() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedMood = prefs.getString('selectedMood');
    String? savedNotes = prefs.getString('moodNotes');

    setState(() {
      _selectedMood = savedMood ?? '';
      _notesController.text = savedNotes ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
             ? "تتبع المزاج"
            : "Mood Tracker",style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.indigo.shade400,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.locale.languageCode == 'ar'
                  ? "اختر حالتك المزاجبه اليوم"
                  : "choose your mood today",style: TextStyle(fontFamily: 'Tajawal',),),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMoodIcon('😊', context.locale.languageCode == 'ar'
                      ? "سعيد"
                      : "Happy"),
                  _buildMoodIcon('😞', context.locale.languageCode == 'ar'
                      ? "حزين"
                      : "Sad"),
                  _buildMoodIcon('😡', context.locale.languageCode == 'ar'
                      ? "غاضب"
                      : "Angry"),
                  _buildMoodIcon('😟', context.locale.languageCode == 'ar'
                      ? "قلق"
                      : "Anxious"),
                ],
              ),
              SizedBox(height: 20),
              if (_selectedMood.isNotEmpty)
        Text(
      context.locale.languageCode == 'ar'
        ? 'المزاج المختار: $_selectedMood'
            : 'Selected Mood: $_selectedMood',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',))
                    .tr(),
              SizedBox(height: 20),
              TextField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: context.locale.languageCode == 'ar'
                      ? "ملاحظات إضافية (اختياري)"
                      : "Additional Notes (Optional)",
                    labelStyle: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  border: OutlineInputBorder(),
                  hintText: context.locale.languageCode == 'ar'
                      ? "اكتب أي شيء يؤثر على مزاجك اليوم..."
                      : "Write anything that affects your mood today..."
                ),
                maxLines: 4,
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              if (_moodAdvice.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    context.locale.languageCode == 'ar'
                        ? 'نصيحة: $_moodAdvice'
                        : 'Advice: $_moodAdvice',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade600,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_selectedMood.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(context.locale.languageCode == 'ar'
                          ? "يرجى اختيار المزاج أولاً!"
                          : "Please choose a mood first!",style: TextStyle(fontFamily: 'Tajawal',),)),
                    );
                  } else {
                    String notes = _notesController.text;
                    await _saveMoodData(_selectedMood, notes);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(context.locale.languageCode == 'ar'
                          ? "تم تسجيل المزاج بنجاح!"
                          : "Mood recorded successfully!",style: TextStyle(fontFamily: 'Tajawal',),)),
                    );

                    setState(() {
                      _selectedMood = '';
                      _notesController.clear();
                      _moodAdvice = '';
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade500,
                ),
                child: Text(context.locale.languageCode == 'ar'
                ? "تسجيل المزاج"
                : "Mood recording",style: TextStyle(fontFamily: 'Tajawal',),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodIcon(String emoji, String mood) {
    bool isSelected = _selectedMood == mood;

    return GestureDetector(
      onTap: () => _onMoodSelected(mood),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: Colors.green.shade500, width: 2)
              : null,
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text(emoji, style: TextStyle(fontSize: 40,fontFamily: 'Tajawal',)),
            Text(mood, style: TextStyle(fontSize: 14,fontFamily: 'Tajawal',)),
          ],
        ),
      ),
    );
  }
}
