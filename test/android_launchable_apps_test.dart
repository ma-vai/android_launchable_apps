import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:android_launchable_apps/android_launchable_apps.dart';
import 'package:android_launchable_apps/android_launchable_apps_method_channel.dart';
import 'package:android_launchable_apps/android_launchable_apps_platform_interface.dart';
import 'package:android_launchable_apps/models.dart';

class MockAndroidLaunchableAppsPlatform
    with MockPlatformInterfaceMixin
    implements AndroidLaunchableAppsPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<List<AndroidAppInfo>> getLaunchableApplications() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return <AndroidAppInfo>[
      AndroidAppInfo(
        packageName: 'example.app',
        displayName: 'Example App',
        categoryName: 'Other',
        category: -1,
        iconBytes: Uint8List(0),
      ),
    ];
  }

  @override
  Future<bool> isUsagePermissionGranted() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }

  @override
  Future<void> requestUsagePermission() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<List<EventUsageInfo>> queryEvents(
      DateTime startDate, DateTime endDate) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return <EventUsageInfo>[
      EventUsageInfo(
        eventType: '1',
        timeStamp: '1739575230000',
        packageName: 'app.package',
        className: 'app.classname',
        shortcutId: 'app.shortcutId',
      ),
    ];
  }
}

void main() {
  final AndroidLaunchableAppsPlatform initialPlatform =
      AndroidLaunchableAppsPlatform.instance;

  test('$MethodChannelAndroidLaunchableApps is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAndroidLaunchableApps>());
  });

  test('getPlatformVersion', () async {
    //AndroidLaunchableApps androidLaunchableAppsPlugin = AndroidLaunchableApps();
    MockAndroidLaunchableAppsPlatform fakePlatform =
        MockAndroidLaunchableAppsPlatform();
    AndroidLaunchableAppsPlatform.instance = fakePlatform;

    expect(await AndroidLaunchableApps.getPlatformVersion(), '42');
  });

  test('getLaunchableApplications', () async {
    MockAndroidLaunchableAppsPlatform fakePlatform =
        MockAndroidLaunchableAppsPlatform();

    final apps = await fakePlatform.getLaunchableApplications();
    final hasApps = apps.isNotEmpty;
    expect(hasApps, true);
  });

  test('isUsagePermissionGranted', () async {
    MockAndroidLaunchableAppsPlatform fakePlatform =
        MockAndroidLaunchableAppsPlatform();

    final hasPermission = await fakePlatform.isUsagePermissionGranted();
    expect(hasPermission, true);
  });

  test('requestUsagePermission', () async {
    MockAndroidLaunchableAppsPlatform fakePlatform =
        MockAndroidLaunchableAppsPlatform();

    await fakePlatform.requestUsagePermission();
    expect(true, true);
  });

  test('requestUsagePermission', () async {
    MockAndroidLaunchableAppsPlatform fakePlatform =
        MockAndroidLaunchableAppsPlatform();

    final stats =
        await fakePlatform.queryEvents(DateTime.now(), DateTime.now());
    final hasStats = stats.isNotEmpty;
    expect(hasStats, true);
  });
}
