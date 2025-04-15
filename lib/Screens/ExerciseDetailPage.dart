import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ExerciseDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String fullDescription;
  final String duration;
  final String imageUrl;

  const ExerciseDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.fullDescription,
    required this.duration,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.purple.shade100,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
          context.locale.languageCode == 'ar'
              ? "وصف التمرين"
              : "Exercise description:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
              ).tr(),
              SizedBox(height: 8),
              Text(description, style: TextStyle(fontSize: 16,fontFamily: 'Tajawal',)),
              SizedBox(height: 16),
              Text(
                  context.locale.languageCode == 'ar'
                      ? "طريقة الاداء"
                      : "Method of performance:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
              ).tr(),
              SizedBox(height: 8),
              Text(fullDescription, style: TextStyle(fontSize: 16,fontFamily: 'Tajawal',)),
              SizedBox(height: 16),
              Text(
                  context.locale.languageCode == 'ar'
                      ? "المدة"
                      : "Duration:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
              ).tr(),
              SizedBox(height: 8),
              Text(duration, style: TextStyle(fontSize: 16,fontFamily: 'Tajawal',)),
            ],
          ),
        ),
      ),
    );
  }
}
