package com.verseai.android_launchable_apps

import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.os.Build
import androidx.core.graphics.drawable.toBitmap
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.ByteArrayOutputStream

/** AndroidLaunchableAppsPlugin */
class AndroidLaunchableAppsPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private lateinit var context: Context
  private lateinit var packageManager: PackageManager

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "android_launchable_apps")
    channel.setMethodCallHandler(this)

    context = flutterPluginBinding.applicationContext
    packageManager = flutterPluginBinding.applicationContext.packageManager
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
        "getPlatformVersion" -> {
          result.success("Android ${Build.VERSION.RELEASE}")
        }
        "getLaunchableApplications" -> {
          val data = getLaunchableApps()
          result.success(data)
        }
        "isUsagePermissionGranted" -> {
          result.success(Utils.isUsagePermissionGranted(context))
        }
        "requestUsagePermission" -> {
          Utils.requestUsagePermission(context)
        }
        "queryEvents" -> {
          val start: Long = call.argument<Long>("start") as Long
          val end: Long = call.argument<Long>("end") as Long
          result.success(UsageStats.queryEvents(context, start, end))
        }
        else -> {
          result.notImplemented()
        }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun getLaunchableApps(): ArrayList<Map<String, Any>> {
    val mainIntent = Intent(Intent.ACTION_MAIN, null)
    mainIntent.addCategory(Intent.CATEGORY_LAUNCHER)
    val apps = packageManager.queryIntentActivities(mainIntent, 0)
    apps.sortBy { app -> packageManager.getApplicationLabel(app.activityInfo.applicationInfo).toString() }
    val returnList: ArrayList<Map<String, Any>> = arrayListOf()
    for(pkg in apps) {
      val app = pkg.activityInfo.applicationInfo
      val catName: String? = ApplicationInfo.getCategoryTitle(context, app.category)?.toString()
      val displayName: String = packageManager.getApplicationLabel(app).toString()
      var iconFormat = Bitmap.CompressFormat.PNG
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
        iconFormat = Bitmap.CompressFormat.WEBP_LOSSY
      }
      val iconBytes = ByteArrayOutputStream().use { o ->
        val icon = app.loadUnbadgedIcon(packageManager)
        icon.toBitmap().compress(iconFormat, 90, o)
        o.toByteArray()
      }
      returnList.add(
        mapOf(
          "packageName" to app.packageName,
          "displayName" to displayName,
          "categoryName" to (catName ?: "Other"),
          "category" to app.category,
          "iconBytes" to iconBytes,
        )
      )
    }
    return returnList
  }

}
