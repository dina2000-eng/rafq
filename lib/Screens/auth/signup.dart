import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafq1/Screens/HomePage.dart';
import 'package:rafq1/Screens/ConsultantHomePage.dart';
import 'package:rafq1/Screens/auth/loginscreen.dart';

class SignupScreen extends StatelessWidget {
  final String role;
  SignupScreen({required this.role, Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();


  Future<void> _signUp(BuildContext context) async {
    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog(context, 'كلمات المرور غير متطابقة'.tr());
      return;
    }
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      String userId = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'fullName': _fullNameController.text.trim(),
        'email': _emailController.text.trim(),
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
        if (role == 'consultant') ...{
          'phone': _phoneController.text.trim(),
          'specialty': _specialtyController.text.trim(),
          'experience': _experienceController.text.trim(),
        }
      });

      if (role == 'consultant') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ConsultantHomePage(consultantId: 'fYT467LJIKbjc8BJw8k8VIvrPpJ2')),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(forumId: '')),
        );
      }
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(context, _getErrorMessage(e.code));
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'البريد الإلكتروني غير صالح'.tr();
      case 'weak-password':
        return 'كلمة المرور ضعيفة'.tr();
      case 'email-already-in-use':
        return 'البريد الإلكتروني مسجل بالفعل'.tr();
      default:
        return 'حدث خطأ غير معروف'.tr();
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

  Widget _buildTextField(
      TextEditingController controller, String label, bool obscureText) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label.tr(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
      style: TextStyle(
        fontFamily: 'Tajawal',
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String title = role == 'consultant' ? context.locale.languageCode == 'ar'
        ? "تسجيل كمستشار"
        : "register as consultant" : context.locale.languageCode == 'ar'
        ? "تسجيل مستخدم جديد"
        : "register a new user";
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08, vertical: height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/signup.jpeg',
                height: height * 0.2,
                fit: BoxFit.contain,
              ),
              SizedBox(height: height * 0.03),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: width * 0.08,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: height * 0.04),
              _buildTextField(_fullNameController, context.locale.languageCode == 'ar'
                  ? "الاسم الكامل"
                  : "full name", false),
              SizedBox(height: height * 0.03),
              _buildTextField(_emailController, 'loginscreen.email'.tr(), false),
              SizedBox(height: height * 0.03),
              _buildTextField(_passwordController, 'loginscreen.password'.tr(), true),
              SizedBox(height: height * 0.03),
              _buildTextField(_confirmPasswordController, context.locale.languageCode == 'ar'
                  ? "تأكيد كلمة المرور"
                  : "confirm password", true),
              if (role == 'consultant') ...[
                SizedBox(height: height * 0.03),
                _buildTextField(_phoneController, context.locale.languageCode == 'ar' ? "رقم الهاتف" : "Phone Number", false),
                SizedBox(height: height * 0.03),
                _buildTextField(_specialtyController, context.locale.languageCode == 'ar' ? "التخصص" : "Specialty", false),
                SizedBox(height: height * 0.03),
                _buildTextField(_experienceController, context.locale.languageCode == 'ar' ? "الخبرة (مثال: 5 سنوات)" : "Experience (e.g., 5 years)", false),
              ],

              SizedBox(height: height * 0.05),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.2, vertical: height * 0.015),
                  backgroundColor: Colors.green.shade900,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () => _signUp(context),
                child: Text(
                  context.locale.languageCode == 'ar'
                      ? "تسجيل"
                      : "registration",
                  style: TextStyle(fontSize: width * 0.05, color: Colors.white,fontFamily: 'Tajawal', ),
                ).tr(),
              ),
              SizedBox(height: height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.locale.languageCode == 'ar'
                      ? "لديك حساب بالفعل؟"
                      : "you already have an account",
                  style: TextStyle(fontFamily: 'Tajawal', ),),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    ),
                    child: Text(
                      'loginscreen.login'.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        fontFamily: 'Tajawal',
                      ),
                    ).tr(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
