class Translations {
  final Map<String, dynamic> _data;

  Translations(this._data);

  String? translate(String key) {
    return _data[key];
  }

// يمكنك إضافة المزيد من الوظائف حسب الحاجة
}
