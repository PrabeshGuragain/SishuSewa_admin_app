// lib/screens/add_growth_record_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/child.dart';
import '../providers/children_provider.dart';

class AddGrowthRecordScreen extends StatefulWidget {
  final String childId;

  const AddGrowthRecordScreen({super.key, required this.childId});

  @override
  State<AddGrowthRecordScreen> createState() => _AddGrowthRecordScreenState();
}

class _AddGrowthRecordScreenState extends State<AddGrowthRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  DateTime _date = DateTime.now();

  double calculateBMI(double height, double weight) {
    // Convert height to meters
    double heightInMeters = height / 100;
    // BMI formula: weight (kg) / (height (m))²
    return weight / (heightInMeters * heightInMeters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Growth Record'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            ListTile(
              title: Text('Date: ${_date.toString().split(' ')[0]}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() => _date = date);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _heightController,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter height';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter weight';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final height = double.parse(_heightController.text);
                  final weight = double.parse(_weightController.text);
                  final bmi = calculateBMI(height, weight);

                  final provider = context.read<ChildrenProvider>();
                  provider.updateGrowthRecord(
                    widget.childId,
                    GrowthRecord(
                      date: _date,
                      height: height,
                      weight: weight,
                      bmi: double.parse(bmi.toStringAsFixed(1)),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Growth Record'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}