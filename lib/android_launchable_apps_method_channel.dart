import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:android_launchable_apps/models.dart';

import 'package:android_launchable_apps/android_launchable_apps_platform_interface.dart';

/// An implementation of [AndroidLaunchableAppsPlatform] that uses method channels.
class MethodChannelAndroidLaunchableApps extends AndroidLaunchableAppsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('android_launchable_apps');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<List<AndroidAppInfo>> getLaunchableApplications() async {
    List<Map<Object?, Object?>>? data;
    try {
      data = await methodChannel
          .invokeListMethod<Map<Object?, Object?>>('getLaunchableApplications');
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint(
            'Platform - Failed to getLaunchableApplications: ${e.toString()}');
      }
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

  /// Check if have permissions to query launchable apps usage data.
  @override
  Future<bool> isUsagePermissionGranted() async {
    final hasPermissions =
        await methodChannel.invokeMethod<bool>('isUsagePermissionGranted');
    return hasPermissions ?? false;
  }

  /// Request permissions to query launchable apps usage data.
  @override
  Future<void> requestUsagePermission() async {
    await methodChannel.invokeMethod('requestUsagePermission');
  }

  /// Queries events within a specified date range.
  ///
  /// Takes start and end dates as parameters and returns a Future that resolves
  /// to a list of EventUsageInfo objects.
  @override
  Future<List<EventUsageInfo>> queryEvents(
      DateTime startDate, DateTime endDate) async {
    // Convert start and end dates to milliseconds since epoch.
    int end = endDate.millisecondsSinceEpoch;
    int start = startDate.millisecondsSinceEpoch;

    // Prepare a map of the start and end times to send to the native method.
    Map<String, int> interval = {'start': start, 'end': end};

    // Call the native method and await the result.
    List events = await methodChannel.invokeMethod('queryEvents', interval);

    // Map the result to a list of EventUsageInfo objects.
    List<EventUsageInfo> result =
        events.map((item) => EventUsageInfo.fromMap(item)).toList();
    return result;
  }
} // class
