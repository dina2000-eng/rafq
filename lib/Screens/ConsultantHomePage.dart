import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rafq1/Screens/ConsultantSettingsPage.dart';
import 'package:rafq1/Screens/EditConsultantProfile.dart';
import 'package:rafq1/Screens/HomePage.dart';

class ConsultantHomePage extends StatelessWidget {
  final String consultantId;

  ConsultantHomePage({required this.consultantId});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (consultantId.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(context.locale.languageCode == 'ar'
              ? "الصفحة الرئيسية للمستشار"
              : "Counselor's Home Page", style: TextStyle(fontFamily: 'Tajawal')),
          backgroundColor: Colors.indigo,
        ),
        body: Center(child: Text(context.locale.languageCode == 'ar'
            ? "معرف المستشار غير صحيح. يرجى المحاولة مرة أخرى."
            : "The advisor ID is invalid. Please try again.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.locale.languageCode == 'ar'
              ? "الصفحة الرئيسية للمستشار"
              : "Counselor's Home Page",
          style: TextStyle(fontFamily: 'Tajawal'),
        ),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage(forumId: '')),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.locale.languageCode == 'ar'
                  ? "مرحبًا بالمستشار!"
                  : "Welcome Advisor!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
                fontFamily: 'Tajawal',
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildCard(context,context.locale.languageCode == 'ar'
                      ? "ملفي الشخصي"
                      : "My profile", Icons.person, Colors.teal, ConsultantProfilePage(consultantId: consultantId)),
                  _buildCard(context, context.locale.languageCode == 'ar'
                      ? "التقارير"
                      : "Reports", Icons.insert_chart, Colors.orange, ConsultantReportsPage(consultantId: consultantId)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, Color color, Widget destinationPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        color: color.withOpacity(0.15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'Tajawal',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
class ConsultantProfilePage extends StatelessWidget {
  final String consultantId;

  ConsultantProfilePage({required this.consultantId});

  @override
  Widget build(BuildContext context) {
    if (consultantId.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(context.locale.languageCode == 'ar'
              ? "ملفي الشخصي"
              : "My profile", style: TextStyle(fontFamily: 'Tajawal')),
          backgroundColor: Colors.teal,
        ),
        body: Center(child: Text(context.locale.languageCode == 'ar'
            ? "معرف المستشار غير صحيح. يرجى المحاولة مرة أخرى."
            : "The advisor ID is invalid. Please try again.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "ملفي الشخصي"
            : "My profile", style: TextStyle(fontFamily: 'Tajawal')),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('consultants').doc(consultantId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text(context.locale.languageCode == 'ar'
                ? "لا توجد بيانات"
                : "No data"));
          }
          var data = snapshot.data!.data() as Map<String, dynamic>;
          String? imageUrl = data['profileImage'];
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      data['profileImage'] ??
                          (data['gender'] == 'أنثى'
                              ? 'https://www.w3schools.com/howto/img_avatar2.png'
                              : 'https://cdn-icons-png.flaticon.com/512/1995/1995574.png'),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    data['name'] ?? (context.locale.languageCode == 'ar'
                        ? "اسم المستشار"
                        : "Advisor's name"),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
                  ),
                  SizedBox(height: 8),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.person, color: Colors.teal),
                      title: Text(
                        context.locale.languageCode == 'ar'
                            ? "التخصص"
                            : "Specialization",
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
                      ),
                      subtitle: Text(
                        data['specialization'] ?? (context.locale.languageCode == 'ar'
                            ? "استشارات نفسية"
                            : "Psychological consultations"),
                      style: TextStyle(fontFamily: 'Tajawal'),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.work, color: Colors.orange),
                      title: Text(
                        context.locale.languageCode == 'ar'
                            ? "سنوات الخبرة"
                            : "Years of experience",
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
                      ),
                      subtitle: Text(
                        context.locale.languageCode == 'ar'
                            ? '${data['yearsOfExperience'] ?? '0'} سنوات'
                            : '${data['yearsOfExperience'] ?? '0'} years',
                        style: TextStyle(fontFamily: 'Tajawal'),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.info, color: Colors.grey),
                      title: Text(
                        context.locale.languageCode == 'ar'
                            ? "نبذة عني"
                            : "About me",
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
                      ),
                      subtitle: Text(
                        data['bio'] ??
                            'نبذة: هذا مثال على عرض المعلومات الحقيقية للمستشار من قاعدة بيانات Firestore.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontFamily: 'Tajawal'),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditConsultantProfile(consultantId: consultantId),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit),
                    label: Text(context.locale.languageCode == 'ar'
                        ? "تعديل البيانات"
                        : "Edit data", style: TextStyle(fontFamily: 'Tajawal')),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------
class ConsultantReportsPage extends StatelessWidget {
  final String consultantId;

  ConsultantReportsPage({required this.consultantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "التقارير"
            : "Reports", style: TextStyle(fontFamily: 'Tajawal')),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('consultants')
            .doc(consultantId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text(context.locale.languageCode == 'ar'
                ? "لا توجد بيانات."
                : "No data."));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final reports = data['reports'];

          final int sessionsThisMonth = int.tryParse(reports?['sessionsThisMonth'] ?? '0') ?? 0;
          final int newRequests = int.tryParse(reports?['newRequests'] ?? '0') ?? 0;
          final double rating = double.tryParse(reports?['rating'] ?? '0') ?? 0.0;


          print('Full data: $data');
          print('Reports: ${data['reports']}');

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  elevation: 3,
                  child: ListTile(
                    leading: Icon(Icons.calendar_today, color: Colors.green),
                    title: Text(context.locale.languageCode == 'ar'
                        ? "عدد الجلسات هذا الشهر"
                        : "Number of sessions this month",
                        style: TextStyle(fontFamily: 'Tajawal')),
                    trailing: Text(
                      sessionsThisMonth.toString(),
                      style: TextStyle(fontFamily: 'Tajawal'),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  elevation: 3,
                  child: ListTile(
                    leading: Icon(Icons.list_alt, color: Colors.blue),
                    title: Text(context.locale.languageCode == 'ar'
                        ? "الطلبات الجديدة"
                        : "New orders",
                        style: TextStyle(fontFamily: 'Tajawal')),
                    trailing: Text(
                      (reports['newRequests'] ?? 0).toString(),
                      style: TextStyle(fontFamily: 'Tajawal'),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  elevation: 3,
                  child: ListTile(
                    leading: Icon(Icons.star, color: Colors.purple),
                    title: Text(context.locale.languageCode == 'ar'
                        ? "التقييمات"
                        : "Ratings",
                        style: TextStyle(fontFamily: 'Tajawal')),
                    trailing: Text(
                      (reports['rating'] ?? 0).toString(),
                      style: TextStyle(fontFamily: 'Tajawal'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: Icon(Icons.settings),
                  label: Text(context.locale.languageCode == 'ar'
                      ? "إعدادات حساب المستشار"
                      : "Advisor account settings",
                      style: TextStyle(fontFamily: 'Tajawal')),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ConsultantSettingsPage(consultantId: consultantId,),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

