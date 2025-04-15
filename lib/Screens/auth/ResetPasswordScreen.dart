import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rafq1/Screens/auth/loginscreen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _message = '';
  bool _isLoading = false;

  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  // Future<void> _resetPassword() async {
  //   setState(() {
  //     _isLoading = true;
  //     _message = '';
  //   });
  //
  //   if (!_isValidEmail(_emailController.text)) {
  //     setState(() {
  //       _isLoading = false;
  //       _message = 'يرجى إدخال بريد إلكتروني صالح.';
  //     });
  //     return;
  //   }
  //
  //   try {
  //     await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
  //     setState(() {
  //       _isLoading = false;
  //       _message = 'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني.';
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     setState(() {
  //       _isLoading = false;
  //       if (e.code == 'user-not-found') {
  //         _message = 'لم يتم العثور على حساب مرتبط بهذا البريد الإلكتروني.';
  //       } else {
  //         _message = 'حدث خطأ أثناء إرسال الرابط. يرجى المحاولة مرة أخرى.';
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(context.locale.languageCode == 'ar'
            ? "إعادة تعيين كلمة المرور"
            : "Reset password",
          style: TextStyle(fontFamily: 'Tajawal',),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.08, vertical: height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        Text(context.locale.languageCode == 'ar'
        ? "أدخل بريدك الإلكتروني لإعادة تعيين كلمة المرور"
            : "write your email to reset password",
              style: TextStyle(fontSize: width * 0.05,
                  fontWeight: FontWeight.bold ,fontFamily: 'Tajawal',),
              textAlign: TextAlign.center,
            ).tr(),
            SizedBox(height: height * 0.05),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'loginscreen.email'.tr(),
                labelStyle: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.email, color: Colors.blue.shade800),
              ),
            ),
            SizedBox(height: height * 0.03),
            ElevatedButton(
              onPressed:(){},// _isLoading ? null : _resetPassword,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: width * 0.2, vertical: height * 0.015),
                backgroundColor: Colors.blue.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
                  : Text(context.locale.languageCode == 'ar'
                  ? "إرسال"
                  : "send",
                style: TextStyle(fontSize: width * 0.05, color: Colors.white ,fontFamily: 'Tajawal'),
              ).tr(),
            ),
            SizedBox(height: height * 0.02),
            Text(
              _message,
              style: TextStyle(
                fontSize: width * 0.04,
                color: _message.contains('خطأ') ? Colors.red : Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height * 0.04),
            // TextButton(
            //   onPressed: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(builder: (context) => LoginScreen()),
            //     );
            //   },
            //   child: Text(
            //     'عودة إلى تسجيل الدخول'.tr(),
            //     style: TextStyle(color: Colors.blue, fontSize: width * 0.04),
            //   ).tr(),
            // ),
          ],
        ),
      ),
    );
  }
}
