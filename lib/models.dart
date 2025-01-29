import 'package:flutter/foundation.dart';

/// Model holding app information
@immutable
class AndroidAppInfo {
  /// Model holding app information. All fields are required.
  /// Matches fields found at https://developer.android.com/reference/android/content/pm/ApplicationInfo#fields
  const AndroidAppInfo({
    required this.packageName,
    required this.displayName,
    required this.categoryName,
    required this.category,
    required this.iconBytes,
  });

  /// Name of the package that this item is in.
  /// https://developer.android.com/reference/android/content/pm/PackageItemInfo#packageName
  final String packageName;

  /// Label for the application
  /// https://developer.android.com/reference/android/content/pm/PackageManager#getApplicationLabel(android.content.pm.ApplicationInfo)
  final String displayName;

  /// Return a concise, localized title for the given
  /// https://developer.android.com/reference/android/content/pm/ApplicationInfo#getCategoryTitle(android.content.Context,%20int)
  final String categoryName;

  /// Category of the app
  /// https://developer.android.com/reference/android/content/pm/ApplicationInfo#category
  final int category;

  /// Retrieve the current graphical icon associated with this item without the addition of a work badge if applicable.
  /// https://developer.android.com/reference/android/content/pm/PackageItemInfo#loadUnbadgedIcon(android.content.pm.PackageManager)
  final Uint8List iconBytes;

  /// Converts native platform data to a Flutter-friendly data model.
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
