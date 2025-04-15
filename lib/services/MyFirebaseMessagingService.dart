import 'package:firebase_messaging/firebase_messaging.dart';

mixin MyFirebaseMessagingService implements FirebaseMessaging {
  @override
  Future<void> onMessageOpenedApp(RemoteMessage message) async {
    print("🔔 تم فتح التطبيق من إشعار!");
  }
}
