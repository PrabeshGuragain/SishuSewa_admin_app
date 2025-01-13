import 'package:admin_app/models/parrent.dart';
import 'package:flutter/material.dart';
import '../providers/children_provider.dart';
import 'package:admin_app/models/vaccine_inventory.dart';
import 'package:provider/provider.dart';

class AddParentScreen extends StatefulWidget {
  final String childId;

  const AddParentScreen({super.key, required this.childId});

  @override
  State<AddParentScreen> createState() => _AddParentScreenState();
}

class _AddParentScreenState extends State<AddParentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Parent Details'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Parent Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter parent name' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter phone number' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter address' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveParent,
              child: const Text('Save Parent Details'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveParent() {
    if (_formKey.currentState?.validate() ?? false) {
      final parent = Parent(
        id: DateTime.now().toString(),
        name: _nameController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        email: _emailController.text,
      );

    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}