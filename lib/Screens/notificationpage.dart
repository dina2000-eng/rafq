import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> notifications = [];
  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _setupFirebaseMessaging();
  }

  void _requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Widget _buildNotificationsList() {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('notifications')
          .where('userId', isEqualTo: currentUserId)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('خطأ: ${snapshot.error}'));
        }

        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return Center(child: Text('لا توجد إشعارات جديدة'));
        }

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            bool isRead = data['isRead'] ?? false;
            return ListTile(
              title: Text(
                data['title'] ?? '',
                style: TextStyle(fontWeight: isRead ? FontWeight.normal : FontWeight.bold, fontFamily: 'Tajawal'),
              ),
              subtitle: Text(data['body'] ?? '', style: TextStyle(fontFamily: 'Tajawal')),
              leading: Icon(
                isRead ? Icons.notifications_none : Icons.notifications_active,
                color: isRead ? Colors.grey : Colors.blue,
              ),
              onTap: () async {
                // عند الضغط، نحدث حالة الإشعار ليصبح 'مقروء'
                await docs[index].reference.update({'isRead': true});
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationDetailsPage(
                      title: data['title'] ?? '',
                      body: data['body'] ?? '',
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _handleNotificationClick(RemoteMessage message) {
    print("✅ تم النقر على الإشعار!");
    print("📌 العنوان: ${message.notification?.title}");
    print("📌 المحتوى: ${message.notification?.body}");

    setState(() {
      for (var notification in notifications) {
        if (notification['title'] == message.notification?.title &&
            notification['body'] == message.notification?.body) {
          if (!notification['read']) {
            notification['read'] = true;
            unreadCount--;
          }
          break;
        }
      }
    });

    Navigator.pushNamed(context, '/details', arguments: message.data);
  }

  void _setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("🔔 تم استقبال إشعار:");
      print("📌 العنوان: ${message.notification?.title}");
      print("📌 المحتوى: ${message.notification?.body}");
      print("📌 البيانات: ${message.data}");

      // إضافة الإشعار إلى Firestore
      FirebaseFirestore.instance.collection('notifications').add({
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'title': message.notification?.title ?? 'إشعار جديد',
        'body': message.notification?.body ?? '',
        'isRead': false,
        'timestamp': Timestamp.now(),
      }).then((_) {
        print("✅ تم حفظ الإشعار في Firestore.");
      }).catchError((error) {
        print("🚫 حدث خطأ أثناء حفظ الإشعار: $error");
      });

      // تحديث الحالة المحلية لعرض الإشعار في الصفحة (اختياري)
      setState(() {
        notifications.insert(0, {
          'title': message.notification?.title ?? 'إشعار جديد',
          'body': message.notification?.body ?? '',
          'read': false,
        });
        unreadCount++;
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📩 تم فتح التطبيق من إشعار!");
      _handleNotificationClick(message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print("🔄 تم تشغيل التطبيق من إشعار سابق");
        _handleNotificationClick(message);
      }
    });
  }


  void _markAsRead(int index) {
    if (!notifications[index]['read']) {
      setState(() {
        notifications[index]['read'] = true;
        unreadCount = unreadCount > 0 ? unreadCount - 1 : 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('الإشعارات',style: TextStyle(fontFamily: 'Tajawal',),),
            if (unreadCount > 0)
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.red,
                  child: Text(
                    '$unreadCount',
                    style: TextStyle(color: Colors.white, fontSize: 14,fontFamily: 'Tajawal',),
                  ),
                ),
              ),
          ],
        ),
      ),
      body: notifications.isNotEmpty
          ? ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          bool isRead = notifications[index]['read'];
          return ListTile(
            title: Text(
              notifications[index]['title'],
              style: TextStyle(fontWeight: isRead ? FontWeight.normal : FontWeight.bold,fontFamily: 'Tajawal',),
            ),
            subtitle: Text(notifications[index]['body'],style: TextStyle(fontFamily: 'Tajawal',),),
            leading: Icon(
              isRead ? Icons.notifications_none : Icons.notifications_active,
              color: isRead ? Colors.grey : Colors.blue,
            ),
            onTap: () {
              _markAsRead(index);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationDetailsPage(
                    title: notifications[index]['title'],
                    body: notifications[index]['body'],
                  ),
                ),
              );
            },
          );
        },
      )
          : Center(child: Text('لا توجد إشعارات جديدة',style: TextStyle(fontFamily: 'Tajawal',),)),
    );
  }
}

class NotificationDetailsPage extends StatelessWidget {
  final String title;
  final String body;

  const NotificationDetailsPage({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(body, style: TextStyle(fontSize: 18,fontFamily: 'Tajawal',)),
      ),
    );
  }
}
