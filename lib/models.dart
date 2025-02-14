// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

/// Model for app information
@immutable
class AndroidAppInfo {
  /// Model for app information. All fields are required.
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
} // class

/// Model for event usage information for an application
class EventUsageInfo {
  /// Model for event usage information for an application
  EventUsageInfo({
    this.eventType,
    this.timeStamp,
    this.packageName,
    this.className,
    this.shortcutId,
  });

  // Event type
  // https://developer.android.com/reference/android/app/usage/UsageEvents.Event#summary
  final String? eventType;

  /// The time at which this event occurred, measured in milliseconds since the epoch.
  /// https://developer.android.com/reference/android/app/usage/UsageEvents.Event#getTimeStamp()
  final String? timeStamp;

  /// The package name of the source of this event.
  /// https://developer.android.com/reference/android/app/usage/UsageEvents.Event#getPackageName()
  final String? packageName;

  /// The class name of the source of this event.
  /// https://developer.android.com/reference/android/app/usage/UsageEvents.Event#getClassName()
  final String? className;

  /// Returns the ID of a ShortcutInfo for this event if the event is of type SHORTCUT_INVOCATION, otherwise it returns null.
  /// https://developer.android.com/reference/android/app/usage/UsageEvents.Event#getShortcutId()
  final String? shortcutId;

  /// Construct class from the json map
  factory EventUsageInfo.fromMap(Map map) => EventUsageInfo(
        eventType: map['eventType'],
        timeStamp: map['timeStamp'],
        packageName: map['packageName'],
        className: map['className'],
        shortcutId: map['shortcutId'],
      );

  @override
  String toString() {
    return 'EventUsageInfo(eventType: $eventType, timeStamp: $timeStamp, packageName: $packageName, className: $className, shortcutId: $shortcutId)';
  }
} // class
