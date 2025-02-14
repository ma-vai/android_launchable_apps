import 'dart:async';

import 'package:flutter/material.dart';

import 'package:android_launchable_apps/android_launchable_apps.dart';
import 'package:android_launchable_apps/models.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

/// Example application to display android user launchable apps
class MyApp extends StatefulWidget {
  /// Example application to display android user launchable apps
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = false;
  List<AndroidAppInfo> apps = [];

  @override
  void initState() {
    super.initState();
    _refreshApps();
  }

  Future<void> _refreshApps() async {
    setState(() {
      isLoading = true;
    });

    final appList = await AndroidLaunchableApps.getLaunchableApplications();
    appList.sort((a, b) => a.displayName.compareTo(b.displayName));

    setState(() {
      apps = appList;
      isLoading = false;
    });
  }

  Future<void> _checkUsagePermission() async {
    bool hasPermission = await AndroidLaunchableApps.isUsagePermissionGranted();
    await _popMessage('Is Usage Permission Granted? $hasPermission');
  }

  Future<void> _requestUsagePermission() async {
    await AndroidLaunchableApps.requestUsagePermission();
  }

  Future<void> _checkAppUsage(AndroidAppInfo app) async {
    bool hasPermission = await AndroidLaunchableApps.isUsagePermissionGranted();
    if (!hasPermission) {
      await _popMessage(
          'Usage Permission has not been granted. Click the "request" button in this example app.');
      return;
    }

    final DateTime startDate = DateUtils.dateOnly(DateTime.now());
    final DateTime endDate = DateTime(
        startDate.year,
        startDate.month,
        startDate.day + 1,
        0,
        0,
        0,
        startDate.millisecond - startDate.millisecond - 1);
    final usages = await AndroidLaunchableApps.queryEvents(startDate, endDate);
    final packageUsages = usages.where((u) => u.packageName == app.packageName);
    await _popMessage(
        'Events of today for ${app.displayName} (${app.packageName})\n\n${packageUsages.map((e) => e.toString()).join('\n')}');
  }

  Future<void> _popMessage(String text) async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          content: SingleChildScrollView(child: Text(text)),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('OK')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Launchable Apps Example'),
        actions: [
          IconButton(
              tooltip: 'Refresh Apps',
              onPressed: _refreshApps,
              icon: const Icon(Icons.refresh_outlined)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child:
              (isLoading) ? const CircularProgressIndicator() : _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      spacing: 10,
      children: [
        _buildUsageUI(),
        Expanded(child: _buildAppsUI()),
      ],
    );
  }

  Widget _buildUsageUI() {
    return Wrap(
      children: [
        ElevatedButton(
            onPressed: _checkUsagePermission,
            child: const Text('Check Usage Permission')),
        ElevatedButton(
            onPressed: _requestUsagePermission,
            child: const Text('Request Usage Permission')),
      ],
    );
  }

  Widget _buildAppsUI() {
    return ListView.separated(
      itemCount: apps.length,
      separatorBuilder: (context, index) => const Divider(height: 20),
      itemBuilder: (context, index) {
        final app = apps[index];
        return Row(
          spacing: 10,
          children: [
            Image.memory(app.iconBytes, height: 35, width: 35),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(app.displayName,
                      style: Theme.of(context).textTheme.labelLarge),
                  Text(app.categoryName),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () => _checkAppUsage(app),
                child: const Text('Usage')),
          ],
        );
      },
    );
  }
}
