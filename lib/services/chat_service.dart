import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  static const String apiKey = 'YOUR_OPENAI_API_KEY'; // ضع مفتاح API هنا
  static const String apiUrl = 'https://api.openai.com/v1/chat/completions';

  static Future<String> getChatResponse(String userMessage) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "system", "content": "أنت مستشار نفسي مساعد."},
            {"role": "user", "content": userMessage}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["choices"][0]["message"]["content"];
      } else {
        return "حدث خطأ، يرجى المحاولة لاحقًا.";
      }
    } catch (e) {
      return "حدث خطأ أثناء الاتصال بالخادم.";
    }
  }
}
