import 'package:flutter/material.dart';
import '../models/child.dart';

class ChildDetailsScreen extends StatelessWidget {
  final Child child;

  const ChildDetailsScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(child.name),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Date of Birth'),
            subtitle: Text(child.dateOfBirth.toString().split(' ')[0]),
          ),
          if (child.parentAppId != null)
            ListTile(
              title: const Text('Parent App ID'),
              subtitle: Text(child.parentAppId!),
            ),
          const Divider(),
          ListTile(
            title: const Text('Growth Records'),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Navigate to add growth record screen
              },
            ),
          ),
          // ... List of growth records
          const Divider(),
          ListTile(
            title: const Text('Vaccine Records'),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Navigate to add vaccine record screen
              },
            ),
          ),
          // ... List of vaccine records
          
        ],
      ),
    );
  }
}
