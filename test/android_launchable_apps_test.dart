import 'package:flutter_test/flutter_test.dart';
import 'package:android_launchable_apps/android_launchable_apps.dart';
import 'package:android_launchable_apps/android_launchable_apps_platform_interface.dart';
import 'package:android_launchable_apps/android_launchable_apps_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAndroidLaunchableAppsPlatform
    with MockPlatformInterfaceMixin
    implements AndroidLaunchableAppsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AndroidLaunchableAppsPlatform initialPlatform = AndroidLaunchableAppsPlatform.instance;

  test('$MethodChannelAndroidLaunchableApps is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAndroidLaunchableApps>());
  });

  test('getPlatformVersion', () async {
    AndroidLaunchableApps androidLaunchableAppsPlugin = AndroidLaunchableApps();
    MockAndroidLaunchableAppsPlatform fakePlatform = MockAndroidLaunchableAppsPlatform();
    AndroidLaunchableAppsPlatform.instance = fakePlatform;

    expect(await androidLaunchableAppsPlugin.getPlatformVersion(), '42');
  });
}
