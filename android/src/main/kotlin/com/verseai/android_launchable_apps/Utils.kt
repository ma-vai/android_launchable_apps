package com.verseai.android_launchable_apps

import android.app.AppOpsManager
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Process
import android.provider.Settings

object Utils {
    fun isUsagePermissionGranted(context: Context): Boolean {
        // This method checks if the app has permission to access usage statistics.
        val appOps = context.getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager?
        // Retrieves the AppOpsManager system service to check app operations.
        val mode = appOps!!.checkOpNoThrow(AppOpsManager.OPSTR_GET_USAGE_STATS, Process.myUid(), context.packageName)
        // Checks the current mode for the GET_USAGE_STATS operation for the calling UID and package name.
        // If the permission is granted, return true.
        return mode == AppOpsManager.MODE_ALLOWED
    } // method

    fun requestUsagePermission(context: Context) {
        // This method initiates a request for usage access permission from the user.
        if (!isUsagePermissionGranted(context)) {
            // Checks if the permission is not already granted.
            try {
                val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
                // Creates an intent to open the usage access settings screen.
                intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                // Sets the flag to start the activity in a new task.
                intent.data = Uri.parse("package:" + context.packageName)
                // Sets the data URI to the current application's package name to direct the user to the correct settings page.
                context.startActivity(intent)
                // Starts the settings activity.
            } catch (e: Exception) {
                // Catches any exception that occurs while trying to start the activity.
                val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
                // Creates a new intent in case the previous one failed.
                intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                // Sets the flag again to ensure the activity starts correctly.
                context.startActivity(intent)
                // Starts the settings activity.
            }
        }
    } // method
}