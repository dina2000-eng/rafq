import 'package:cloud_firestore/cloud_firestore.dart';

class Counselor {
  String name;
  String specialization;
  String email;
  bool availability;

  Counselor({
    required this.name,
    required this.specialization,
    required this.email,
    required this.availability,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'specialization': specialization,
      'email': email,
      'availability': availability,
    };
  }

  static Counselor fromMap(Map<String, dynamic> map) {
    return Counselor(
      name: map['name'],
      specialization: map['specialization'],
      email: map['email'],
      availability: map['availability'],
    );
  }
}

Future<void> addCounselor() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Counselor counselor = Counselor(
    name: "أحمد الشمري",
    specialization: "الطب النفسي",
    email: "ahmad@example.com",
    availability: true,
  );

  await firestore.collection('counselors').add(counselor.toMap());
  print("تم إضافة المستشار بنجاح");
}

Future<List<Counselor>> getCounselors() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot snapshot = await firestore.collection('counselors').get();

  List<Counselor> counselors = snapshot.docs.map((doc) {
    return Counselor.fromMap(doc.data() as Map<String, dynamic>);
  }).toList();

  return counselors;
}
