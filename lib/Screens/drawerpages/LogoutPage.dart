import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rafq1/Screens/auth/loginscreen.dart';

class LogoutPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LogoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإعدادات'.tr(),style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          'تسجيل الخروج'.tr(),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red,fontFamily: 'Tajawal',),
        ).tr(),
        onTap: () {
          _showLogoutDialog(context);
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('تأكيد تسجيل الخروج'.tr(),style: TextStyle(fontFamily: 'Tajawal',),),
          content: Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'.tr(),style: TextStyle(fontFamily: 'Tajawal',),),
          actions: <Widget>[
            TextButton(
              child: Text('نعم').tr(),
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
            ),
            TextButton(
              child: Text('لا'.tr(),style: TextStyle(fontFamily: 'Tajawal',
              ),),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
