
import 'android_launchable_apps_platform_interface.dart';

class AndroidLaunchableApps {
  Future<String?> getPlatformVersion() {
    return AndroidLaunchableAppsPlatform.instance.getPlatformVersion();
  }
}
