import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rafq1/Screens/VideoPlayerScreen.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

class AnxietyDetailPage extends StatefulWidget {
  const AnxietyDetailPage({super.key});

  @override
  _AnxietyDetailPageState createState() => _AnxietyDetailPageState();
}

class _AnxietyDetailPageState extends State<AnxietyDetailPage> {

  void openYouTubeVideo(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('تعذر فتح الرابط: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "القلق"
            : "Anxiety",style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.green.shade200,
      ),
      body: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Container(
    alignment: Alignment.topRight,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.locale.languageCode == 'ar'
                  ? "القلق"
                  : "Anxiety",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
                fontFamily: 'Tajawal',
              ),
            ),
            SizedBox(height: 16),
            Text(
              context.locale.languageCode == 'ar'
                  ? "مقالات، فيديوهات، وبودكاست حول التعامل مع القلق."
                  : "Articles, videos, and podcasts on dealing with anxiety.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.green.shade700,
                fontFamily: 'Tajawal',
              ),
            ),
            SizedBox(height: 16),
            _buildVideoSection(),
            SizedBox(height: 16),
            _buildImageSection(),
            SizedBox(height: 16),
            _buildLinksSection(),
          ],
        ),
      ),
    ]),
      ),
    );
  }

  Widget _buildVideoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.locale.languageCode == 'ar'
              ? "شاهد الفيديو المرتبط"
              : "Watch the related video",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade900,
            fontFamily: 'Tajawal',
          ),
        ),
        ElevatedButton(
          onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => VideoPlayerScreen(videoUrl: "https://www.youtube.com/watch?v=0mawZ0r-kmM"),
    ),
    );
    },
    child: Text(context.locale.languageCode == 'ar'
        ? "مشاهدة الفيديو"
        : "Watch the video",style: TextStyle(fontFamily: 'Tajawal',),),
    ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.locale.languageCode == 'ar'
              ? "صورة توضيحية:"
              : "illustrative image:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade900,
            fontFamily: 'Tajawal',
          ),
        ),
        SizedBox(height: 8),
        Image.asset('assets/anxiety1.jpeg'),
      ],
    );
  }

  Widget _buildLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.locale.languageCode == 'ar'
              ? "روابط اضافية:"
              : "additional links:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade900,
            fontFamily: 'Tajawal',
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () => launchURL('https://www.who.int/ar/news-room/fact-sheets/detail/anxiety-disorders'),
          child: Text(
            context.locale.languageCode == 'ar'
                ? "رابط تعليمي حول القلق"
                : "Educational link about anxiety",
            style: TextStyle(color: Colors.blue,fontFamily: 'Tajawal',),
          ),
        ),
      ],
    );
  }

  void launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('❌ تعذر فتح الرابط: $url');
    }
  }

}
