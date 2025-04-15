// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class MessageDetailPage extends StatefulWidget {
//   final String chatId;
//   final bool scrollToUnread;
//   final int unreadIndex;
//
//   const MessageDetailPage({
//     Key? key,
//     required this.chatId,
//     this.scrollToUnread = false,
//     this.unreadIndex = 0,
//   }) : super(key: key);
//
//   @override
//   _MessageDetailPageState createState() => _MessageDetailPageState();
// }
//
// class _MessageDetailPageState extends State<MessageDetailPage> {
//   final TextEditingController _replyController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   bool _hasScrolled = false; // لتفادي التمرير المتكرر
//
//   Future<void> _sendReply(String replyText) async {
//     if (replyText.isEmpty) return;
//
//     try {
//       DocumentReference messageRef = FirebaseFirestore.instance
//           .collection('chats')
//           .doc(widget.chatId)
//           .collection('messages')
//           .doc(); // إنشاء مستند جديد لكل رسالة
//
//       await messageRef.set({
//         'sender': 'أنت', // المرسل
//         'text': replyText,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//
//       _replyController.clear();
//       print('✅ تم إرسال الرسالة بنجاح');
//     } catch (e) {
//       print('❌ خطأ في إرسال الرسالة: $e');
//     }
//   }
//
//   Future<void> _markMessagesAsRead() async {
//     QuerySnapshot messagesSnapshot = await FirebaseFirestore.instance
//         .collection('chats')
//         .doc(widget.chatId)
//         .collection('messages')
//         .where('isRead', isEqualTo: false) // نحصل فقط على الرسائل غير المقروءة
//         .get();
//
//     for (var doc in messagesSnapshot.docs) {
//       await doc.reference.update({'isRead': true});
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.scrollToUnread && _scrollController.hasClients) {
//         double offset = widget.unreadIndex * 70.0;
//         _scrollController.animateTo(
//           offset,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         );
//       }
//
//       // تحديد الرسائل كمقروءة بعد فتح الصفحة
//       _markMessagesAsRead();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('تفاصيل المحادثة').tr(),
//         backgroundColor: Colors.teal.shade300,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('chats')
//                   .doc(widget.chatId)
//                   .collection('messages')
//                   .orderBy('timestamp')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Center(child: Text('لا توجد رسائل بعد'.tr()));
//                 }
//
//                 var messages = snapshot.data!.docs;
//
//                 // بعد تحميل الرسائل، إذا كانت خاصية التمرير للرسالة غير المقروءة مفعلة ولم يتم التمرير بعد،
//                 // نقوم بإضافة callback للتمرير إلى الموقع المحدد
//                 if (widget.scrollToUnread && !_hasScrolled) {
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     if (_scrollController.hasClients) {
//                       double offset = widget.unreadIndex * 70.0;
//                       _scrollController.animateTo(
//                         offset,
//                         duration: Duration(milliseconds: 300),
//                         curve: Curves.easeInOut,
//                       );
//                       _hasScrolled = true;
//                     }
//                   });
//                 }
//
//                 return ListView.builder(
//                   controller: _scrollController,
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     var message = messages[index];
//                     var data = message.data() as Map<String, dynamic>;
//
//                     String text = data['text'] ?? '';
//                     bool isUserMessage = data['sender'] == 'أنت';
//
//                     return Padding(
//                       padding:
//                       const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                       child: Align(
//                         alignment: isUserMessage
//                             ? Alignment.centerRight
//                             : Alignment.centerLeft,
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: isUserMessage
//                                 ? Colors.teal.shade200
//                                 : Colors.grey.shade300,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(
//                             text,
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _replyController,
//                     decoration: InputDecoration(
//                       labelText: 'اكتب ردًا...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send, color: Colors.teal),
//                   onPressed: () => _sendReply(_replyController.text),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
