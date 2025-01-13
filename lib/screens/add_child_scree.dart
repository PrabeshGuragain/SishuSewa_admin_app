// lib/screens/add_child_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/child.dart';
import '../providers/children_provider.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key});

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime? _dateOfBirth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Child'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Child Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter child name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(_dateOfBirth == null 
                ? 'Select Date of Birth' 
                : 'DoB: ${_dateOfBirth.toString().split(' ')[0]}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() => _dateOfBirth = date);
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() && _dateOfBirth != null) {
                  final provider = context.read<ChildrenProvider>();
                  provider.addChild(
                    Child(
                      id: DateTime.now().toString(), // Temporary ID
                      name: _nameController.text,
                      dateOfBirth: _dateOfBirth!,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Child'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}