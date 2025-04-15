import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rafq1/Screens/Counselor.dart';

class AddCounselorScreen extends StatefulWidget {
  @override
  _AddCounselorScreenState createState() => _AddCounselorScreenState();
}

class _AddCounselorScreenState extends State<AddCounselorScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specializationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isAvailable = true;

  void _addCounselor() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Counselor newCounselor = Counselor(
      name: _nameController.text,
      specialization: _specializationController.text,
      email: _emailController.text,
      availability: _isAvailable,
    );

    await firestore.collection('counselors').add(newCounselor.toMap());
    print("تم إضافة المستشار بنجاح");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إضافة مستشار",style: TextStyle(fontFamily: 'Tajawal',),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "الاسم"),
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _specializationController,
              decoration: InputDecoration(labelText: "التخصص"),
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "البريد الإلكتروني"),
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Text("متاح",style: TextStyle(fontFamily: 'Tajawal',),),
                Checkbox(
                  value: _isAvailable,
                  onChanged: (bool? value) {
                    setState(() {
                      _isAvailable = value!;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _addCounselor,
              child: Text("إضافة المستشار",style: TextStyle(fontFamily: 'Tajawal',),),
            ),
          ],
        ),
      ),
    );
  }
}
