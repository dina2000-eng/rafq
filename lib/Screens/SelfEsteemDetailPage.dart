import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rafq1/Screens/VideoPlayerScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class SelfEsteemDetailPage extends StatefulWidget {
  const SelfEsteemDetailPage({super.key});

  @override
  _SelfEsteemDetailPageState createState() => _SelfEsteemDetailPageState();
}

class _SelfEsteemDetailPageState extends State<SelfEsteemDetailPage> {

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
            ? "تقدير الذات"
            : "self-esteem",style: TextStyle(fontFamily: 'Tajawal',),),
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
                  ? "تقدير الذات"
                  : "self-esteem",
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
                  ? "موارد لزيادة الثقة بالنفس وتعزيز تقدير الذات."
                  : "Resources to increase self-confidence and boost self-esteem.",
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
                builder: (context) => VideoPlayerScreen(videoUrl: "https://www.youtube.com/watch?v=690fqzvQgVI"),
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
        Image.asset('assets/self_esteem.png'),
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
          onTap: () => launchURL('https://mawdoo3.com/تمارين_وتقنيات_للرفع_من_تقدير_الذات'),
          child: Text(
            context.locale.languageCode == 'ar'
                ? "رابط تعليمي حول تقدير الذات"
                : "Educational link about self-esteem",
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

