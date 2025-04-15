import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditConsultantProfile extends StatefulWidget {
  final String consultantId;

  const EditConsultantProfile({super.key, required this.consultantId});

  @override
  State<EditConsultantProfile> createState() => _EditConsultantProfileState();
}

class _EditConsultantProfileState extends State<EditConsultantProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController bioController;
  late TextEditingController experienceController;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    bioController = TextEditingController();
    experienceController = TextEditingController();
    fetchData();
  }

  Future<void> fetchData() async {
    final doc = await FirebaseFirestore.instance
        .collection('consultants')
        .doc(widget.consultantId)
        .get();

    if (doc.exists) {
      final data = doc.data()!;
      nameController.text = data['name'] ?? '';
      bioController.text = data['bio'] ?? '';
      experienceController.text = data['yearsOfExperience'] ?? '';
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> saveData() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection('consultants')
          .doc(widget.consultantId)
          .update({
        'name': nameController.text.trim(),
        'bio': bioController.text.trim(),
        'yearsOfExperience': experienceController.text.trim(),
      });

      print("Data saved!");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.locale.languageCode == 'ar'
            ? "تم تحديث البيانات بنجاح ✅"
            : "Data updated successfully ✅")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "تعديل الملف الشخصي"
            : "Edit profile", style: TextStyle(fontFamily: 'Tajawal')),
        backgroundColor: Colors.teal,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: context.locale.languageCode == 'ar'
                    ? "الاسم"
                    : "Name"),
                validator: (value) => value!.isEmpty ?context.locale.languageCode == 'ar'
                    ? "أدخل الاسم"
                    : "Enter name"  : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: experienceController,
                decoration: InputDecoration(labelText:context.locale.languageCode == 'ar'
                    ? "سنوات الخبرة"
                    : "Years of experience"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ?context.locale.languageCode == 'ar'
                    ? "أدخل سنوات الخبرة"
                    : "Enter years of experience" : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: bioController,
                decoration: InputDecoration(labelText:context.locale.languageCode == 'ar'
                    ? "النبذة"
                    : "Overview"),
                maxLines: 5,
                validator: (value) => value!.isEmpty ? context.locale.languageCode == 'ar'
                    ? "أدخل نبذة عنك"
                    : "Enter a brief about yourself" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: saveData,
                icon: Icon(Icons.save),
                label: Text(context.locale.languageCode == 'ar'
                    ? "حفظ التعديلات"
                    : "Save changes"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
