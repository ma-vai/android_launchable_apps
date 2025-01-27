import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:android_launchable_apps/models.dart';

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

  @override
  Future<List<AndroidAppInfo>> getLaunchableApplications() async {
    List<Map<Object?, Object?>>? data;
    try {
      data = await methodChannel.invokeListMethod<Map<Object?, Object?>>('getLaunchableApplications');
    } on Exception catch (e) {
      if (kDebugMode) debugPrint('Platform - Failed to getLaunchableApplications: ${e.toString()}');
      data = [];
    }
    data ??= [];

    List<AndroidAppInfo> apps = [];
    for (var map in data) {
      Map<String, dynamic> m = {};
      for (var element in map.entries) {
        m[element.key?.toString() ?? ''] = element.value;
      }
      final app = AndroidAppInfo.fromMap(m);
      apps.add(app);
    }
    return apps;
  }
}
