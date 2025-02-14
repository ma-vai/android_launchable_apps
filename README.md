# android_launchable_apps

Flutter plugin that allows you to gather information for user launchable android apps.
Apps found are ones that declare a MAIN intent and LAUNCHER category.
```xml
    <queries>
        ...
        <intent>
            <action android:name="android.intent.action.MAIN"/>
            <category android:name="android.intent.category.LAUNCHER"/>
        </intent>
    </queries>
```

## Getting Started

### For getting user launchable applications, simply call 
```dart
await AndroidLaunchableApps.getLaunchableApplications();
```

### For getting usage stats for user launchable applications: 

Edit your AndroidManifest.xml to add
```xml
<!-- needed to be able to pull launchable apps -->
<queries>
    <intent>
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
    </intent>
</queries>
```

Then add
```xml
<!-- needed for requesting permissions to query launchable app usage stats  -->
<uses-permission
    android:name="android.permission.PACKAGE_USAGE_STATS"
    tools:ignore="ProtectedPermissions" />
```

Since the above permissions uses "tools" you will need to edit your manifest tag to have that namespace
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android" 
    xmlns:tools="http://schemas.android.com/tools">
```

In your code, you can check and request for the permission to query usage stats with
```dart
bool hasPermission = await AndroidLaunchableApps.isUsagePermissionGranted();
await AndroidLaunchableApps.requestUsagePermission();
```

Requesting this special permission will take the user to a special screen in the OS.
They may be requested by the system to go somewhere else to further allow access to 
even permit the permission request. Therefore, it is highly recommended to develop
your flow with this in mind.

To finally request the stats, simply call
```dart
final usages = await AndroidLaunchableApps.queryEvents(startDate, endDate);
```
