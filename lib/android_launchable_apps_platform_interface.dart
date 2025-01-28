import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:android_launchable_apps/models.dart';

import 'android_launchable_apps_method_channel.dart';

abstract class AndroidLaunchableAppsPlatform extends PlatformInterface {
  /// Constructs a AndroidLaunchableAppsPlatform.
  AndroidLaunchableAppsPlatform() : super(token: _token);

  static final Object _token = Object();

  static AndroidLaunchableAppsPlatform _instance =
      MethodChannelAndroidLaunchableApps();

  /// The default instance of [AndroidLaunchableAppsPlatform] to use.
  ///
  /// Defaults to [MethodChannelAndroidLaunchableApps].
  static AndroidLaunchableAppsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AndroidLaunchableAppsPlatform] when
  /// they register themselves.
  static set instance(AndroidLaunchableAppsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<AndroidAppInfo>> getLaunchableApplications() {
    throw UnimplementedError(
        'getLaunchableApplications() has not been implemented.');
  }
}
