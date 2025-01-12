
import 'package:admin_app/models/child.dart';
import 'package:flutter/material.dart';

class ChildListTile extends StatelessWidget {
  final Child child;

  const ChildListTile({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(child.name),
      subtitle: Text('DOB: ${child.dateOfBirth.toString().split(' ')[0]}'),
      trailing: Icon(
        child.parentAppId != null ? Icons.link : Icons.link_off,
        color: child.parentAppId != null ? Colors.green : Colors.grey,
      ),
      onTap: () {
        // TODO: Navigate to child details screen
      },
    );
  }
}
