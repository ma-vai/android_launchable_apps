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
Simply call 
```dart
await AndroidLaunchableApps().getLaunchableApplications();
```
