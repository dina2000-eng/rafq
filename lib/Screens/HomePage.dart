import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafq1/Screens/CounselingPage.dart';
import 'package:rafq1/Screens/EducationalResourcesPage.dart';
import 'package:rafq1/Screens/ExercisesAndStrategiesPage.dart';
import 'package:rafq1/Screens/MoodTrackingPage.dart';
import 'package:rafq1/Screens/drawerpages/DrawYourFeelingsPage.dart';
import 'package:rafq1/Screens/drawerpages/ForumsPage.dart';
import 'package:rafq1/Screens/drawerpages/PsychologicalTestsSection.dart';
import 'package:rafq1/Screens/drawerpages/ReportsScreen.dart';
import 'package:rafq1/Screens/drawerpages/ResourcesPage.dart';
import 'package:rafq1/Screens/drawerpages/SettingsScreen.dart';
import 'package:rafq1/Screens/notificationpage.dart';
import 'package:rafq1/Screens/ConsultantHomePage.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final String forumId;

  const HomePage({Key? key, required this.forumId}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "رفق"
            : "rafq", style: TextStyle(fontSize: width * 0.06,fontFamily: 'Tajawal',)).tr(),
        backgroundColor: Colors.teal.shade300,
        actions: [
          // Container(
          //   width: 40,
          //   child: _buildUnreadMessagesIcon(),
          // ),
          Container(
            width: 40,
            child: _buildNotificationsIcon(),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade400, Colors.teal.shade200],
                ),
              ),
              child: Center(
                child: Text(
                  context.locale.languageCode == 'ar'
                      ? "...نحن هنا لدعمك"
                      : "We are here to support you",
                  style: TextStyle(
                    fontSize: width * 0.08,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ),
            ),
            _buildDrawerItem(Icons.brush, context.locale.languageCode == 'ar'
                ? "ارسم مشاعرك"
                : "Draw your feeling", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DrawingPage()));
            }),
            _buildDrawerItem(Icons.group, context.locale.languageCode == 'ar'
                ? "المنتديات والمجتمعات"
                : "Forums and Communities", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ForumsPage()));
            }),
            _buildDrawerItem(Icons.article, context.locale.languageCode == 'ar'
                ? "الموارد والمقالات"
                : "Resources and articles", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ResourcesPage()));
            }),
            _buildDrawerItem(Icons.assignment, context.locale.languageCode == 'ar'
                ? "الاختبارات النفسية"
                : "Psychological Tests", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PsychologicalTestsSection()));
            }),
            _buildDrawerItem(Icons.analytics, context.locale.languageCode == 'ar'
                ? "التقارير والتقدم الشخصي"
                : "Reports and personal progress", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ReportsScreen()));
            }),
            _buildDrawerItem(Icons.settings, context.locale.languageCode == 'ar'
                ? "الإعدادات"
                : "Settings", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(onLocaleChange: (Locale _) {})));
            }),
            _buildDrawerItem(Icons.person, context.locale.languageCode == 'ar'
                ? "صفحة المستشارين"
                : "Consultant page", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ConsultantHomePage(consultantId: FirebaseAuth.instance.currentUser!.uid,)));
            }),

            _buildDrawerItem(Icons.star_rate, context.locale.languageCode == 'ar'
                ? "تقييم التطبيق"
                : "Rate the app", onTap: () async {
              final String appStoreUrl = "https://play.google.com/store/apps/details?id=your.app.package";
              if (await canLaunchUrl(Uri.parse(appStoreUrl))) {
                await launchUrl(Uri.parse(appStoreUrl));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.locale.languageCode == 'ar'
                      ? "تعذر فتح رابط التقييم"
                      : "Could not open rating link")),
                );
              }
            }),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.02),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(context.locale.languageCode == 'ar'
                        ? "مرحبا"
                        : "hello",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',)),
                    SizedBox(height: height * 0.01),
                    Text(context.locale.languageCode == 'ar'
                        ? "ابحث عن الضوء في الظلام"
                        : "Find the light in the dark",
                        style: TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic,fontFamily: 'Tajawal',)),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              _buildCustomCard(
                icon: Icons.chat,
                title: context.locale.languageCode == 'ar'
                    ? "جلسات استشارية"
                    : "CounselingSessions",
                color: Colors.orange.shade100,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CounselingSessionsPage(),
                    ),
                  );
                },
              ),
              SizedBox(height: height * 0.02),
              _buildCustomCard(
                icon: Icons.nature,
                title: context.locale.languageCode == 'ar'
                    ? "تمارين واستراتيجيات"
                    : "Exercises and strategies",
                color: Colors.purple.shade100,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExercisesAndStrategiesPage(),
                    ),
                  );
                },
              ),
              SizedBox(height: height * 0.02),
              _buildCustomCard(
                icon: Icons.book,
                title: context.locale.languageCode == 'ar'
                    ? "موارد تعليمية"
                    : "Educational resources",
                color: Colors.green.shade100,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EducationalResourcesPage(),
                    ),
                  );
                },
              ),
              // SizedBox(height: height * 0.02),
              // _buildCustomCard(
              //   icon: Icons.group,
              //   title: 'مجموعات دعم'.tr(),
              //   color: Colors.blue.shade100,
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => SupportGroupPage(),
              //       ),
              //     );
              //   },
              // ),
              SizedBox(height: height * 0.02),
              _buildCustomCard(
                icon: Icons.mood,
                title: context.locale.languageCode == 'ar'
                    ? "تتبع المزاج"
                    : "Mood tracking",
                color: Colors.pink.shade100,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MoodTrackingPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildUnreadMessagesIcon() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: FirebaseFirestore.instance
  //         .collectionGroup('messages')
  //      .where('isRead', isEqualTo: false)
  //      .where('sender', isNotEqualTo: 'user')
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //       if (snapshot.hasError) {
  //         print('Firestore Error: ${snapshot.error}');
  //         return Icon(Icons.error, size: 28);
  //       }
  //       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
  //         return IconButton(
  //           icon: Icon(Icons.message, size: 28),
  //           onPressed: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => SelectCounselorForChatScreen()),
  //             );
  //           },
  //         );
  //       }
  //       var allMessages = snapshot.data!.docs;
  //       int unreadCount = allMessages.length;
  //       unreadCount = unreadCount > 99 ? 99 : unreadCount;
  //       return IconButton(
  //         icon: Stack(
  //           children: [
  //             Icon(Icons.message, size: 28),
  //             if (unreadCount > 0)
  //               Positioned(
  //                 right: 0,
  //                 child: Container(
  //                   padding: EdgeInsets.all(4),
  //                   decoration: BoxDecoration(
  //                     color: Colors.red,
  //                     shape: BoxShape.circle,
  //                   ),
  //                   child: Text(
  //                     '$unreadCount',
  //                     style: TextStyle(color: Colors.white, fontSize: 12,fontFamily: 'Tajawal',),
  //                   ),
  //                 ),
  //               ),
  //           ],
  //         ),
  //         onPressed: () async {
  //           if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
  //             WriteBatch batch = FirebaseFirestore.instance.batch();
  //             for (var doc in snapshot.data!.docs) {
  //               batch.update(doc.reference, {'isRead': true});
  //             }
  //             await batch.commit();
  //           }
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => SelectCounselorForChatScreen()),
  //           );
  //         },
  //
  //       );
  //     },
  //   );
  // }

  Widget _buildNotificationsIcon() {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('notifications')
          .where('userId', isEqualTo: currentUserId)
          .where('isRead', isEqualTo: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('خطأ: ${snapshot.error}'));
        }
        int notificationCount = snapshot.data?.docs.length ?? 0;
        return PopupMenuButton<String>(
          icon: Stack(
            children: [
              Icon(Icons.notifications, size: 28),
              if (notificationCount > 0)
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      notificationCount.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Tajawal'),
                    ),
                  ),
                ),
            ],
          ),
          onSelected: (value) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationsPage()),
            );
          },
          itemBuilder: (BuildContext context) {
            return snapshot.data!.docs.map((notification) {
              final data = notification.data() as Map<String, dynamic>;
              return PopupMenuItem<String>(
                value: notification.id,
                child: ListTile(
                  leading: Icon(Icons.notifications, color: Colors.teal),
                  title: Text(data['title'] ?? 'لا عنوان', style: TextStyle(fontFamily: 'Tajawal')).tr(),
                  subtitle: Text(data['body'] ?? 'لا رسالة', style: TextStyle(fontFamily: 'Tajawal')).tr(),
                ),
              );
            }).toList();
          },
        );
      },
    );
  }


  Widget _buildDrawerItem(IconData icon, String title, {required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(title, style: TextStyle(color: Colors.teal,fontFamily: 'Tajawal',)),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("هل أنت متأكد؟",style: TextStyle(fontFamily: 'Tajawal',),),
          content: Text("هل ترغب في تسجيل الخروج من التطبيق؟",style: TextStyle(fontFamily: 'Tajawal',),),
          actions: <Widget>[
            TextButton(
              child: Text("لا",style: TextStyle(fontFamily: 'Tajawal',),),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text("نعم",style: TextStyle(fontFamily: 'Tajawal',),),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                // مثال: FirebaseAuth.instance.signOut();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCustomCard({
    required IconData icon,
    required String title,
    required Color color,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(width: 16),
            Text(title,
                style: TextStyle(color: Colors.black87, fontSize: 20,fontFamily: 'Tajawal',)),
          ],
        ),
      ),
    );
  }
}
