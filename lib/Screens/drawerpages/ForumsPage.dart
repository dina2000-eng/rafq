import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ForumsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.locale.languageCode == 'ar'
              ? "المنتديات والمجتمعات"
              : "Forums and Communities",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('forums').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
            return Center(
              child: Text(
                context.locale.languageCode == 'ar'
                    ? "لا توجد منتديات متاحة حاليًا."
                    : "There are no forums",
                style: TextStyle(fontSize: 18, color: Colors.grey,fontFamily: 'Tajawal',),
              ),
            );
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var forum = snapshot.data!.docs[index];
              Map<String, dynamic> data =
              forum.data() as Map<String, dynamic>;
              int likes = data.containsKey('likes') && data['likes'] is int ? data['likes'] : 0;
              return ForumCard(
                title: data.containsKey('title') ? data['title'] :
                (context.locale.languageCode == 'ar'
                    ? data['title_ar'] ?? "العنوان غير متوفر"
                    : data['title_en'] ?? "Title not available"),

                description: data['description']
                    ?? (context.locale.languageCode == 'ar'
                        ? data['description_ar'] ?? "الوصف غير متوفر"
                        : data['description_en'] ?? "Description not available"
                    ),
                forumId: forum.id,
                likes: likes,
              );
            },
          );
        },
      ),
    );
  }
}

class ForumCard extends StatelessWidget {
  final String title;
  final String description;
  final String forumId;
  final int likes;

  ForumCard({
    required this.title,
    required this.description,
    required this.forumId,
    required this.likes,
  });

  void _incrementLike(BuildContext context) {
    FirebaseFirestore.instance.collection('forums').doc(forumId).update({
      'likes': FieldValue.increment(1),
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.locale.languageCode == 'ar'
            ? "حدث خطأ أثناء تحديث الإعجابات"
            : "make wrong when update the likes",style: TextStyle(fontFamily: 'Tajawal',),)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.teal[50],
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,fontFamily: 'Tajawal',),
        ),
        subtitle: Text(
          description,
          style: TextStyle(fontSize: 16,fontFamily: 'Tajawal',),
        ),
        leading: IconButton(
          icon: Icon(Icons.thumb_up, color: Colors.teal),
          onPressed: () => _incrementLike(context),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, size: 24, color: Colors.teal),
            SizedBox(height: 4),
            Text(likes.toString(), style: TextStyle(fontSize: 14,fontFamily: 'Tajawal',)),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForumDetailPage(forumId: forumId),
            ),
          );
        },
      ),
    );
  }
}

class ForumDetailPage extends StatelessWidget {
  final String forumId;

  ForumDetailPage({required this.forumId});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _submitPost() {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) return;

    FirebaseFirestore.instance
        .collection('forums')
        .doc(forumId)
        .collection('posts')
        .add({
      'title': _titleController.text,
      'content': _contentController.text,
      'timestamp': FieldValue.serverTimestamp(),
      'likes': 0,
    }).catchError((error) {
      print("خطأ في إرسال المشاركة: $error");
    });

    _titleController.clear();
    _contentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.locale.languageCode == 'ar'
              ? "تفاصيل المنتدى"
              : "Description of the topic",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('forums').doc(forumId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || !snapshot.data!.exists)
            return Center(
              child: Text(
                context.locale.languageCode == 'ar'
                    ? "لم يتم العثور على المنتدى"
                    : "Forum not found",
                style: TextStyle(fontSize: 18, color: Colors.grey,fontFamily: 'Tajawal',),
              ),
            );
          var forumData = snapshot.data!;
          Map<String, dynamic> data =
          forumData.data() as Map<String, dynamic>;
          String title = context.locale.languageCode == 'ar'
              ? data['title_ar'] ?? "العنوان غير متوفر"
              : data['title_en'] ?? "Title not available";

          String content = data['content'] ?? (
              context.locale.languageCode == 'ar'
                  ? data['content_ar'] ?? "لا يوجد محتوى لهذا المنتدى"
                  : data['content_en'] ?? "here is no content for this forum."
          );
          int likes = data.containsKey('likes') ? data['likes'] : 0;
          int postsCount = data.containsKey('postsCount') ? data['postsCount'] : 0;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            fontFamily: 'Tajawal',),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.thumb_up, color: Colors.teal, size: 20),
                              SizedBox(width: 4),
                              Text(likes.toString(),style: TextStyle(fontFamily: 'Tajawal',),),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.comment, color: Colors.teal, size: 20),
                              SizedBox(width: 4),
                              Text(postsCount.toString(),style: TextStyle(fontFamily: 'Tajawal',),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    content,
                    style: TextStyle(fontSize: 18, color: Colors.black87,fontFamily: 'Tajawal',),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(context.locale.languageCode == 'ar'
                          ? "الدردشة مع الأعضاء"
                          : "chat with members",
                          style: TextStyle(fontSize: 18, color: Colors.white,fontFamily: 'Tajawal',)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatPage(forumId: forumId)),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(context.locale.languageCode == 'ar'
                          ? "إضافة مشاركة"
                          : "add sharing",
                          style: TextStyle(fontSize: 18, color: Colors.white,fontFamily: 'Tajawal',)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddPostPage(forumId: forumId)),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('forums')
                        .doc(forumId)
                        .collection('posts')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(child: CircularProgressIndicator());
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
                        return Center(
                          child: Text(
                            context.locale.languageCode == 'ar'
                                ? "لا توجد مشاركات حالياً."
                                : "There is no any share",
                            style: TextStyle(fontSize: 18, color: Colors.grey,fontFamily: 'Tajawal',),
                          ),
                        );
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var post = snapshot.data!.docs[index];
                          Map<String, dynamic> postData =
                          post.data() as Map<String, dynamic>;
                          int postLikes = postData.containsKey('likes') ? postData['likes'] : 0;
                          final isArabic = context.locale.languageCode == 'ar';
                          String title = isArabic
                              ? postData['title_ar'] ?? ''
                              : postData['title_en'] ?? '';
                          String content = isArabic
                              ? postData['content_ar'] ?? ''
                              : postData['content_en'] ?? '';

                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            elevation: 2,
                            child: ListTile(
                              title: Text(
                                title,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
                              ),
                              subtitle: Text(
                                content,
                                style: TextStyle(fontSize: 16,fontFamily: 'Tajawal',),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.thumb_up, size: 20, color: Colors.teal),
                                  SizedBox(width: 4),
                                  Text(postLikes.toString(),style: TextStyle(fontFamily: 'Tajawal',),),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddPostPage extends StatefulWidget {
  final String forumId;

  AddPostPage({required this.forumId});

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _submitPost(BuildContext context, String forumId) async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) return;

    final isArabic = context.locale.languageCode == 'ar';

    try {
      await FirebaseFirestore.instance
          .collection('forums')
          .doc(forumId)
          .collection('posts')
          .add({
        'title_ar': isArabic ? _titleController.text : '',
        'title_en': isArabic ? '' : _titleController.text,
        'content_ar': isArabic ? _contentController.text : '',
        'content_en': isArabic ? '' : _contentController.text,
        'timestamp': FieldValue.serverTimestamp(),
        'likes': 0,
      });

      _titleController.clear();
      _contentController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isArabic
              ? "تم نشر المشاركة بنجاح!"
              : "Post successfully posted",style: TextStyle(fontFamily: 'Tajawal',),),
        ),
      );
    } catch (e) {
      print("خطأ أثناء الإضافة: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "إضافة مشاركة"
            : "add sharing",style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: context.locale.languageCode == 'ar'
                    ? "العنوان"
                    : "The adress",
                labelStyle: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: context.locale.languageCode == 'ar'
                    ? "المحتوى"
                    : "The content",
                labelStyle: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () =>
                  _submitPost(context, widget.forumId),
              child: Text(
                context.locale.languageCode == 'ar'
                    ? "إضافة المشاركة"
                    : "add the sharing",
                style: TextStyle(fontSize: 18, color: Colors.white,fontFamily: 'Tajawal',),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String forumId;
  ChatPage({required this.forumId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    FirebaseFirestore.instance
        .collection('forums')
        .doc(widget.forumId)
        .collection('chat')
        .add({
      'message': _messageController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    });
    _messageController.clear();
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return '';
    DateTime date = timestamp.toDate();
    return DateFormat('HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.locale.languageCode == 'ar'
              ? "الدردشة"
              : "The chat",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('forums')
                  .doc(widget.forumId)
                  .collection('chat')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
                  return Center(child: Text( context.locale.languageCode == 'ar'
                      ? "لا توجد رسائل بعد."
                      : "There is no message yet",style: TextStyle(fontFamily: 'Tajawal',),));
                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var message = snapshot.data!.docs[index];
                    Map<String, dynamic> messageData =
                    message.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(messageData['message'] ?? ''),
                      trailing: Text(
                        _formatTimestamp(messageData['timestamp']),
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                     decoration: InputDecoration(
                      hintText:  context.locale.languageCode == 'ar'
                          ? "أرسل رسالة..."
                          : "send a message",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.teal),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
