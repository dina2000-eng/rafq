import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // إضافة تصنيفات المقالات
  Future<void> addCategories(List<String> categories) async {
    for (String category in categories) {
      await _firestore.collection('categories').doc(category).set({
        'name': category,
      });
    }
  }

  // إضافة المقالات إلى Firestore
  Future<void> addArticles(List<Map<String, String>> articles) async {
    for (var article in articles) {
      await _firestore.collection('articles').add({
        'title': article['title'],
        'description': article['description'],
        'category': article['category'],
        'image': article['image'],
        'content': article['content'],
      });
    }
  }

  // جلب التصنيفات من Firestore
  Stream<List<String>> getCategories() {
    return _firestore.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  // جلب المقالات من Firestore حسب الفئة
  Stream<List<Map<String, dynamic>>> getArticlesByCategory(String category) {
    return _firestore
        .collection('articles')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }
}
