import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // إضافة بيانات إلى قاعدة البيانات
  Future<void> addUserData(String name, String email) async {
    try {
      await _db.collection('users').add({
        'name': name,
        'email': email,
        'created_at': FieldValue.serverTimestamp(),
      });
      print('Data added successfully');
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  // جلب بيانات من قاعدة البيانات
  Future<void> getUsersData() async {
    try {
      QuerySnapshot snapshot = await _db.collection('users').get();
      snapshot.docs.forEach((doc) {
        print(doc.data());
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
