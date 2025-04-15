import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart'; // تأكد من استيراد الحزمة

class ResourceDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;

  const ResourceDetailPage({
    required this.title,
    required this.description,
    required this.icon,
    super.key,
  });

  @override
  _ResourceDetailPageState createState() => _ResourceDetailPageState();
}

class _ResourceDetailPageState extends State<ResourceDetailPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('https://www.example.com/video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.green.shade200,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
                fontFamily: 'Tajawal',
              ),
            ),
            SizedBox(height: 16),

            Text(
              widget.description,
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
        SizedBox(height: 8),
        _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : Center(child: CircularProgressIndicator()),
      ],
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.locale.languageCode == 'ar'
              ? "صوره توضيحيه:"
              : "illustrative image:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade900,
            fontFamily: 'Tajawal',
          ),
        ),
        SizedBox(height: 8),
        Image.asset("assets/anxiety1.jpeg"),
      ],
    );
  }

  Widget _buildLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.locale.languageCode == 'ar'
              ? "روابط اضافيه:"
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
          onTap: () => launchURL('https://www.example.com'),
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
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
