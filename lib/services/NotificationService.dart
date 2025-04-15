import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    print("Device Token: $token"); // سيظهر في الـ Debug Console
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  NotificationService().getToken(); // استدعاء الوظيفة لطباعة التوكن

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("FCM Token Example")),
        body: Center(child: Text("Check Debug Console for Token")),
      ),
    );
  }
}
