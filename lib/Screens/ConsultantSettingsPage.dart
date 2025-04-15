import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsultantSettingsPage extends StatefulWidget {
  final String consultantId;

  ConsultantSettingsPage({required this.consultantId});

  @override
  _ConsultantSettingsPageState createState() => _ConsultantSettingsPageState();
}

class _ConsultantSettingsPageState extends State<ConsultantSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _specializationController;
  late TextEditingController _experienceController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _specializationController = TextEditingController();
    _experienceController = TextEditingController();
    _bioController = TextEditingController();
    _loadConsultantData();
  }

  Future<void> _loadConsultantData() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('consultants')
        .doc(widget.consultantId)
        .get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      setState(() {
        _nameController.text = data['name'] ?? '';
        _emailController.text = data['email'] ?? '';
        _specializationController.text = data['specialization'] ?? '';
        _experienceController.text = data['yearsOfExperience']?.toString() ?? '';
        _bioController.text = data['bio'] ?? '';
      });
    }
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('consultants')
            .doc(widget.consultantId)
            .update({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'specialization': _specializationController.text.trim(),
          'yearsOfExperience': int.tryParse(_experienceController.text.trim()) ?? 0,
          'bio': _bioController.text.trim(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.locale.languageCode == 'ar'
              ? "تم حفظ التعديلات بنجاح"
              : "Your changes have been saved successfully.")),
        );
      } catch (e) {
        print('حدث خطأ أثناء الحفظ: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.locale.languageCode == 'ar'
              ? "فشل في حفظ التعديلات"
              : "Failed to save changes")),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "إعدادات الحساب"
            : "account settings", style: TextStyle(fontFamily: 'Tajawal')),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: context.locale.languageCode == 'ar'
                    ? "الاسم"
                    : "the name"),
                validator: (value) => value!.isEmpty ? context.locale.languageCode == 'ar'
                    ? "يرجى إدخال الاسم"
                    : "Please enter name" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: context.locale.languageCode == 'ar'
                    ? "البريد الإلكتروني"
                    : "e-mail"),
                validator: (value) => value!.isEmpty ? context.locale.languageCode == 'ar'
                    ? "يرجى إدخال البريد الإلكتروني"
                    : "Please enter your email" : null,
              ),
              TextFormField(
                controller: _specializationController,
                decoration: InputDecoration(labelText:context.locale.languageCode == 'ar'
                    ? "التخصص"
                    : "Specialization" ),
              ),
              TextFormField(
                controller: _experienceController,
                decoration: InputDecoration(labelText:context.locale.languageCode == 'ar'
                    ? "سنوات الخبرة"
                    : "Years of experience"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _bioController,
                decoration: InputDecoration(labelText: context.locale.languageCode == 'ar'
                    ? "نبذة تعريفية"
                    : "Introduction"),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text(context.locale.languageCode == 'ar'
                    ? "حفظ التعديلات"
                    : "Save changes"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
