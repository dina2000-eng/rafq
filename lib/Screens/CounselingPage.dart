import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rafq1/Screens/SelectCounselorForBookingScreen.dart';
import 'package:rafq1/Screens/SelectCounselorForChatScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class CounselingSessionsPage extends StatefulWidget {
  const CounselingSessionsPage({Key? key}) : super(key: key);

  @override
  _CounselingSessionsPageState createState() => _CounselingSessionsPageState();
}

class _CounselingSessionsPageState extends State<CounselingSessionsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "جلسات استشارية"
            : "CounselingSessions",
            style: TextStyle(fontSize: width * 0.06,fontFamily: 'Tajawal',)).tr(),
        backgroundColor: Colors.orange.shade100,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeSection(height),
              _divider(height),
              _buildOptionCard(
                icon: Icons.chat,
                title: context.locale.languageCode == 'ar'
                    ? "دردشة الآن"
                    : "Chat now",
                description: context.locale.languageCode == 'ar'
                    ? "تواصل بشكل فوري وسري مع مُستشار نفسي عبر الواتساب (مجاني)"
                    : "communicate instantly and confidentially with a psychological counselor via WhatsApp (free)",
                onTap: () {
                  _openWhatsApp("counselorId");
                },
                iconData: Icons.chat_bubble,
              ),
              _divider(height),
              _buildOptionCard(
                icon: Icons.video_call,
                title: context.locale.languageCode == 'ar'
                    ? "حجز جلسة فيديو"
                    : "book a video session",
                description: context.locale.languageCode == 'ar'
                    ? "حجز جلسة فيديو مع مُعالج نفسي مُتخصص في الوقت الذي يناسبك (مجاني)."
                    : "book a video session with a specialized psychological therapist at a time that suits you (free)",
                onTap: () => _showBookingDialog(),
                iconData: Icons.video_call,
              ),
              _divider(height),
              _buildSectionTitle(context.locale.languageCode == 'ar'
                  ? "نبذة عن المستشارين"
                  : "About the counselors"),
              _divider(height),
              _buildCounselorInfo(),
              _divider(height),
              _buildSectionTitle(context.locale.languageCode == 'ar'
                  ? "الأسئلة الشائعة"
                  : "Frequently Asked Questions"),
                  _divider(height),
              _buildFAQ(),
              _divider(height),
              _buildSectionTitle(context.locale.languageCode == 'ar'
                  ? "شهادات المستخدمين "
                  : "user testimonials."),
              _divider(height),
              _buildTestimonials(),
              SizedBox(height: 20),
              Center(
                child: TextButton.icon(
                  onPressed: () => _showAddTestimonialDialog(context),
                  icon: Icon(Icons.add_comment),
                  label: Text(context.locale.languageCode == 'ar' ? "أضف شهادتك" : "Add your testimonial"),
                ),
              ),
              _divider(height),
             // _buildStepsSection(),
              SizedBox(height: 20),
              SessionRatingSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(double height) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade100,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.locale.languageCode == 'ar'
              ? "مرحبًا بك في خدمة الجلسات الاستشارية"
              : "Welcome to the Counseling Sessions Service",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',)).tr(),
          SizedBox(height: height * 0.01),
          Text(context.locale.languageCode == 'ar'
              ? "تواصل مع مُستشار نفسي مُرخّص الآن. ،إدارة الأسئلة غير المجابة "
              : "Connect with a licensed mental health counselor now.",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic,fontFamily: 'Tajawal',)).tr(),
        ],
      ),
    );
  }

  Widget _divider(double height) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Divider(
        color: Colors.teal.shade100,
        thickness: 1,
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String description,
    required Function() onTap,
    required IconData iconData,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.orange.shade400, Colors.pink.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Row(
            children: [
              Icon(iconData, size: 40, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Tajawal',
                        ),
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: 5),
                    Text(description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontFamily: 'Tajawal',
                        ),
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _openWhatsApp() async {
  //   final Uri url = Uri.parse("https://wa.me/+972592153237");
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url, mode: LaunchMode.externalApplication);
  //   } else {
  //     print(context.locale.languageCode == 'ar'
  //         ? "لا يمكن فتح واتساب"
  //         : "Can't open WhatsApp.");
  //   }
  // }

  void _openWhatsApp(String counselorId) async {
    String? phoneNumber = await _getWhatsAppNumber(counselorId);
    if (phoneNumber != null) {
      final Uri url = Uri.parse("https://wa.me/$phoneNumber");
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        print("لا يمكن فتح واتساب");
      }
    } else {
      print("لم يتم العثور على رقم واتساب للمستشار.");
    }
  }

  Future<String?> _getWhatsAppNumber(String counselorId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("counselors")
        .doc(counselorId)
        .get();
    if (doc.exists && doc.data() != null) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return data['whatsapp']?.toString();
    }
    return null;
  }


  void _showChatDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectCounselorForChatScreen(),
      ),
    );
  }

  void _showBookingDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectCounselorForBookingScreen(),
      ),
    );
  }


  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.teal.shade500,
        fontFamily: 'Tajawal',
      ),
    );
  }

  Widget _buildCounselorInfo() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('counselors').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return _buildCounselorCard(
                data['name'] ??context.locale.languageCode == 'ar'
                    ? "مستشار"
                    : "advisor" ,
                data['specialization'] ?? context.locale.languageCode == 'ar'
                    ? "تخصص غير محدد"
                    : "Unspecified major",
                Icons.person,
              );
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return Text('حدث خطأ');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }


  Widget _buildCounselorCard(String name, String specialization, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.teal.shade500),
        title: Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(specialization, style: TextStyle(fontSize: 14)),
        onTap: () {
        },
      ),
    );
  }

  Widget _buildFAQ() {
    return Column(
      children: [
        _buildFAQItem(context.locale.languageCode == 'ar'
            ? "ما هي تكلفة الجلسة؟"
            : "How much does a session cost?", context.locale.languageCode == 'ar'
            ? "الجلسة مجانية تمامًا."
            : "The session is completely free."),
        SizedBox(height: 10),
        _buildFAQItem(
          context.locale.languageCode == 'ar'
              ? "كم تدوم الجلسة؟"
              : "How long does a session last?",
          context.locale.languageCode == 'ar'
              ? "مدة الجلسة عادة ما تكون بين 30 إلى 45 دقيقة."
              : "The session usually lasts between 30 to 45 minutes.",
        ),
        SizedBox(height: 10),
        _buildFAQItem(
          context.locale.languageCode == 'ar'
              ? "هل المعلومات التي أشاركها سرية؟"
              : "Is the information I share confidential?",
          context.locale.languageCode == 'ar'
              ? "نعم، جميع المعلومات تُحفظ بسرية تامة."
              : "Yes, all information is kept strictly confidential.",
        ),
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              answer,
              style: TextStyle(fontFamily: 'Tajawal'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTestimonials() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('testimonials')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text(context.locale.languageCode == 'ar'
              ? "لا توجد شهادات حاليا"
              : "There are no testimonials currently.");
        }

        return Column(
          children: snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final isArabic = context.locale.languageCode == 'ar';

            return _buildTestimonialCard(
              name: isArabic
                  ? data['name_ar'] ?? "مستخدم"
                  : data['name_en'] ?? "User",
              feedback: isArabic
                  ? data['feedback_ar'] ?? ""
                  : data['feedback_en'] ?? "",
            );
          }).toList(),
        );
      },
    );
  }


  void _showAddTestimonialDialog(BuildContext context) {
    final nameController = TextEditingController();
    final feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(context.locale.languageCode == 'ar'
            ? "أضف شهادتك"
            : "Add your certificate"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText:context.locale.languageCode == 'ar'
                ? "اسمك"
                : "your name" )),
            TextField(controller: feedbackController, decoration: InputDecoration(labelText:context.locale.languageCode == 'ar'
                ? "رأيك"
                : "Your opinion" )),
          ],
        ),
        actions: [
          TextButton(
            child: Text(context.locale.languageCode == 'ar'
                ? "إلغاء"
                : "cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text(context.locale.languageCode == 'ar'
                ? "إرسال"
                : "send"),
            onPressed: () {
              FirebaseFirestore.instance.collection('testimonials').add({
                'name': nameController.text,
                'feedback': feedbackController.text,
                'timestamp': Timestamp.now(),
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }


  Widget _buildTestimonialCard({required String name, required String feedback}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.format_quote, size: 30, color: Colors.teal.shade300),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Tajawal')),
                  SizedBox(height: 6),
                  Text(
                    feedback,
                    style: TextStyle(fontSize: 14, fontFamily: 'Tajawal'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class ChatScreen extends StatefulWidget {
  final String counselorId;
  ChatScreen({required this.counselorId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final String chatRoomId = "chat_${widget.counselorId}_user";

  Future<void> _sendMessage() async {
    String message = _controller.text.trim();
    if (message.isEmpty) return;

    await _firestore
        .collection("chats")
        .doc(chatRoomId)
        .collection("messages")
        .add({
      "sender": "user",
      "text": message,
      "isRead": false,
      "timestamp": FieldValue.serverTimestamp(),
    });

    _controller.clear();

    await Future.delayed(Duration(seconds: 1));

    await _firestore
        .collection("chats")
        .doc(chatRoomId)
        .collection("messages")
        .add({
      "sender": "system",
      "text": context.locale.languageCode == 'ar'
          ? "شكرًا لرسالتك! سيتم الرد عليك من قبل المستشار في أقرب وقت."
          : "Thank you for your message! The counselor will reply to you as soon as possible.",
      "isRead": false,
      "timestamp": FieldValue.serverTimestamp(),
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "الدردشة مع المستشار"
            : "Chat with the counselor",style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection("chats")
                  .doc(chatRoomId)
                  .collection("messages")
                  .orderBy("timestamp", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                List<DocumentSnapshot> docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                    docs[index].data() as Map<String, dynamic>;
                    bool isUser = data["sender"] == "user";
                    bool isSystem = data["sender"] == "system";

                    return Align(
                      alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isUser
                              ? Colors.blue[200]
                              : isSystem
                              ? Colors.grey[300]
                              : Colors.green[200],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft:
                            isUser ? Radius.circular(12) : Radius.zero,
                            bottomRight:
                            isUser ? Radius.zero : Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          data["text"] ?? "",
                          style: TextStyle(fontSize: 16,fontFamily: 'Tajawal',),
                        ),
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
                    controller: _controller,
                    decoration:
                    InputDecoration(hintText: context.locale.languageCode == 'ar'
                        ? "اكتب رسالتك..."
                        : "Write your message...",),
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.orange),
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


class BookingScreen extends StatefulWidget {
  final String counselorId;
  BookingScreen({required this.counselorId});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String _selectedDateTime = '';

  Future<void> _selectDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateFormat('yyyy-MM-dd').format(pickedDate) + " " + pickedTime.format(context);
        });
      }
    }
   }


  void _showBookingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.locale.languageCode == 'ar'
              ? "حجز جلسة فيديو"
              : "Book a video session",style: TextStyle(fontFamily: 'Tajawal',),),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.locale.languageCode == 'ar'
              ? "يمكنك تحديد اليوم والوقت المناسب لحجز جلسة الفيديو مع المُستشار النفسي"
              : "You can select the day and time that suits you to book a video session with a psychologist.",
                style: TextStyle(fontFamily: 'Tajawal',),),
              SizedBox(height: 16),
              Text(
                _selectedDateTime.isEmpty ? context.locale.languageCode == 'ar'
                    ? "لم يتم تحديد الوقت بعد"
                    : "The time has not been selected yet" : context.locale.languageCode == 'ar'
                    ? "الوقت المحدد: $_selectedDateTime"
                    : "Selected time: $_selectedDateTime" ,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(context.locale.languageCode == 'ar'
            ? "إغلاق"
            : "Close",style: TextStyle(fontFamily: 'Tajawal',),),
            ),
            TextButton(
              onPressed: () {
                _selectDateTime();
              },
              child: Text(context.locale.languageCode == 'ar'
             ? "حدد وقت"
            : "Select a time",style: TextStyle(fontFamily: 'Tajawal',),),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveBooking() async {
    if (_selectedDateTime.isEmpty) return;
    FirebaseFirestore.instance.collection("bookings").add({
      "counselorId": widget.counselorId,
      "bookingTime": _selectedDateTime,
      "timestamp": FieldValue.serverTimestamp(),
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.locale.languageCode == 'ar'
        ? "تم حفظ الحجز"
        : "The reservation has been saved",style: TextStyle(fontFamily: 'Tajawal',),)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "حجز جلسة فيديو"
            : "Book a video session",style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.orange.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
        context.locale.languageCode == 'ar'
            ? "الوقت المحفوظ للجلسة: $_selectedDateTime"
            : "Saved session time: $_selectedDateTime",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showBookingDialog,
              child: Text(context.locale.languageCode == 'ar'
                  ? "حدد يوم ووقت الجلسة"
                  : "Select the day and time of the session.",style: TextStyle(fontFamily: 'Tajawal',),),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveBooking,
              child: Text(context.locale.languageCode == 'ar'
                  ? " حفظ الحجز"
                  : "save the reservation",style: TextStyle(fontFamily: 'Tajawal',),),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionRatingSection extends StatefulWidget {
  @override
  _SessionRatingSectionState createState() => _SessionRatingSectionState();
}

class _SessionRatingSectionState extends State<SessionRatingSection> {
  int _rating = 0;
  TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.locale.languageCode == 'ar' ? "قيّم تجربتك" : "Rate your experience",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
        ),
        SizedBox(height: 10),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              onPressed: () {
                setState(() {
                  _rating = index + 1;
                });
              },
              icon: Icon(
                Icons.star,
                color: _rating > index ? Colors.amber : Colors.grey.shade400,
              ),
            );
          }),
        ),
        TextField(
          controller: _feedbackController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: context.locale.languageCode == 'ar'
                ? "اكتب ملاحظاتك هنا (اختياري)"
                : "Write your feedback here (optional)",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(context.locale.languageCode == 'ar'
                  ? "شكراً لتقييمك!"
                  : "Thank you for your feedback!"),
            ));

            setState(() {
              _rating = 0;
              _feedbackController.clear();
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(
            context.locale.languageCode == 'ar' ? "إرسال" : "Submit",
            style: TextStyle(fontFamily: 'Tajawal'),
          ),
        )
      ],
    );
  }
}
