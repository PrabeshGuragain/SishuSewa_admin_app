// lib/screens/add_vaccine_record_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/child.dart';
import '../providers/children_provider.dart';
import '../providers/inventory_provider.dart';

class AddVaccineRecordScreen extends StatefulWidget {
  final String childId;

  const AddVaccineRecordScreen({super.key, required this.childId});

  @override
  State<AddVaccineRecordScreen> createState() => _AddVaccineRecordScreenState();
}

class _AddVaccineRecordScreenState extends State<AddVaccineRecordScreen> {
  String? _selectedVaccineId;
  DateTime _dueDate = DateTime.now();
  final _batchNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vaccine Record'),
      ),
      body: Consumer<InventoryProvider>(
        builder: (context, inventoryProvider, child) {
          final vaccines = inventoryProvider.inventory;

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              DropdownButtonFormField<String>(
                value: _selectedVaccineId,
                decoration: const InputDecoration(
                  labelText: 'Select Vaccine',
                  border: OutlineInputBorder(),
                ),
                items: vaccines.map((vaccine) {
                  return DropdownMenuItem<String>(
                    value: vaccine.vaccineId,
                    child: Text(vaccine.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedVaccineId = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text('Due Date: ${_dueDate.toString().split(' ')[0]}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() => _dueDate = date);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _batchNumberController,
                decoration: const InputDecoration(
                  labelText: 'Batch Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _selectedVaccineId == null
                    ? null
                    : () {
                        final vaccine = vaccines.firstWhere(
                          (v) => v.vaccineId == _selectedVaccineId,
                        );

                        final provider = context.read<ChildrenProvider>();
                        provider.updateVaccineRecord(
                          widget.childId,
                          VaccineRecord(
                            vaccineName: vaccine.name,
                            dueDate: _dueDate,
                            batchNumber: _batchNumberController.text.isNotEmpty
                                ? _batchNumberController.text
                                : null,
                          ),
                        );

                        // Update inventory
                        if (vaccine.quantity > 0) {
                          context.read<InventoryProvider>().updateVaccineStock(
                                vaccine.vaccineId,
                                vaccine.quantity - 1,
                              );
                        }

                        Navigator.pop(context);
                      },
                child: const Text('Save Vaccine Record'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _batchNumberController.dispose();
    super.dispose();
  }
}