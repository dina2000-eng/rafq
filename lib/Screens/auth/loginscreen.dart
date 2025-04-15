import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafq1/Screens/AdminPanel.dart';
import 'package:rafq1/Screens/HomePage.dart';
import 'package:rafq1/Screens/ConsultantHomePage.dart';
import 'package:rafq1/Screens/auth/ResetPasswordScreen.dart';
import 'package:rafq1/Screens/auth/signup.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      String uid = userCredential.user!.uid;

      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        String role = userDoc.get('role');
        if (role == 'consultant') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ConsultantHomePage(consultantId: 'fYT467LJIKbjc8BJw8k8VIvrPpJ2')),
          );
        } else if (role == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminPanel()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(forumId: '')),
          );
        }
      } else {
        _showErrorDialog(context, 'حدث خطأ أثناء جلب بيانات المستخدم.'.tr());
      }
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(context, _getErrorMessage(e.code));
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("خطأ".tr()),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("حسنًا".tr()),
          ),
        ],
      ),
    );
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'لا يوجد مستخدم بهذا البريد الإلكتروني.'.tr();
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة.'.tr();
      default:
        return 'حدث خطأ أثناء تسجيل الدخول.'.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade100, Colors.purple.shade100],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.08, vertical: height * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/loginscreen.jpg',
                    height: height * 0.2,
                    width: width * 0.8,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: height * 0.03),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'loginscreen.email'.tr(),
                      labelStyle: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: height * 0.03),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'loginscreen.password'.tr(),
                      labelStyle: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPasswordScreen()),
                        );
                      },
                      child: Text(
                        'loginscreen.forgetyourpassword'.tr(),
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: width * 0.04,
                          color: Colors.purple,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  ElevatedButton(
                    onPressed: () => _signIn(context),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.2, vertical: height * 0.015),
                      backgroundColor: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text("loginscreen.login".tr(),
                      style:
                      TextStyle(fontSize: width * 0.05,
                          color: Colors.white,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(context.locale.languageCode == 'ar'
                          ? "ليس لديك حساب؟"
                          : "you do not have an account",
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                        ),),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(role: 'user'),
                            ),
                          );
                        },
                        child: Text(context.locale.languageCode == 'ar'
                            ? "سجل الآن"
                            : "Register Now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(role: 'user'),
                            ),
                          );
                        },
                        child: Text(
                          "loginscreen.registerasuser".tr(),
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(role: 'consultant'),
                            ),
                          );
                        },
                        child: Text(
                          "loginscreen.registerasconsultant".tr(),
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
