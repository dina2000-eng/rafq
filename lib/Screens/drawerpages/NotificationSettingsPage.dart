import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _messageNotificationsEnabled = true;
  bool _activityNotificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "تخصيص الإشعارات"
            : "Customize notifications",style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: Text(context.locale.languageCode == 'ar'
                ? "إشعارات الرسائل"
                : "Message notifications",style: TextStyle(fontFamily: 'Tajawal',),),
            value: _messageNotificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _messageNotificationsEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: Text(context.locale.languageCode == 'ar'
                ? "إشعارات الأنشطة"
                : "Activity notifications",style: TextStyle(fontFamily: 'Tajawal',),),
            value: _activityNotificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _activityNotificationsEnabled = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
