import 'package:admin_app/models/inventory.dart';
import 'package:flutter/material.dart';

class VaccineInventoryTile extends StatelessWidget {
  final VaccineInventory vaccine;

  const VaccineInventoryTile({super.key, required this.vaccine});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(vaccine.name),
      subtitle: Text('Batch: ${vaccine.batchNumber}'),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Quantity: ${vaccine.quantity}'),
          Text('Expires: ${vaccine.expiryDate.toString().split(' ')[0]}'),
        ],
      ),
      onTap: () {
        // TODO: Navigate to inventory details screen
      },
    );
  }
}