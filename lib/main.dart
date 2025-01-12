import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/children_provider.dart';
import 'providers/inventory_provider.dart';
import 'screens/home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChildrenProvider()),
        ChangeNotifierProvider(create: (_) => InventoryProvider()),
      ],
      child: const HealthWorkerApp(),
    ),
  );
}

class HealthWorkerApp extends StatelessWidget {
  const HealthWorkerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Worker Portal',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const HomePage(),
    );
  }
}