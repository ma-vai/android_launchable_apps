package com.verseai.android_launchable_apps

import android.app.usage.UsageStatsManager
import android.app.usage.UsageEvents
import android.content.Context

object UsageStats {
    /**
     * Queries events between a given time range.
     *
     * @param context The application context.
     * @param startDate The start timestamp for the query.
     * @param endDate The end timestamp for the query.
     * @return A list of maps containing event details.
     */
    fun queryEvents(context: Context, startDate: Long, endDate: Long): ArrayList<Map<String, String>> {
        val usm = context.getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val events: UsageEvents = usm.queryEvents(startDate, endDate)
        val eventsList: ArrayList<Map<String, String>> = arrayListOf()

        while (events.hasNextEvent()) {
            val event = UsageEvents.Event()
            events.getNextEvent(event)

            val e = mutableMapOf(
                "eventType" to event.eventType.toString(),
                "timeStamp" to event.timeStamp.toString(),
                "packageName" to event.packageName.toString(),
                "className" to event.className
            )

            e["shortcutId"] = event.shortcutId
            eventsList.add(e)
        }
        return eventsList
    }
}