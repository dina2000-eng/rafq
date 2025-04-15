import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rafq1/Screens/AnxietyDetailPage.dart';
import 'package:rafq1/Screens/DepressionDetailPage.dart';
import 'package:rafq1/Screens/RelationshipsDetailPage.dart';
import 'package:rafq1/Screens/ResourceDetailPage.dart';
import 'package:rafq1/Screens/SelfEsteemDetailPage.dart';
import 'package:rafq1/Screens/StressManagementDetailPage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class EducationalResourcesPage extends StatelessWidget {
  const EducationalResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "موارد تعليمية"
            : "Educationalresources").tr(),
        backgroundColor: Colors.green.shade200,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           // _buildSearchBar(),
            SizedBox(height: 16),
            _buildTopicCard(
              title: context.locale.languageCode == 'ar'
                  ? "القلق"
                  : "Anxiety",
              description: context.locale.languageCode == 'ar'
                  ? "مقالات، فيديوهات، وبودكاست حول التعامل مع القلق."
                  : "Articles, videos, and podcasts on dealing with anxiety.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnxietyDetailPage(),
                  ),
                );
              },
              icon: Icons.sentiment_dissatisfied,
            ),
            SizedBox(height: 12),
            _buildTopicCard(
              title: context.locale.languageCode == 'ar'
                  ? "الاكتئاب"
                  : "Depression",
              description: context.locale.languageCode == 'ar'
                  ? "مقالات، فيديوهات، وبودكاست عن الاكتئاب وطرق التعامل معه."
                  : "Articles, videos, and podcasts on depression and ways to cope with it.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DepressionDetailPage(),
                  ),
                );
              },
              icon: Icons.sentiment_very_dissatisfied,
            ),
            SizedBox(height: 12),
            _buildTopicCard(
              title: context.locale.languageCode == 'ar'
                  ? "إدارة الضغوط"
                  : "StressManagement",
              description: context.locale.languageCode == 'ar'
                  ? "موارد تساعدك على فهم الضغوط والتعامل معها."
                  : "Resources to help you understand and manage stress.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StressManagementDetailPage(),
                  ),
                );
              },
              icon: Icons.account_balance_wallet,
            ),
            SizedBox(height: 12),
            _buildTopicCard(
              title: context.locale.languageCode == 'ar'
                  ? "العلاقات"
                  : "Relationship",
              description: context.locale.languageCode == 'ar'
                  ? "نصائح ومقالات لتحسين العلاقات الشخصية."
                  : "Tips and articles to improve personal relationships.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RelationshipsDetailPage(),
                  ),
                );
              },
              icon: Icons.people,
            ),
            SizedBox(height: 12),
            _buildTopicCard(
              title: context.locale.languageCode == 'ar'
                  ? "تقدير الذات"
                  : "self-esteem",
              description: context.locale.languageCode == 'ar'
                  ? "موارد لزيادة الثقة بالنفس وتعزيز تقدير الذات."
                  : "Resources to increase self-confidence and boost self-esteem.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelfEsteemDetailPage(),
                  ),
                );
              },
              icon: Icons.thumb_up,
            ),
            SizedBox(height: 16),
            _buildFeaturedResourcesSection(context),
            SizedBox(height: 16),
            //_buildShareButton(),
          ],
        ),
      ),
    );
  }

  void _navigateToDetailPage(BuildContext context, String title, String description, IconData icon) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DepressionDetailPage(
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'بحث',
        labelStyle: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        // Implement search functionality
      },
    );
  }

  Widget _buildTopicCard({
    required String title,
    required String description,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade50, Colors.blueGrey.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, size: 50, color: Colors.green.shade900),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green.shade900,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        Text('4.5/5', style: TextStyle(color: Colors.green.shade900,fontFamily: 'Tajawal',)),
                      ],
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

  Widget _buildFeaturedResourcesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.locale.languageCode == 'ar'
              ? "الموارد الموصى بها"
              : "Recommended Resources",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green.shade900,fontFamily: 'Tajawal',),
        ),
        SizedBox(height: 12),
        _buildTopicCard(
          title: context.locale.languageCode == 'ar'
              ? "موارد للاكتئاب"
              : "Resources for Depression",
          description: context.locale.languageCode == 'ar'
              ? "موارد موصى بها خصيصًا لهذا الموضوع."
              : "Recommended resources specifically for this topic.",
          onTap: () {
            _navigateToDetailPage(context, context.locale.languageCode == 'ar'
                ? "موارد للاكتئاب"
                : "Resources for Depression", context.locale.languageCode == 'ar'
                ? "موارد موصى بها خصيصًا لهذا الموضوع."
                : "Recommended resources specifically for this topic.", Icons.favorite);
          },
          icon: Icons.favorite,
        ),
      ],
    );
  }

  // Widget _buildShareButton() {
  //   return GestureDetector(
  //     onTap: () {
  //       Share.share(contentToShare);
  //     },
  //     child: Row(
  //       children: [
  //         Icon(Icons.share, color: Colors.blue),
  //         SizedBox(width: 8),
  //         Text('مشاركة المحتوى'.tr(), style: TextStyle(color: Colors.blue)),
  //       ],
  //     ),
  //   );
  // }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
