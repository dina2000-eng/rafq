import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RecommendationDetailPage extends StatelessWidget {
  final String recommendationTitle;
  final String recommendationDetails;

  RecommendationDetailPage({
    required this.recommendationTitle,
    required this.recommendationDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "تفاصيل التوصية"
            : "Recommendation details",style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recommendationTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: 'Tajawal'),
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.orange,
              thickness: 2,
              height: 20,
            ),
            SizedBox(height: 10),
            Text(
              recommendationDetails,
              style: TextStyle(fontSize: 18, height: 1.5,fontFamily: 'Tajawal'),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back),
                label: Text(context.locale.languageCode == 'ar'
                    ? "العودة"
                    : "back",style: TextStyle(fontFamily: 'Tajawal',),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
