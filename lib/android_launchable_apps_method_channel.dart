import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'android_launchable_apps_platform_interface.dart';

/// An implementation of [AndroidLaunchableAppsPlatform] that uses method channels.
class MethodChannelAndroidLaunchableApps extends AndroidLaunchableAppsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('android_launchable_apps');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
