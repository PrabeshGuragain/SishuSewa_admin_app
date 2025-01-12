import 'package:admin_app/providers/inventory_provider.dart';
import 'package:admin_app/widget/vaccine_inventory_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccine Inventory'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add inventory screen
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<InventoryProvider>(
        builder: (context, provider, child) {
          if (provider.inventory.isEmpty) {
            return const Center(
              child: Text('No vaccines in inventory'),
            );
          }

          return ListView.builder(
            itemCount: provider.inventory.length,
            itemBuilder: (context, index) {
              final vaccine = provider.inventory[index];
              return VaccineInventoryTile(vaccine: vaccine);
            },
          );
        },
      ),
    );
  }
}
