// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rafq1/Screens/MessageDetailPage.dart';
//
// class MessagesPage extends StatefulWidget {
//   @override
//   _MessagesPageState createState() => _MessagesPageState();
// }
//
// class _MessagesPageState extends State<MessagesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('الرسائل'.tr()),
//         backgroundColor: Colors.teal.shade300,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('chats') // مجموعة المحادثات
//             .orderBy('timestamp', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('لا توجد محادثات بعد'.tr()));
//           }
//
//           var chats = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: chats.length,
//             itemBuilder: (context, index) {
//               var chat = chats[index];
//               var data = chat.data() as Map<String, dynamic>;
//
//               String chatName = data['name'] ?? 'محادثة جديدة';
//               String chatId = chat.id;
//               int unreadMessageCount = data['unreadMessageCount'] ?? 0; // استرجاع عدد الرسائل غير المقروءة
//
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                 child: GestureDetector(
//                   onTap: () {
//                     FirebaseFirestore.instance
//                         .collection('chats')
//                         .doc(chatId)
//                         .update({'unreadMessageCount': 0});
//
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => MessageDetailPage(chatId: chatId),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       children: [
//                         Stack(
//                           children: [
//                             Icon(
//                               Icons.chat_bubble_outline, // أيقونة الرسائل
//                               color: Colors.teal.shade600,
//                               size: 24,
//                             ),
//                             if (unreadMessageCount > 0) // إظهار الشارة فقط إذا كان هناك رسائل غير مقروءة
//                               Positioned(
//                                 right: 0,
//                                 top: 0,
//                                 child: Container(
//                                   padding: EdgeInsets.all(5),
//                                   decoration: BoxDecoration(
//                                     color: Colors.red,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Text(
//                                     unreadMessageCount.toString(),
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                         SizedBox(width: 10),
//                         Expanded(
//                           child: Text(
//                             chatName,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                               color: Colors.teal.shade900,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
//
