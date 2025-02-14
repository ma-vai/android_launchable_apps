import 'package:android_launchable_apps/android_launchable_apps_platform_interface.dart';
import 'package:android_launchable_apps/models.dart';

/// Provides information about user launchable apps on the device.
class AndroidLaunchableApps {
  /// Retrieve platform version.
  static Future<String?> getPlatformVersion() {
    return AndroidLaunchableAppsPlatform.instance.getPlatformVersion();
  }

  /// Retrieves a list of user launchable apps installed on the device.
  static Future<List<AndroidAppInfo>> getLaunchableApplications() {
    return AndroidLaunchableAppsPlatform.instance.getLaunchableApplications();
  }

  /// Check if have permissions to query launchable apps usage data.
  static Future<bool> isUsagePermissionGranted() async {
    return AndroidLaunchableAppsPlatform.instance.isUsagePermissionGranted();
  }

  /// Request permissions to query launchable apps usage data.
  static Future<void> requestUsagePermission() async {
    await AndroidLaunchableAppsPlatform.instance.requestUsagePermission();
  }

  /// Queries events within a specified date range.
  ///
  /// Takes start and end dates as parameters and returns a Future that resolves
  /// to a list of EventUsageInfo objects.
  static Future<List<EventUsageInfo>> queryEvents(
      DateTime startDate, DateTime endDate) async {
    return AndroidLaunchableAppsPlatform.instance
        .queryEvents(startDate, endDate);
  }
}
