// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// class TopicDetailPage extends StatelessWidget {
//   final String forumId;
//   final String topicId;
//   final String topicTitle;
//
//   const TopicDetailPage({
//     super.key,
//     required this.forumId,
//     required this.topicId,
//     required this.topicTitle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(topicTitle),
//         backgroundColor: Color(0xFF42A5F5),
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('forums')
//             .doc(forumId)
//             .collection('topics')
//             .doc(topicId)
//             .snapshots(),
//         builder: (context, snapshot) {
//           // إذا كانت البيانات في حالة انتظار، نعرض مؤشر التحميل
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           // إذا لم يكن هناك بيانات أو إذا كان المستند غير موجود
//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return Center(child: Text("الموضوع غير موجود"));
//           }
//
//           // الحصول على البيانات من المستند
//           var topic = snapshot.data!.data() as Map<String, dynamic>; // تأكد من تحويل البيانات إلى Map
//           var title = topic.containsKey('name') ? topic['name'] : 'اسم غير متوفر';
//           var description = topic.containsKey('description') ? topic['description'] : 'وصف غير متوفر';
//           print("Firestore Data: ${snapshot.data!.data()}");
//
//
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 10),
//                 Text(description),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
