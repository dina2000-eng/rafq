import 'package:flutter/material.dart';
import 'package:rafq1/Screens/CounselingPage.dart';

class SelectCounselorForBookingScreen extends StatelessWidget {
  final List<Map<String, String>> counselors = [
    {"id": "dr_ahmed", "name": "د. أحمد"},
    {"id": "dr_sara", "name": "د. سارة"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اختر مستشار للحجز",style: TextStyle(fontFamily: 'Tajawal',),),
      ),
      body: ListView.builder(
        itemCount: counselors.length,
        itemBuilder: (context, index) {
          final counselor = counselors[index];
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(counselor["name"]!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingScreen(counselorId: counselor["id"]!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
