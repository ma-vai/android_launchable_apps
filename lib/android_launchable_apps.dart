import 'package:android_launchable_apps/models.dart';

import 'package:android_launchable_apps/android_launchable_apps_platform_interface.dart';

/// Provides information about user launchable apps on the device.
class AndroidLaunchableApps {
  /// Retrieve platform version.
  Future<String?> getPlatformVersion() {
    return AndroidLaunchableAppsPlatform.instance.getPlatformVersion();
  }

  /// Retrieves a list of user launchable apps installed on the device.
  Future<List<AndroidAppInfo>> getLaunchableApplications() {
    return AndroidLaunchableAppsPlatform.instance.getLaunchableApplications();
  }
}
