import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:android_launchable_apps/android_launchable_apps_method_channel.dart';
import 'package:android_launchable_apps/models.dart';

/// Interface definition for AndroidLaunchableAppsPlatform
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

  /// Retrieve platform version.
  /// Must be overridden by platorm implementations.
  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// Retrieves a list of user launchable apps installed on the device.
  /// Must be overridden by platorm implementations.
  Future<List<AndroidAppInfo>> getLaunchableApplications() {
    throw UnimplementedError(
        'getLaunchableApplications() has not been implemented.');
  }

  /// Check if have permissions to query launchable apps usage data.
  /// Must be overridden by platorm implementations.
  Future<bool> isUsagePermissionGranted() {
    throw UnimplementedError(
        'isUsagePermissionGranted() has not been implemented.');
  }

  /// Request permissions to query launchable apps usage data.
  /// Must be overridden by platorm implementations.
  Future<void> requestUsagePermission() {
    throw UnimplementedError(
        'requestUsagePermission() has not been implemented.');
  }

  /// Queries events within a specified date range.
  ///
  /// Takes start and end dates as parameters and returns a Future that resolves
  /// to a list of EventUsageInfo objects.
  Future<List<EventUsageInfo>> queryEvents(
      DateTime startDate, DateTime endDate) {
    throw UnimplementedError('queryEvents() has not been implemented.');
  }
}
