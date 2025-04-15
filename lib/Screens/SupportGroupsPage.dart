import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:convert';
import 'package:rafq1/Screens/sendemail.dart';

class SupportGroupPage extends StatelessWidget {
  final List<String> topics = [
    'جلسات دعم جماعية',
    'مجموعات دعم حسب الموضوعات',
    'تفاعل حي ومباشر',
    'ورش العمل عبر الإنترنت',
    'تبادل الخبرات الشخصية',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مجموعات الدعم',style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Color(0xFF6C80F4),
        elevation: 4,
      ),
      body: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              tileColor: Color(0xFFF0F5FF),
              title: Text(
                topics[index],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                  color: Color(0xFF4F5B76),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupDetailsPage(topic: topics[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class GroupDetailsPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final String topic;

  GroupDetailsPage({required this.topic});

  get mailer => null;


  void sendEmail() async {
    final smtpServer = SmtpServer(
      'smtp-relay.mailin.fr',
      username: 'dinaelhallaq20@example.com',
      password: 'dina.1@2000',
      port: 587,
    );

    final emailMessage = mailer.Message()
      ..from = mailer.Address('dinaelhallaq20@example.com')
      ..recipients.add('recipient@example.com')
      ..subject = 'Test'
      ..text = 'This is a test email from Flutter app.';

    try {
      final sendReport = await send(emailMessage, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Error: ' + e.toString());
    }
  }


  Future<void> sendSubscriptionDetails(String name, String email, String topic) async {
    try {
      await FirebaseFirestore.instance.collection('subscriptions').add({
        'name': name,
        'email': email,
        'topic': topic,
        'timestamp': FieldValue.serverTimestamp(),
      });
      await sendWelcomeEmail(email, name);
    } catch (e) {
      print('Error adding subscription: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$topic'), backgroundColor: Color(0xFF6C80F4)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الانضمام إلى المجموعة: $topic',
                style: TextStyle(fontSize: 18, color: Color(0xFF4F5B76),fontFamily: 'Tajawal',)),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'الاسم',
                labelStyle: TextStyle(color: Color(0xFF4F5B76),fontFamily: 'Tajawal',),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4F5B76), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6C80F4), width: 2),
                ),
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'البريد الإلكتروني',
                labelStyle: TextStyle(color: Color(0xFF4F5B76),fontFamily: 'Tajawal',),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4F5B76), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6C80F4), width: 2),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await sendSubscriptionDetails(
                  nameController.text,
                  emailController.text,
                  topic,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6C80F4),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('تأكيد', style: TextStyle(color: Colors.white,fontFamily: 'Tajawal',)),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupContentPage extends StatelessWidget {
  final String topic;

  GroupContentPage({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تفاصيل المجموعة',style: TextStyle(fontFamily: 'Tajawal',),), backgroundColor: Color(0xFF6C80F4)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDescription(topic),
            SizedBox(height: 20),
            _buildContentForTopic(topic, context),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(String topic) {
    String description = '';
    switch (topic) {
      case 'جلسات دعم جماعية':
        description = 'جلسات دعم جماعية تهدف إلى تقديم مساعدة نفسية للمشاركين في بيئة آمنة.';
        break;
      case 'مجموعات دعم حسب الموضوعات':
        description = 'مجموعات تتعلق بمواضيع مختلفة مثل القلق، الاكتئاب، والعلاقات الاجتماعية.';
        break;
      case 'تفاعل حي ومباشر':
        description = 'تفاعل مباشر مع مستشارين عبر الإنترنت، حيث يمكن للمشاركين طرح أسئلتهم.';
        break;
      case 'ورش العمل عبر الإنترنت':
        description = 'ورش عمل تقدم فرصًا تعليمية للمشاركين حول موضوعات مختلفة تتعلق بالصحة النفسية.';
        break;
      case 'تبادل الخبرات الشخصية':
        description = 'فرصة للمشاركين لمشاركة تجاربهم الشخصية والدروس المستفادة في بيئة داعمة.';
        break;
      default:
        description = 'محتوى غير متوفر';
    }

    return Text(
      description,
      style: TextStyle(
        fontSize: 16,
        color: Color(0xFF4F5B76),
      ),
    );
  }

  Widget _buildContentForTopic(String topic, BuildContext context) {
    switch (topic) {
      case 'جلسات دعم جماعية':
        return _buildActionButton(context, 'اشترك في الجلسة', 'جلسة دعم جماعية');
      case 'مجموعات دعم حسب الموضوعات':
        return _buildActionButton(context, 'انضم للمجموعة', 'مجموعة حسب الموضوع');
      case 'تفاعل حي ومباشر':
        return _buildActionButton(context, 'ابدأ التفاعل الحي', 'تفاعل حي');
      case 'ورش العمل عبر الإنترنت':
        return _buildActionButton(context, 'اشترك في الورشة', 'ورشة العمل');
      case 'تبادل الخبرات الشخصية':
        return _buildActionButton(context, 'شارك تجربتك', 'تبادل الخبرات');
      default:
        return Center(child: Text('محتوى غير متوفر',style: TextStyle(fontFamily: 'Tajawal',),));
    }
  }

  Widget _buildActionButton(BuildContext context, String buttonText, String topic) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              _showSubscriptionForm(context, topic);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6C80F4),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(buttonText, style: TextStyle(color: Colors.white,fontFamily: 'Tajawal',),),
          ),
        ],
      ),
    );
  }

  void _showSubscriptionForm(BuildContext context, String topic) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('التسجيل في $topic',style: TextStyle(fontFamily: 'Tajawal',),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'الاسم'),
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'البريد الإلكتروني',
                  labelStyle: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showConfirmationDialog(context, topic, nameController.text, emailController.text);
              },
              child: Text('تأكيد',style: TextStyle(fontFamily: 'Tajawal',),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء',style: TextStyle(fontFamily: 'Tajawal',),),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, String topic, String name, String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تم التسجيل بنجاح',style: TextStyle(fontFamily: 'Tajawal',),),
          content: Text('تم التسجيل في $topic بنجاح. سيتم إرسال التفاصيل قريبًا.',style: TextStyle(fontFamily: 'Tajawal',),),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await sendSubscriptionDetails(name, email, topic);
                Navigator.of(context).pop();
              },
              child: Text('موافق',style: TextStyle(fontFamily: 'Tajawal',),),
            ),
          ],
        );
      },
    );
  }

  Future<void> sendSubscriptionDetails(String name, String email, String topic) async {
    try {
      await FirebaseFirestore.instance.collection('subscriptions').add({
        'name': name,
        'email': email,
        'topic': topic,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('تم التسجيل بنجاح');
    } catch (e) {
      print('فشل التسجيل: $e');
    }
  }
}
