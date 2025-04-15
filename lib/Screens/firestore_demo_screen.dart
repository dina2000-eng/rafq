// import 'package:flutter/material.dart';
// import '../services/firestore_service.dart';
//
// class FirestoreDemoScreen extends StatefulWidget {
//   @override
//   _FirestoreDemoScreenState createState() => _FirestoreDemoScreenState();
// }
//
// class _FirestoreDemoScreenState extends State<FirestoreDemoScreen> {
//   final FirestoreService _firestoreService = FirestoreService();
//   List<Map<String, dynamic>> _users = [];
//
//   // جلب البيانات عند فتح الشاشة
//   @override
//   void initState() {
//     super.initState();
//     _fetchUsersData();
//   }
//
//   // وظيفة لجلب البيانات من Firestore
//   void _fetchUsersData() async {
//     List<Map<String, dynamic>> users = await _firestoreService.getUsersData();
//     setState(() {
//       _users = users;
//     });
//   }
//
//   // تصميم الواجهة
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestore Demo'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               await _firestoreService.addUserData('John Doe', 25);
//               _fetchUsersData(); // تحديث البيانات بعد الإضافة
//             },
//             child: Text('Add User'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _users.length,
//               itemBuilder: (context, index) {
//                 final user = _users[index];
//                 return ListTile(
//                   title: Text(user['name']),
//                   subtitle: Text('Age: ${user['age']}'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
