// lib/routes/routes.dart
import 'package:admin_app/screens/add_child_scree.dart';
import 'package:admin_app/screens/child_detail_scree.dart';
import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../screens/children_list_screen.dart';
import '../screens/inventory_screen.dart';
import '../screens/add_vaccine_screen.dart';
import '../models/child.dart';

class AppRoutes {
  static const String home = '/';
  static const String childrenList = '/children-list';
  static const String addChild = '/add-child';
  static const String inventory = '/inventory';
  static const String addVaccine = '/add-vaccine';
  static const String childDetails = '/child-details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      
      case childrenList:
        return MaterialPageRoute(builder: (_) => const ChildrenListScreen());
      
      case addChild:
        return MaterialPageRoute(builder: (_) => const AddChildScreen());
      
      case inventory:
        return MaterialPageRoute(builder: (_) => const InventoryScreen());
      
      case addVaccine:
        return MaterialPageRoute(builder: (_) => const AddVaccineScreen());
      
      case childDetails:
        final child = settings.arguments as Child;
        return MaterialPageRoute(
          builder: (_) => ChildDetailsScreen(child: child),
        );
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}