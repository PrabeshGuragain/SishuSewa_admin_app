// lib/screens/child_details_screen.dart
import 'package:flutter/material.dart';
import '../models/child.dart';
import 'add_growth_record_screen.dart';
import 'add_vaccine_record_screen.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddGrowthRecordScreen(
                      childId: child.id,
                    ),
                  ),
                );
              },
            ),
          ),
          ...child.growthRecords.map((record) => ListTile(
                title: Text('Height: ${record.height}cm, Weight: ${record.weight}kg'),
                subtitle: Text(
                    'Date: ${record.date.toString().split(' ')[0]}, BMI: ${record.bmi}'),
              )),
          const Divider(),
          ListTile(
            title: const Text('Vaccine Records'),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddVaccineRecordScreen(
                      childId: child.id,
                    ),
                  ),
                );
              },
            ),
          ),
          ...child.vaccineRecords.map((record) => ListTile(
                title: Text(record.vaccineName),
                subtitle: Text(
                    'Due: ${record.dueDate.toString().split(' ')[0]}'),
                trailing: record.administeredDate != null
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : null,
              )),
        ],
      ),
    );
  }
}