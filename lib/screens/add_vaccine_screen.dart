// lib/screens/add_vaccine_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/vaccine_inventory.dart';
import '../providers/inventory_provider.dart';

class AddVaccineScreen extends StatefulWidget {
  const AddVaccineScreen({super.key});

  @override
  State<AddVaccineScreen> createState() => _AddVaccineScreenState();
}

class _AddVaccineScreenState extends State<AddVaccineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _batchNumberController = TextEditingController();
  DateTime? _expiryDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Vaccine Stock'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Vaccine Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter vaccine name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter quantity';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _batchNumberController,
              decoration: const InputDecoration(
                labelText: 'Batch Number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter batch number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(_expiryDate == null 
                ? 'Select Expiry Date' 
                : 'Expiry: ${_expiryDate.toString().split(' ')[0]}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(const Duration(days: 365)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 3650)),
                );
                if (date != null) {
                  setState(() => _expiryDate = date);
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() && _expiryDate != null) {
                  final provider = context.read<InventoryProvider>();
                  provider.addVaccineStock(
                    VaccineInventory(
                      vaccineId: DateTime.now().toString(), // Generate unique ID
                      name: _nameController.text,
                      quantity: int.parse(_quantityController.text),
                      expiryDate: _expiryDate!,
                      batchNumber: _batchNumberController.text,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Vaccine Stock'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _batchNumberController.dispose();
    super.dispose();
  }
}