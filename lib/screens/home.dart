// lib/screens/home.dart
import 'package:admin_app/screens/add_child_scree.dart';
import 'package:admin_app/widget/home_page_content.dart';
import 'package:flutter/material.dart';
import 'children_list_screen.dart';
import 'inventory_screen.dart';
import 'add_vaccine_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Worker Portal'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Health Worker Portal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.child_care),
              title: const Text('Children Registry'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChildrenListScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.medical_services),
              title: const Text('Vaccine Inventory'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InventoryScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: const HomePageContent(),
    );
  }
}
