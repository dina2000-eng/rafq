import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rafq1/Screens/drawerpages/DarkModeProvider.dart';
import 'package:rafq1/Screens/drawerpages/NotificationSettingsPage.dart';
import 'package:rafq1/Screens/drawerpages/PrivacyPolicyPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  SettingsScreen({required this.onLocaleChange});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _language = "العربية";
  bool _shareGraphics = false;
  bool _cacheCleared = false;

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    final passwordRegex =
    RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  @override
  void initState() {
    super.initState();
    _loadDarkModePreference();
  }

  _loadDarkModePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkModeEnabled = prefs.getBool('darkMode') ?? false;
    });
  }

  _saveDarkModePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
        'app_icon');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });

    if (_notificationsEnabled) {
      _enableNotifications();
    } else {
      _disableNotifications();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_notificationsEnabled
            ? 'تم تفعيل الإشعارات'.tr()
            : 'تم تعطيل الإشعارات'.tr(),style: TextStyle(fontFamily: 'Tajawal',),),
      ),
    );
  }

  Future<void> _enableNotifications() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'الإشعار مفعّل'.tr(),
      'تم تفعيل الإشعارات بنجاح!'.tr(),
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Future<void> _disableNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "الإعدادات"
            : "settings", style: TextStyle(color: Colors.white,fontFamily: 'Tajawal',))
            ,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAccountSettings(),
            SizedBox(height: 16),
            _buildNotificationSettings(),
            SizedBox(height: 16),
            _buildPrivacySettings(),
            SizedBox(height: 16),
            _buildAppSettings(),
            SizedBox(height: 16),
            _buildSupportSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSettings() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: Text(
          context.locale.languageCode == 'ar'
              ? "إعدادات الحساب"
              : "account settings",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Tajawal',),
        ).tr(),
        children: [
          ListTile(
            title: Text(context.locale.languageCode == 'ar'
                ? "تغيير اسم المستخدم"
                : "change username",style: TextStyle(fontFamily: 'Tajawal',),),
            trailing: Icon(Icons.edit, color: Colors.blueAccent),
            onTap: () {
              _showChangeUsernameDialog();
            },
          ),
          // ListTile(
          //   title: Text('تغيير البريد الإلكتروني').tr(),
          //   trailing: Icon(Icons.email, color: Colors.blueAccent),
          //   onTap: () {
          //     _showChangeEmailDialog();
          //   },
          // ),
          ListTile(
            title: Text(context.locale.languageCode == 'ar'
                ? "تغيير كلمة المرور"
                : "change password",style: TextStyle(fontFamily: 'Tajawal',),),
            trailing: Icon(Icons.lock, color: Colors.blueAccent,),
            onTap: () {
              _showChangePasswordDialog();
            },
          ),
          ListTile(
            title: Text(context.locale.languageCode == 'ar'
                ? "تسجيل الخروج"
                : "signout",style: TextStyle(fontFamily: 'Tajawal',),),
            trailing: Icon(Icons.logout, color: Colors.redAccent),
            onTap: () {
              _logoutUser();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: Text(
          context.locale.languageCode == 'ar'
              ? "إعدادات الإشعارات"
              : "notifications settings",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Tajawal',),
        ),
        children: [
          SwitchListTile(
            title: Text(context.locale.languageCode == 'ar'
                ? "تفعيل الإشعارات"
                : "activate notifications",style: TextStyle(fontFamily: 'Tajawal',),),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              _toggleNotifications(value);
            },
          ),
          ListTile(
            title: Text(context.locale.languageCode == 'ar'
                ? "تخصيص الإشعارات"
                : "customize notifications",style: TextStyle(fontFamily: 'Tajawal',),),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationSettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySettings() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: Text(
          context.locale.languageCode == 'ar'
              ? "إعدادات الخصوصية"
              : "privacy settings",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Tajawal',),
        ).tr(),
        children: [
          SwitchListTile(
            title: Text(context.locale.languageCode == 'ar'
                ? "مشاركة الرسومات مع الآخرين"
                : "share paintings with others",style: TextStyle(fontFamily: 'Tajawal',),),
            value: _shareGraphics,
            onChanged: (bool value) {
              setState(() {
                _shareGraphics = value;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(value
                      ? 'share_paintings_enabled'.tr()
                      : 'share_paintings_disabled'.tr(),style: TextStyle(fontFamily: 'Tajawal',),),
                ),
              );
            },
          ),
          ListTile(
            title: Text(context.locale.languageCode == 'ar'
                ? "عرض سياسة الخصوصية"
                : "view privacy policy",style: TextStyle(fontFamily: 'Tajawal',),),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrivacyPolicyPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppSettings() {
    return Consumer<DarkModeProvider>(
      builder: (context, darkModeProvider, child) {
        return Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: ExpansionTile(
            title: Text(
              context.locale.languageCode == 'ar'
                  ? "إعدادات التطبيق"
                  : "application settings",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Tajawal',),
            ).tr(),
            children: [
              ListTile(
                title: Text(context.locale.languageCode == 'ar'
                    ? "تغيير اللغة"
                    : "change the language",style: TextStyle(fontFamily: 'Tajawal',),),
                subtitle: Text(_language),
                trailing: Icon(
                    Icons.arrow_forward_ios, color: Colors.blueAccent),
                onTap: _showLanguageSelectionDialog,
              ),
              SwitchListTile(
                title: Text(context.locale.languageCode == 'ar'
                    ? "تفعيل الوضع الليلي"
                    : "activate nightmode",style: TextStyle(fontFamily: 'Tajawal',),),
                value: darkModeProvider.isDarkMode,
                onChanged: (bool value) {
                  darkModeProvider.toggleDarkMode(value);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(value
                          ? 'nightmodeـactivated'.tr()
                          : 'nightmodeisـdisabled'.tr(),style: TextStyle(fontFamily: 'Tajawal',),),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(context.locale.languageCode == 'ar'
                    ? "مسح ذاكرة التخزين المؤقت"
                    : "clearchache",style: TextStyle(fontFamily: 'Tajawal',),),
                trailing: Icon(Icons.clear_all, color: Colors.blueAccent),
                onTap: _clearCache,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSupportSettings() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: Text(
          context.locale.languageCode == 'ar'
              ? "الدعم والمساعدة"
              : "support and help",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Tajawal',),
        ),
        children: [
          ListTile(
            leading: Icon(Icons.help_outline, color: Colors.blueAccent),
            title: Text(context.locale.languageCode == 'ar'
                ? "الأسئلة الشائعة"
                : "Frequently Asked Questions",style: TextStyle(fontFamily: 'Tajawal',),),
            subtitle: Text(context.locale.languageCode == 'ar'
                ? "إجابات على أسئلتك الشائعة"
                : "answers on your frequently asked questions",style: TextStyle(fontFamily: 'Tajawal',),),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
            onTap: () => _showFAQs(context),
          ),
          ListTile(
            leading: Icon(Icons.support_agent, color: Colors.blueAccent),
            title: Text(context.locale.languageCode == 'ar'
                ? "التواصل مع الدعم الفني"
                : "contact with technical support",style: TextStyle(fontFamily: 'Tajawal',),),
            subtitle: Text(context.locale.languageCode == 'ar'
                ? "تواصل مباشر مع فريق الدعم"
                : "direct contact with the support team",style: TextStyle(fontFamily: 'Tajawal',),),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
            onTap: () => _contactSupport(context),
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.blueAccent),
            title: Text(context.locale.languageCode == 'ar'
                ? "حول التطبيق"
                : "about the application",style: TextStyle(fontFamily: 'Tajawal',),),
            subtitle: Text(context.locale.languageCode == 'ar'
                ? "تعرف على المزيد حول التطبيق"
                : "learn more about the app",style: TextStyle(fontFamily: 'Tajawal',),),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
            onTap: _showAppInfo,
          ),
        ],
      ),
    );
  }

  void _showLanguageSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.locale.languageCode == 'ar'
              ? "تغيير اللغة"
              : "change the language",style: TextStyle(fontFamily: 'Tajawal',),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(context.locale.languageCode == 'ar'
                    ? "العربية"
                    : "Arabic",style: TextStyle(fontFamily: 'Tajawal',),),
                onTap: () {
                  context.setLocale(Locale('ar'));
                  setState(() {
                    _language = 'العربية'.tr();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(context.locale.languageCode == 'ar'
                    ? "الانجليزيه"
                    : "English",style: TextStyle(fontFamily: 'Tajawal',),),
                onTap: () {
                  context.setLocale(Locale('en'));
                  setState(() {
                    _language = 'English'.tr();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    setState(() {
      _cacheCleared = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.locale.languageCode == 'ar'
            ? "تم مسح ذاكرة التخزين المؤقت"
            : "chahce cleared",style: TextStyle(fontFamily: 'Tajawal',),),
      ),
    );
  }

  void _showFAQs(BuildContext context) {
    TextEditingController _questionController = TextEditingController();
    CollectionReference faqsRef = FirebaseFirestore.instance.collection('faqs');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.locale.languageCode == 'ar'
              ? "الأسئلة الشائعة"
              : "Frequently Asked Questions",style: TextStyle(fontFamily: 'Tajawal',),),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: faqsRef.orderBy('timestamp', descending: true).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Text(context.locale.languageCode == 'ar'
                            ? "لا توجد أسئله حتى الآن"
                            : "There are no questions yet.",style: TextStyle(fontFamily: 'Tajawal',),);
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var doc = snapshot.data!.docs[index];
                          return ListTile(
                            title: Text("س: ${doc['question']}"),
                            subtitle: Text("ج: ${doc['answer']}"),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _questionController,
                  decoration: InputDecoration(
                    labelText: context.locale.languageCode == 'ar'
                        ? "اكتب سؤالك هنا:"
                        : "Write your question here:",
                    labelStyle: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String question = _questionController.text.trim();
                if (question.isNotEmpty) {
                  await faqsRef.add({
                    'question': question,
                    'answer': 'سيتم الرد قريبًا.',
                    'timestamp': FieldValue.serverTimestamp(),
                  });
                  _questionController.clear();
                }
              },
              child: Text(context.locale.languageCode == 'ar'
                  ? "إرسال"
                  : "send",style: TextStyle(fontFamily: 'Tajawal',),),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(context.locale.languageCode == 'ar'
                  ? "إغلاق"
                  : "close",style: TextStyle(fontFamily: 'Tajawal',),),
            ),
          ],
        );
      },
    );
  }

  void _contactSupport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.locale.languageCode == 'ar'
              ? "التواصل مع الدعم الفني"
              : "contact technical support",style: TextStyle(fontFamily: 'Tajawal',),),
          content: Text(
              context.locale.languageCode == 'ar'
                  ? "للتواصل مع الدعم الفني، يمكنك مراسلتنا على: dinaelhallaq20@gmail.com أو الاتصال على: "
                  : "To contact technical support,you can email us at:dinaelhallaq20@gmail.comorcall:0592153237"  ,style: TextStyle(fontFamily: 'Tajawal',),        ),
          actions: [
            TextButton(
              onPressed: () async {
                final String email = 'dinaelhallaq20@gmail.com';
                final String subject = Uri.encodeComponent(context.locale.languageCode == 'ar'
                    ? "مساعدة من الدعم الفني"
                    : "help from technical support",);
                final String body = Uri.encodeComponent(context.locale.languageCode == 'ar'
                    ? "أحتاج إلى مساعدة بشأن..."
                    : "I need help with...");

                final Uri emailUri = Uri.parse('mailto:$email?subject=$subject&body=$body');
                final Uri gmailUri = Uri.parse('https://mail.google.com/mail/?view=cm&fs=1&to=$email&su=$subject&body=$body');

                if (await canLaunchUrl(emailUri)) {
                  await launchUrl(emailUri, mode: LaunchMode.externalApplication);
                }
                else if (await canLaunchUrl(gmailUri)) {
                  await launchUrl(gmailUri, mode: LaunchMode.externalApplication);
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.locale.languageCode == 'ar'
                        ? "فشل في فتح البريد الإلكتروني"
                        : "failed to open email",style: TextStyle(fontFamily: 'Tajawal',),)),
                  );
                }
                Navigator.pop(context);
              },
              child: Text(context.locale.languageCode == 'ar'
                  ? "مراسلة عبر البريد"
                  : "mail correspondence",style: TextStyle(fontFamily: 'Tajawal',),),
            ),

            TextButton(
              onPressed: () async {
                final Uri uri = Uri.parse('tel:0592153237');

                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  print('Could not launch phone call');
                }
                Navigator.pop(context);
              },
              child: Text(context.locale.languageCode == 'ar'
             ? "اتصال هاتفي"
            : "phone call",style: TextStyle(fontFamily: 'Tajawal',),),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(context.locale.languageCode == 'ar'
                  ? "إغلاق"
                  : "close",style: TextStyle(fontFamily: 'Tajawal',),),
            ),
          ],
        );
      },
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $phoneNumber');
    }
  }

  void _showAppInfo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.locale.languageCode == 'ar'
              ? "حول التطبيق"
              : "about the application",style: TextStyle(fontFamily: 'Tajawal',),),
          content: Text(
              context.locale.languageCode == 'ar'
                  ? "هذا التطبيق يهدف إلى تقديم الدعم النفسي والاجتماعي بطريقة مبتكرة"
                  : "This application aims to provide psychological and social support in an innovative way" ,style: TextStyle(fontFamily: 'Tajawal',),         ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(context.locale.languageCode == 'ar'
                  ? "إغلاق"
                  : "close",style: TextStyle(fontFamily: 'Tajawal',),),
            ),
          ],
        );
      },
    );
  }

  void _showChangeUsernameDialog() {
    TextEditingController usernameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.locale.languageCode == 'ar'
              ? "تغيير اسم المستخدم"
              : "change username",style: TextStyle(fontFamily: 'Tajawal',),),
          content: TextField(
            controller: usernameController,
            decoration: InputDecoration(
              hintText: context.locale.languageCode == 'ar'
                  ? "أدخل اسم المستخدم الجديد"
                  : "Enter the new username",
            ),
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(context.locale.languageCode == 'ar'
                  ? "إلغاء"
                  : "cancel",style: TextStyle(fontFamily: 'Tajawal',),),
            ),
            ElevatedButton(
              onPressed: () async {
                String newUsername = usernameController.text.trim();
                if (newUsername.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.locale.languageCode == 'ar'
                          ? "اسم المستخدم لا يمكن أن يكون فارغًا"
                          : "username cannot be empty",style: TextStyle(fontFamily: 'Tajawal',),),
                    ),
                  );
                  return;
                }
                try {
                  await _auth.currentUser!.updateDisplayName(newUsername);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.locale.languageCode == 'ar'
                        ? "تم تغيير اسم المستخدم"
                        : "username changed",style: TextStyle(fontFamily: 'Tajawal',),)),
                  );
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('حدث خطأ: $e'.tr())),
                  );
                }
              },
              child: Text(context.locale.languageCode == 'ar'
                  ? "حفظ"
                  : "save",style: TextStyle(fontFamily: 'Tajawal',),),
            ),
          ],
        );
      },
    );
  }

  // void _showChangeEmailDialog() {
  //   TextEditingController emailController = TextEditingController();
  //   TextEditingController passwordController = TextEditingController(); // لإدخال كلمة المرور الحالية
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('تغيير البريد الإلكتروني').tr(),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: emailController,
  //               keyboardType: TextInputType.emailAddress,
  //               decoration: InputDecoration(
  //                 hintText: 'أدخل البريد الإلكتروني الجديد',
  //                 labelText: 'البريد الإلكتروني',
  //                 prefixIcon: Icon(Icons.email),
  //                 border: OutlineInputBorder(),
  //               ),
  //             ),
  //             SizedBox(height: 10),
  //             TextField(
  //               controller: passwordController,
  //               obscureText: true,
  //               decoration: InputDecoration(
  //                 hintText: 'أدخل كلمة المرور الحالية',
  //                 labelText: 'كلمة المرور',
  //                 prefixIcon: Icon(Icons.lock),
  //                 border: OutlineInputBorder(),
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text('إلغاء').tr(),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               String newEmail = emailController.text.trim();
  //               String currentPassword = passwordController.text.trim();
  //               if (newEmail.isNotEmpty && _isValidEmail(newEmail) && currentPassword.isNotEmpty) {
  //                 try {
  //                   User? user = FirebaseAuth.instance.currentUser;
  //                   AuthCredential credential = EmailAuthProvider.credential(
  //                     email: user!.email!,
  //                     password: 'كلمة_المرور_الحالية',
  //                   );
  //
  //                   await user.reauthenticateWithCredential(credential);
  //                   await user.updateEmail('newemail@example.com');
  //
  //                   print('تم تحديث البريد الإلكتروني بنجاح');
  //                 } catch (e) {
  //                   print('خطأ: $e');
  //                 }
  //
  //               } else {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(content: Text('يرجى إدخال بريد إلكتروني وكلمة مرور صحيحة.').tr()),
  //                 );
  //               }
  //             },
  //             child: Text('حفظ').tr(),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showChangePasswordDialog() {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.locale.languageCode == 'ar'
              ? "تغيير كلمه المرور"
              : "change password"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: currentPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: context.locale.languageCode == 'ar'
                        ? "أدخل كلمة المرور الحالية"
                        : "Enter your current password",
                    labelText: context.locale.languageCode == 'ar'
                        ? "كلمة المرور الحالية"
                        : "current password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: context.locale.languageCode == 'ar'
                        ? "أدخل كلمة المرور الجديدة"
                        : "Enter new password",
                    labelText: context.locale.languageCode == 'ar'
                        ? "كلمة المرور الجديدة"
                        : "new password",
                    prefixIcon: Icon(Icons.lock_open),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: context.locale.languageCode == 'ar'
                        ? "تأكيد كلمة المرور الجديدة"
                        : "confirm new password",
                    labelText: context.locale.languageCode == 'ar'
                        ? "تأكيد كلمة المرور"
                        : "confirm password",
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(context.locale.languageCode == 'ar'
                  ? "إلغاء"
                  : "cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                String currentPassword = currentPasswordController.text.trim();
                String newPassword = newPasswordController.text.trim();
                String confirmPassword = confirmPasswordController.text.trim();

                if (currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.locale.languageCode == 'ar'
                        ? "يرجى ملء جميع الحقول."
                        : "please fill in all fields")),
                  );
                  return;
                }

                if (newPassword != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.locale.languageCode == 'ar'
                        ? "كلمات المرور الجديدة غير متطابقة."
                        : "the new password do not match")),
                  );
                  return;
                }

                try {
                  User? user = _auth.currentUser;
                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(context.locale.languageCode == 'ar'
                          ? "لم تقم بتسجيل الدخول"
                          : "you are not loggedin")),
                    );
                    return;
                  }
                  AuthCredential credential = EmailAuthProvider.credential(
                    email: user.email!,
                    password: currentPassword,
                  );
                  await user.reauthenticateWithCredential(credential);

                  await user.updatePassword(newPassword);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.locale.languageCode == 'ar'
                        ? "تم تغيير كلمة المرور بنجاح"
                        : "changed password successfuly")),
                  );
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('حدث خطأ: $e'.tr())),
                  );
                }
              },
              child: Text(context.locale.languageCode == 'ar'
                  ? "حفظ"
                  : "save"),
            ),
          ],
        );
      },
    );
  }

  void _logoutUser() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.locale.languageCode == 'ar'
              ? "تأكيد تسجيل الخروج"
              : "confirm signout",style: TextStyle(fontFamily: 'Tajawal',),),
          content: Text(context.locale.languageCode == 'ar'
          ? "هل أنت متأكد أنك تريد تسجيل الخروج؟"
              : "Are you sure that you want signout",style: TextStyle(fontFamily: 'Tajawal',),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(context.locale.languageCode == 'ar'
                  ? "إلغاء"
                  : "cancel",style: TextStyle(fontFamily: 'Tajawal',),),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _auth.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (route) => false);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('حدث خطأ أثناء تسجيل الخروج: $e'.tr())),
                  );
                }
              },
              child: Text(context.locale.languageCode == 'ar'
                  ? "تسجيل الخروج"
                  : "signout",style: TextStyle(fontFamily: 'Tajawal',),),
            ),
          ],
        );
      },
    );
  }
  }

class PhoneCallButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final Uri phoneUri = Uri(
          scheme: 'tel',
          path: '0592153237',
        );

        if (await canLaunchUrl(phoneUri)) {
          await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
        } else {
          print('Could not launch phone call');
        }
      },
      child: Text(context.locale.languageCode == 'ar'
          ? "اتصال هاتفي"
          : "phonecall",style: TextStyle(fontFamily: 'Tajawal',),),
    );
  }
}