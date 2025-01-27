import 'package:android_launchable_apps/models.dart';

import 'android_launchable_apps_platform_interface.dart';

class AndroidLaunchableApps {
  Future<String?> getPlatformVersion() {
    return AndroidLaunchableAppsPlatform.instance.getPlatformVersion();
  }

  Future<List<AndroidAppInfo>> getLaunchableApplications() {
    return AndroidLaunchableAppsPlatform.instance.getLaunchableApplications();
  }
}
