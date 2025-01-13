import 'package:admin_app/providers/children_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/vaccine_inventory.dart';
import '../providers/inventory_provider.dart';


class InventoryDetailsScreen extends StatelessWidget {
  final VaccineInventory vaccine;

  const InventoryDetailsScreen({super.key, required this.vaccine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vaccine.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Current Stock'),
            subtitle: Text(vaccine.quantity.toString()),
          ),
          ListTile(
            title: const Text('Batch Number'),
            subtitle: Text(vaccine.batchNumber),
          ),
          ListTile(
            title: const Text('Expiry Date'),
            subtitle: Text(vaccine.expiryDate.toString().split(' ')[0]),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Show dialog to update stock
              showDialog(
                context: context,
                builder: (context) => UpdateStockDialog(vaccine: vaccine),
              );
            },
            child: const Text('Update Stock'),
          ),
        ],
      ),
    );
  }
}

class UpdateStockDialog extends StatefulWidget {
  final VaccineInventory vaccine;

  const UpdateStockDialog({super.key, required this.vaccine});

  @override
  State<UpdateStockDialog> createState() => _UpdateStockDialogState();
}

class _UpdateStockDialogState extends State<UpdateStockDialog> {
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(
      text: widget.vaccine.quantity.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Stock'),
      content: TextField(
        controller: _quantityController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'New Quantity',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final quantity = int.tryParse(_quantityController.text);
            if (quantity != null) {
              context.read<InventoryProvider>().updateVaccineStock(
                widget.vaccine.vaccineId,
                quantity,
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Update'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}