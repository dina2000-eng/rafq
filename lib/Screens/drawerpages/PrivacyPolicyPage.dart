import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.locale.languageCode == 'ar'
              ? "سياسة الخصوصية"
              : "privacy policy",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                 context.locale.languageCode == 'ar'
                     ? "مقدمة:"
                     : "introduction:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueAccent,
                    fontFamily: 'Tajawal',
                  ),
                ),
               Text(
                 context.locale.languageCode == 'ar'
                     ? "تطبيقنا يلتزم بحماية خصوصية المستخدمين. يتم جمع بعض البيانات لتحسين تجربتك وتقديم خدمات مخصصة."
                     : "Our app is committed to protecting user privacy. Some data is collected to improve your experience and provide personalized services.",
                  style: TextStyle(fontSize: 16, color: Colors.black87,fontFamily: 'Tajawal',),
                ).tr(),
              SizedBox(height: 16),
               Text(
                 context.locale.languageCode == 'ar'
                     ? "البيانات التي نقوم بجمعها:"
                     : "Data we collect:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueAccent,
                    fontFamily: 'Tajawal',
                  ),
                ).tr(),
               Text(
                 context.locale.languageCode == 'ar'
                     ? "نقوم بجمع بيانات شخصية مثل الاسم، البريد الإلكتروني، بيانات الموقع، وبعض البيانات المتعلقة باستخدام التطبيق لتحسين الأداء."
                     : "We collect personal data such as name, email, location data, and some data related to the use of the application to improve performance.",
                  style: TextStyle(fontSize: 16, color: Colors.black87,fontFamily: 'Tajawal',),
                ).tr(),
              SizedBox(height: 16),
              Text(
                context.locale.languageCode == 'ar'
                    ? "كيف نستخدم بياناتك:"
                    : "How we use your data:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueAccent,
                    fontFamily: 'Tajawal',
                  ),
                ).tr(),
               Text(
                 context.locale.languageCode == 'ar'
                     ? "نستخدم البيانات لتحسين الأداء، إرسال إشعارات هامة للمستخدم، وتقديم خدمات مخصصة وفقًا لاحتياجات المستخدم."
                     : "We use data to improve performance, send important notifications to the user, and provide services tailored to the user's needs.",
                  style: TextStyle(fontSize: 16, color: Colors.black87,fontFamily: 'Tajawal',),
                ).tr(),
              SizedBox(height: 16),
               Text(
                 context.locale.languageCode == 'ar'
                     ? "مشاركة البيانات مع أطراف ثالثة:"
                     : "Sharing data with third parties:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueAccent,
                    fontFamily: 'Tajawal',
                  ),
                ).tr(),
              Text(
                context.locale.languageCode == 'ar'
                    ? "نحن لا نشارك البيانات مع أطراف ثالثة إلا في حال كانت هناك ضرورة لذلك مثل الشركاء أو خدمات التحليلات المساعدة."
                    : "We do not share data with third parties unless necessary, such as partners or analytics services.",
                  style: TextStyle(fontSize: 16, color: Colors.black87,fontFamily: 'Tajawal',),
                ).tr(),
              SizedBox(height: 16),
              Text(
                context.locale.languageCode == 'ar'
                    ? "حماية البيانات:"
                    : "Data Protection:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueAccent,
                    fontFamily: 'Tajawal',
                  ),
                ).tr(),
               Text(
                 context.locale.languageCode == 'ar'
                     ? "نحن نتخذ جميع التدابير الأمنية اللازمة مثل التشفير لحماية بيانات المستخدمين."
                     : "We take all necessary security measures such as encryption to protect user data.",
                  style: TextStyle(fontSize: 16, color: Colors.black87,fontFamily: 'Tajawal',),
                ).tr(),
              SizedBox(height: 16),
              Text(
                context.locale.languageCode == 'ar'
                    ? "حقوق المستخدمين"
                    : "User rights",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueAccent,
                    fontFamily: 'Tajawal',
                  ),
                ).tr(),
               Text(
                 context.locale.languageCode == 'ar'
                     ? "يحق للمستخدمين الوصول إلى بياناتهم وتحديثها أو حذفها من خلال الإعدادات. يمكنهم أيضًا تقديم طلبات خصوصية مثل حذف الحساب أو الانسحاب من جمع البيانات."
                     : "Users have the right to access, update, or delete their data through Settings. They can also submit privacy requests such as deleting their account or opting out of data collection.",
                  style: TextStyle(fontSize: 16, color: Colors.black87,fontFamily: 'Tajawal',),
                ).tr(),
              SizedBox(height: 16),
               Text(
                 context.locale.languageCode == 'ar'
                     ? "الكوكيز :"
                     : "Cookies:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueAccent,
                    fontFamily: 'Tajawal',
                  ),
                ).tr(),
             Text(
               context.locale.languageCode == 'ar'
                   ? "نستخدم تقنيات الكوكيز لتحسين تجربة المستخدم، مثل حفظ تفضيلات اللغة وغيرها. يمكن للمستخدمين إدارة تفضيلات الكوكيز عبر إعدادات المتصفح."
                   : "We use cookies to enhance user experience, such as storing language preferences and more. Users can manage their cookie preferences through their browser settings.",
                  style: TextStyle(fontSize: 16, color: Colors.black87,fontFamily: 'Tajawal',),
                ).tr(),
              SizedBox(height: 16),
              Text(
                context.locale.languageCode == 'ar'
                    ? "تغييرات في سياسة الخصوصية:"
                    : "Changes to the Privacy Policy:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueAccent,
                    fontFamily: 'Tajawal',
                  ),
                ).tr(),
               Text(
                 context.locale.languageCode == 'ar'
                     ? "سيتم تحديث سياسة الخصوصية من وقت لآخر، وسيتم إعلام المستخدمين بأي تغييرات تطرأ على هذه السياسة."
                     : "This Privacy Policy will be updated from time to time, and users will be notified of any changes to this policy.",
                  style: TextStyle(fontSize: 16, color: Colors.black87,fontFamily: 'Tajawal',),
                ).tr(),
              SizedBox(height: 16),
               Text(
                 context.locale.languageCode == 'ar'
                     ? "معلومات الاتصال:"
                     : "Contact Information:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueAccent,
                    fontFamily: 'Tajawal',
                  ),
                ).tr(),
               Text(
                 context.locale.languageCode == 'ar'
                     ? "لأي استفسارات حول سياسة الخصوصية، يمكن للمستخدمين التواصل مع فريق الدعم عبر البريد الإلكتروني: support@example.com"
                     : "For any inquiries about the privacy policy, users can contact the support team via email: support@example.com",
                  style: TextStyle(fontSize: 16, color: Colors.black87,fontFamily: 'Tajawal',),
                ).tr(),
            ],
          ),
        ),
      ),
    );
  }
}
