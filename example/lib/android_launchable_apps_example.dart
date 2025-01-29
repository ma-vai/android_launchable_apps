import 'package:android_launchable_apps/models.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:android_launchable_apps/android_launchable_apps.dart';

void main() {
  runApp(const MyApp());
}

/// Example application to display android user launchable apps
class MyApp extends StatefulWidget {
  /// Example application to display android user launchable apps
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _androidLaunchableAppsPlugin = AndroidLaunchableApps();

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

    final appList =
        await _androidLaunchableAppsPlugin.getLaunchableApplications();
    appList.sort((a, b) => a.displayName.compareTo(b.displayName));

    setState(() {
      apps = appList;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            child: (isLoading)
                ? const CircularProgressIndicator()
                : _buildAppsUI(),
          ),
        ),
      ),
    );
  }

  Widget _buildAppsUI() {
    return ListView.separated(
      itemCount: apps.length,
      separatorBuilder: (context, index) => const Divider(height: 20),
      itemBuilder: (context, index) {
        final app = apps[index];
        return Row(
          children: [
            Image.memory(app.iconBytes, height: 35, width: 35),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(app.displayName,
                      style: Theme.of(context).textTheme.labelLarge),
                  Text(app.categoryName),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
