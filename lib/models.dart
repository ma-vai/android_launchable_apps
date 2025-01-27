import 'package:flutter/foundation.dart';

@immutable
class AndroidAppInfo {
  const AndroidAppInfo({
    required this.packageName,
    required this.displayName,
    required this.categoryName,
    required this.category,
    required this.iconBytes,
  });

  final String packageName;
  final String displayName;
  final String categoryName;
  final int category;
  final Uint8List iconBytes;

  factory AndroidAppInfo.fromMap(Map<String, dynamic> map) {
    return AndroidAppInfo(
      packageName: map['packageName'] as String,
      displayName: map['displayName'] as String,
      categoryName: map['categoryName'] as String,
      category: map['category'] as int,
      iconBytes: map['iconBytes'] as Uint8List,
    );
  }
}
