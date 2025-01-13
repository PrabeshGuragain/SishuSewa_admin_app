// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/routes.dart';
import 'providers/children_provider.dart';
import 'providers/inventory_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChildrenProvider()),
        ChangeNotifierProvider(create: (_) => InventoryProvider()),
      ],
      child: MaterialApp(
        title: 'Health Worker Portal',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}