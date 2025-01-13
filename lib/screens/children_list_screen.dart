import 'package:admin_app/providers/children_provider.dart';
import 'package:admin_app/screens/add_child_scree.dart';
import 'package:admin_app/widget/child_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChildrenListScreen extends StatelessWidget {
  const ChildrenListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Children Registry'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
              Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddChildScreen()),
    );
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<ChildrenProvider>(
        builder: (context, provider, child) {
          if (provider.children.isEmpty) {
            return const Center(
              child: Text('No children registered yet'),
            );
          }

          return ListView.builder(
            itemCount: provider.children.length,
            itemBuilder: (context, index) {
              final child = provider.children[index];
              return ChildListTile(child: child);
            },
          );
        },
      ),
    );
  }
}