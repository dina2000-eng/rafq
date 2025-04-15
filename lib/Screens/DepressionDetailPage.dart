import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rafq1/Screens/VideoPlayerScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class DepressionDetailPage extends StatefulWidget {
  const DepressionDetailPage({super.key});

  @override
  _DepressionDetailPageState createState() => _DepressionDetailPageState();
}

class _DepressionDetailPageState extends State<DepressionDetailPage> {

  void openYouTubeVideo(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('تعذر فتح الرابط:$url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "الاكتئاب"
            : "Depression",style: TextStyle(fontFamily: 'Tajawal',),),
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
                  ? "الاكتئاب"
                  : "Depression",
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
                  ? "مقالات، فيديوهات، وبودكاست عن الاكتئاب وطرق التعامل معه."
                  : "Articles, videos, and podcasts on depression and ways to cope with it.",
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
                builder: (context) => VideoPlayerScreen(videoUrl: "https://www.youtube.com/watch?v=igIdKdjU5WE"),
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
        Image.asset('assets/Depression.jpeg'),
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
          onTap: () => launchURL('https://www.who.int/ar/news-room/fact-sheets/detail/depression'),
          child: Text(
            context.locale.languageCode == 'ar'
                ? "رابط تعليمي حول الاكتئاب"
                : "Educational link about Depression",
            style: TextStyle(color: Colors.blue,fontFamily: 'Tajawal',),
          ),
        ),
      ],
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
